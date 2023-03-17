//
//  ViewController.swift
//  Collapsible Table using UITable
//
//  Created by Tim Chow on 17/3/2023.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        var table = ServiceCollapsibleTableViewController(sections: sectionsData, estimatedHeight: 500)
        self.view.addSubview(table.view)
        table.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 120).isActive = true
        table.view.bottomAnchor.constraint(lessThanOrEqualTo: self.view.bottomAnchor, constant: -10).isActive = true
        table.view.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        table.view.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        //calculate height of table after constraints are set
        let height = table.view.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        let heightConstraint = table.view.heightAnchor.constraint(equalToConstant: CGFloat(44 * sectionsData.count))
        heightConstraint.isActive = true
        table.attachHeightConstraint(heightConstraint)
        table.view.translatesAutoresizingMaskIntoConstraints = false
        table.view.backgroundColor = .white
        table.view.layer.cornerRadius = 10
    }


}

