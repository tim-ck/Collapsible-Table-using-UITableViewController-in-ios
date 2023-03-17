import UIKit

//multipleTab table cell
class CollapsiblesTableViewCell: UITableViewCell {

    //ui element for multiple tab view
    let titleLabel = UILabel()
    let tabsSegmentControl = CustomeSegmentControl()
    var detailTextView = UITextView()
    let cellStackView = UIStackView()
    var tabItems: [TabItem] = []
    var selectedIndex: Int = 0
    var estimatedHeight: CGFloat = 500
    var contentViewHeightConstraint: NSLayoutConstraint?
    // MARK: Initalizers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        let marginGuide = contentView.layoutMarginsGuide

        contentViewHeightConstraint = contentView.heightAnchor.constraint(equalToConstant: estimatedHeight)
        contentViewHeightConstraint!.isActive = true
        contentView.addSubview(cellStackView)
        cellStackView.translatesAutoresizingMaskIntoConstraints = false
        cellStackView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        cellStackView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        cellStackView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        cellStackView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        cellStackView.axis = .vertical
        cellStackView.distribution = .fill
        cellStackView.alignment = .fill
        cellStackView.spacing = 4.0
        cellStackView.addArrangedSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.systemFont(ofSize: 20.0)
        titleLabel.text = "Test"
        cellStackView.addArrangedSubview(tabsSegmentControl)
        tabsSegmentControl.heightAnchor.constraint(equalToConstant: 60.0).isActive = true
        tabsSegmentControl.items = ["服務條款", "服務內容", "服務時段"]
        tabsSegmentControl.selectedIndex = 0
        tabsSegmentControl.addTarget(self, action: #selector(genServiceContent) , for: .valueChanged)
        cellStackView.addArrangedSubview(detailTextView)
        titleLabel.font = UIFont.systemFont(ofSize: 20.0)
        detailTextView.text = "Test"
        detailTextView.isEditable = false
        detailTextView.isScrollEnabled = true
        detailTextView.font = UIFont.systemFont(ofSize: 15.0)


    }

    func updateContentViewHeightConstraint(estimatedHeight: CGFloat) {
        self.estimatedHeight = estimatedHeight
        contentViewHeightConstraint?.constant = estimatedHeight
        contentView.layoutIfNeeded()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    func setTitleLabelVisible(_ visible: Bool) {
        titleLabel.isHidden = !visible
    }

    func setTabsSegmentControlVisible(_ visible: Bool) {
        tabsSegmentControl.isHidden = !visible
    }

    func setDetailTextViewVisible(_ visible: Bool) {
        detailTextView.isHidden = !visible
    }

    func setTitleAndSegmentControlVisible(_ visible: Bool) {
        setTitleLabelVisible(visible)
        setTabsSegmentControlVisible(visible)
    }
    
    func updateCell(title: String = "",tabItems: [TabItem],headerBackgroundColor: UIColor = UIColor.blue) {
        self.tabItems = tabItems
        let tabItemsCount = tabItems.count
        if tabItemsCount <= 1 {
            setTitleAndSegmentControlVisible(false)
            let textVal = tabItems[0].detail
            detailTextView.attributedText = textVal.data.attributedString
            detailTextView.layoutIfNeeded()
            return
        }
        setTitleAndSegmentControlVisible(true)
        titleLabel.text = title
        var title: [String] = []
        for i in 0..<tabItemsCount {
            title.append(tabItems[i].tabTitle)
        }
        tabsSegmentControl.items = title
        tabsSegmentControl.thumbColor = headerBackgroundColor

        tabsSegmentControl.selectedIndex = selectedIndex
        let textVal = tabItems[selectedIndex].detail
        detailTextView.attributedText = textVal.data.attributedString
        detailTextView.layoutIfNeeded()
    }
    @objc func genServiceContent(){
        if tabItems.count <= 1 {
            return
        }
        selectedIndex = tabsSegmentControl.selectedIndex
        var textVal = ""
        textVal = tabItems[selectedIndex].detail
        detailTextView.attributedText = textVal.data.attributedString
        detailTextView.layoutIfNeeded()
    }
}
