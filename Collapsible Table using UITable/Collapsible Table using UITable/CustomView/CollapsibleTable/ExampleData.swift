import UIKit

func ExapmleText1() -> String{
    return "<h3>Header 3 tab 1</h3>" +
            "<ul>" +
            "<li>list item 1</li>" +
            "<li>list item 2</li>" +
            "<li>list item 3</li>" +
            "</ul>" +
            "<br/>" +
            "<h3>Header 3</h3>" +
            "<ul>" +
            "<li>list item 1</li>" +
            "<li>list item 2</li>" +
            "<li>list item 3</li>" +
            "</ul>" +
            "<br/>"

}

func ExapmleText11() -> String{
   return "<h3>Header 3 tab 2</h3>" +
    "<ul>" +
    "<li>list item 1</li>" +
    "<li>list item 2</li>" +
    "<li>list item 3</li>" +
    "</ul>" +
    "<br/>" +
    "<h3>Header 3</h3>" +
    "<ul>" +
    "<li>list item 1</li>" +
    "<li>list item 2</li>" +
    "<li>list item 3</li>" +
    "</ul>" +
    "<br/>"

}

func ExapmleText12() -> String{
    return "<h3>Header 3 tab 3</h3>" +
     "<ul>" +
     "<li>list item 1</li>" +
     "<li>list item 2</li>" +
     "<li>list item 3</li>" +
     "</ul>" +
     "<br/>" +
     "<h3>Header 3</h3>" +
     "<ul>" +
     "<li>list item 1</li>" +
     "<li>list item 2</li>" +
     "<li>list item 3</li>" +
     "</ul>" +
     "<br/>"
}

func ExapmleText13() -> String{
    return "<h3>Header 3 tab 4</h3>" +
     "<ul>" +
     "<li>list item 1</li>" +
     "<li>list item 2</li>" +
     "<li>list item 3</li>" +
     "</ul>" +
     "<br/>" +
     "<h3>Header 3</h3>" +
     "<ul>" +
     "<li>list item 1</li>" +
     "<li>list item 2</li>" +
     "<li>list item 3</li>" +
     "</ul>" +
     "<br/>"

}



public var sectionsData: [Section] = [
    Section(name: "Section 0", items: [
        TableItem(title: "", tabItems: [TabItem(tabTitle: "", detail: ExapmleText1())])
    ], headerBackgroundColor: UIColor(hex: 0xb24850), collapsed: true),
    Section(name: "Section 1", items: [
        TableItem(title: "Title", tabItems: [TabItem(tabTitle: "Tab 1", detail: ExapmleText1()),
                             TabItem(tabTitle: "Tab 2", detail: ExapmleText11()),
                             TabItem(tabTitle: "Tab 3", detail: ExapmleText12()),
                             TabItem(tabTitle: "Tab 4", detail: ExapmleText13())])
    ], headerBackgroundColor: UIColor(hex: 0x48b271), collapsed: true),
        Section(name: "Section 2", items: [
            TableItem(title: "", tabItems: [TabItem(tabTitle: "", detail: ExapmleText1())])
        ], headerBackgroundColor: UIColor(hex: 0x48b842), collapsed: true),
        Section(name: "Section 3", items: [
            TableItem(title: "", tabItems: [TabItem(tabTitle: "", detail: ExapmleText1())])
        ], headerBackgroundColor: UIColor(hex: 0x43231b), collapsed: true),
]
