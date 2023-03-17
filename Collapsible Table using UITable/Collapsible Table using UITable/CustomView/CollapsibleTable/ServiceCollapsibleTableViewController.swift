import UIKit

//
// MARK: - View Controller
//
class ServiceCollapsibleTableViewController: UITableViewController {

    //data
    var sections: [Section]! = []
    var heightConstraint: NSLayoutConstraint?
    var headerFontSize: CGFloat = 16.0{
        didSet {
            tableView.reloadData()
        }
    }
    var estimatedHeight: CGFloat = 44.0*4
    init(sections: [Section]!, headerFontSize: CGFloat = 16.0, estimatedHeight: CGFloat) {
        self.sections = sections
        self.headerFontSize = headerFontSize
        self.estimatedHeight = estimatedHeight
        super.init(style: UITableView.Style.plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // function to be called from parent view
    override func viewDidLoad() {
        super.viewDidLoad()
        // Auto resizing the height of the cell
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableView.automaticDimension

        //no spacing between cells and header and section)
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
    }

    func attachHeightConstraint(_ heightConstraint: NSLayoutConstraint) {
        self.heightConstraint = heightConstraint
    }
    func isAllSectionCollapsed() -> Bool{
        for section in sections {
            if !section.collapsed {
                return false
            }
        }
        return true
    }
    func selectedSection() -> Int{
        for (index, section) in sections.enumerated() {
            if !section.collapsed {
                return index
            }
        }
        return -1
    }
    func updateTableHeightAccordingToContent() {
        if (heightConstraint != nil) {
            // Store the old height and old center Y constraint value
            let oldCenterY = view.center.y
            let oldHeight = heightConstraint!.constant
            if isAllSectionCollapsed() {
                heightConstraint!.constant = 44.0 * CGFloat(self.sections.count)
                view.center.y = oldCenterY
                UIView.animate(withDuration: 0.3) {
                    self.view.layoutIfNeeded()
                    // Set the final center of the table view after the animation
                    self.view.center.y = oldCenterY + (self.heightConstraint!.constant - oldHeight) / 2
                }
                return
            }
            if selectedSection() >= 0{
                if let height = sections[selectedSection()].estimatedHeight{
                    heightConstraint!.constant = 44.0 * CGFloat(self.sections.count) + height > estimatedHeight ? estimatedHeight : 44.0 * CGFloat(self.sections.count) + height
                }
                else{
                    heightConstraint!.constant = estimatedHeight
                }
            }
            else{
                heightConstraint!.constant = estimatedHeight
            }
            view.center.y = oldCenterY
            // Animate the constraint changes
            UIView.animate(withDuration: 0.355) {
                self.view.layoutIfNeeded()
                // Set the final center of the table view after the animation
                self.view.center.y = oldCenterY + (self.heightConstraint!.constant - oldHeight) / 2
            }
        }
    }

}


//
// MARK: - View Controller DataSource and Delegate
//
extension ServiceCollapsibleTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }

    // Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollapsiblesTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsiblesTableViewCell ??
                CollapsiblesTableViewCell(style: .default, reuseIdentifier: "cell")
        let numOfRow = sections.count > 4 ? 4 : sections.count
        if let height = sections[indexPath.section].estimatedHeight{
            cell.updateContentViewHeightConstraint(estimatedHeight: height)
        }else{
            cell.updateContentViewHeightConstraint(estimatedHeight: estimatedHeight - 44.0 * CGFloat(numOfRow))
        }
            let items = sections[indexPath.section].items[indexPath.row]
           cell.updateCell(title: items.title ,tabItems: items.tabItems, headerBackgroundColor: sections[indexPath.section].headerBackgroundColor)
        //set cell not selectable
        cell.selectionStyle = .none
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    // Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")

        header.titleLabel.text = sections[section].name
        header.contentView.backgroundColor = sections[section].headerBackgroundColor
        header.section = section
        header.delegate = self
        header.titleLabel.font = UIFont.systemFont(ofSize: headerFontSize)
        return header
    }

    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44.0
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }

}

//
// MARK: - Section Header Delegate
//
extension ServiceCollapsibleTableViewController: CollapsibleTableViewHeaderDelegate {

    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        if sections.count > 4 {
            var needCloseTab = false
            for i in 0..<sections.count {
                if i != section && sections[i].collapsed == false {
                    needCloseTab = true
                    sections[i].collapsed = true
                    self.updateTableHeightAccordingToContent()
                    tableView.reloadSections(NSIndexSet(index: i) as IndexSet, with: .none)
                }
            }
            //reloadSections after 0.3 second
            if needCloseTab {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.sections[section].collapsed = collapsed
                    self.updateTableHeightAccordingToContent()
                    self.tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .none)
                }
                return
            }

            // Toggle collapse

            self.sections[section].collapsed = collapsed
            self.updateTableHeightAccordingToContent()
            self.tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .none)

            return
            //collapsed other tab
        }
        var needCloseTab = false
        for i in 0..<sections.count {
            if i != section && sections[i].collapsed == false {
                needCloseTab = true
                sections[i].collapsed = true
                updateTableHeightAccordingToContent()
                tableView.reloadSections(NSIndexSet(index: i) as IndexSet, with: .none )
            }
        }
        //reloadSections after 0.3 second
        if needCloseTab {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                self.sections[section].collapsed = collapsed
                self.updateTableHeightAccordingToContent()
                self.tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .none)
            }
            return
        }


            // Toggle collapse
            sections[section].collapsed = collapsed
            updateTableHeightAccordingToContent()
            tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .none)
            //collapsed other tab

    }

}

public struct TabItem{
    var tabTitle: String
    var detail: String
    public init( tabTitle: String, detail: String) {
        self.tabTitle = tabTitle
        self.detail = detail
    }
}

public struct TableItem {
    var title: String
    var tabItems: [TabItem]
    public init(title: String, tabItems: [TabItem]) {
        self.title = title
        self.tabItems = tabItems
    }
}

public struct Section {
    var name: String
    var items: [TableItem]
    var collapsed: Bool
    var headerBackgroundColor: UIColor
    var estimatedHeight: CGFloat?
    public init(name: String, items: [TableItem], headerBackgroundColor: UIColor, collapsed: Bool = false, estimatedHeight: CGFloat? = nil) {
        self.name = name
        self.items = items
        self.headerBackgroundColor = headerBackgroundColor
        self.collapsed = collapsed
        if let estimatedHeight = estimatedHeight {
            self.estimatedHeight = estimatedHeight
        }
    }
}
