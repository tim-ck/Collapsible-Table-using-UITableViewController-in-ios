import UIKit

func getExampleUIView() -> String{
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

func getExampleUIView1() -> String{
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

func getExampleUIView2() -> String{
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

func getExampleUIView3() -> String{
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
        TableItem(title: "", tabItems: [TabItem(tabTitle: "", detail: getExampleUIView())])
    ], headerBackgroundColor: UIColor(hex: 0xb24850), collapsed: true),
    Section(name: "Section 1", items: [
        TableItem(title: "Title", tabItems: [TabItem(tabTitle: "Tab 1", detail: getExampleUIView()),
                             TabItem(tabTitle: "Tab 2", detail: getExampleUIView1()),
                             TabItem(tabTitle: "Tab 3", detail: getExampleUIView2()),
                             TabItem(tabTitle: "Tab 4", detail: getExampleUIView3())])
    ], headerBackgroundColor: UIColor(hex: 0x48b271), collapsed: true),
        Section(name: "Section 2", items: [
            TableItem(title: "", tabItems: [TabItem(tabTitle: "", detail: getExampleUIView())])
        ], headerBackgroundColor: UIColor(hex: 0x48b842), collapsed: true),
        Section(name: "Section 3", items: [
            TableItem(title: "", tabItems: [TabItem(tabTitle: "", detail: getExampleUIView())])
        ], headerBackgroundColor: UIColor(hex: 0x43231b), collapsed: true),
]
