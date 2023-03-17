//
// Created by administrator on 7/3/2023.
// Copyright (c) 2023 Administrator. All rights reserved.
//

import UIKit

class CustomeSegmentControl: UIControl {
private var labels = [UILabel]()
var thumbView = UIView()

var items: [String] = ["Item 1", "Item 2", "Item 3"] {
  didSet {
      setupLabels()
  }
}

var layoutHeight : Int = 60 {
 didSet {
     layer.cornerRadius = CGFloat(layoutHeight / 2)
 }
}

var selectedIndex : Int = 0 {
 didSet {
     displayNewSelectedIndex()
 }
}

var selectedLabelColor : UIColor = UIColor.white {
 didSet {
     setSelectedColors()
 }
}

var unselectedLabelColor : UIColor = UIColor.black{
 didSet {
     setSelectedColors()
 }
}

var thumbColor : UIColor = UIColor.blue {
 didSet {
     setSelectedColors()
 }
}

var borderColor : UIColor = UIColor.black {
 didSet {
     layer.borderColor = borderColor.cgColor
 }
}
var font : UIFont! = UIFont.systemFont(ofSize: 12) {
 didSet {
     setFont()
 }
}

override init(frame: CGRect) {
 super.init(frame: frame)
 setupView()
}

required init(coder: NSCoder) {
 super.init(coder: coder)!
 setupView()
}

func setupView(){

 layer.cornerRadius = CGFloat(layoutHeight / 2)
 layer.borderColor = borderColor.cgColor
 layer.borderWidth = 0.5

 backgroundColor = UIColor.clear

 setupLabels()

 addIndividualItemConstraints(items: labels, mainView: self, padding: 0)

 insertSubview(thumbView, at: 0)
}

func setupLabels(){

 for label in labels {
     label.removeFromSuperview()
 }

 labels.removeAll(keepingCapacity: true)

 for index in 1...items.count {

     let label = UILabel(frame: CGRectMake(0, 0, 70, 40))
     label.text = items[index - 1]
     label.backgroundColor = UIColor.clear
     label.textAlignment = .center
     label.font = .systemFont(ofSize: 15, weight: .heavy)
     label.textColor = index == 1 ? selectedLabelColor : unselectedLabelColor
     label.translatesAutoresizingMaskIntoConstraints = false
     let cornerRadius = layoutHeight/2
     label.layer.borderWidth = 0.25
     label.layer.borderColor = UIColor.black.cgColor
     label.layer.cornerRadius = CGFloat(cornerRadius)
     if index - 1 == 0 {
         if #available(iOS 11.0, *) {
             label.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
         }else{
             let path = UIBezierPath(roundedRect: label.bounds,
                     byRoundingCorners: [.bottomLeft, .topLeft],
                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

             let maskLayer = CAShapeLayer()
             maskLayer.path = path.cgPath

             label.layer.mask = maskLayer
         }
     }else if index == items.count {
         if #available(iOS 11.0, *) {
             label.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
         }else{
             let path = UIBezierPath(roundedRect: label.bounds,
                     byRoundingCorners: [.topRight, .bottomRight],
                     cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

             let maskLayer = CAShapeLayer()
             maskLayer.path = path.cgPath

             label.layer.mask = maskLayer
         }
     }else{
         label.layer.cornerRadius = 0
     }
     self.addSubview(label)
     labels.append(label)
 }

 addIndividualItemConstraints(items: labels, mainView: self, padding: 0)
}

override func layoutSubviews() {
 super.layoutSubviews()

 var selectFrame = self.bounds
 let newWidth = CGRectGetWidth(selectFrame) / CGFloat(items.count)
 selectFrame.size.width = newWidth
 thumbView.frame = selectFrame
 thumbView.backgroundColor = thumbColor
//        thumbView.layer.cornerRadius = thumbView.frame.height / 2
 //if first item, left corner radius is height/2, right corner radius is 0. if last item, left corner radius is 0, right corner radius is height/2. if middle item, both corner radius is 0
//      check if selected index is first item
 displayNewSelectedIndex()

}

func updateThumbViewConerRadius(){
 let cornerRadius: CGFloat = thumbView.frame.height / 2
 thumbView.layer.cornerRadius = cornerRadius
 if selectedIndex == 0 {
     if #available(iOS 11.0, *) {
         thumbView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
     }else{
         let path = UIBezierPath(roundedRect: thumbView.bounds,
                 byRoundingCorners: [.bottomLeft, .topLeft],
                 cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

         let maskLayer = CAShapeLayer()
         maskLayer.path = path.cgPath

         thumbView.layer.mask = maskLayer
     }
 }else if selectedIndex == items.count - 1 {
     if #available(iOS 11.0, *) {
         thumbView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
     }else{
         let path = UIBezierPath(roundedRect: thumbView.bounds,
                 byRoundingCorners: [.topRight, .bottomRight],
                 cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))

         let maskLayer = CAShapeLayer()
         maskLayer.path = path.cgPath

         thumbView.layer.mask = maskLayer
     }
 }else{
     thumbView.layer.cornerRadius = 0
 }
}

override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {

 let location = touch.location(in: self)

 var calculatedIndex : Int?
 for (index, item) in labels.enumerated(){
     if item.frame.contains(location) {
         calculatedIndex = index
     }
 }


 if calculatedIndex != nil {
     selectedIndex = calculatedIndex!
     sendActions(for: .valueChanged)
 }

 return false
}

func displayNewSelectedIndex(){
 for (index, item) in labels.enumerated() {
     item.textColor = unselectedLabelColor
 }

 var label = labels[selectedIndex]
 label.textColor = selectedLabelColor
 updateThumbViewConerRadius()

//        UIView.animate(withDuration: 0.1, animations: {
     self.thumbView.frame = label.frame
//        })
}

func addIndividualItemConstraints(items: [UIView], mainView: UIView, padding: CGFloat) {

 let constraints = mainView.constraints

 for (index, button) in items.enumerated() {

     var topConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mainView, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1.0, constant: 0)

     var bottomConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.bottom, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mainView, attribute: NSLayoutConstraint.Attribute.bottom, multiplier: 1.0, constant: 0)

     var rightConstraint : NSLayoutConstraint!

     if index == items.count - 1 {

         rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mainView, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: -padding)

     }else{

         let nextButton = items[index+1]
         rightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.right, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nextButton, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: -padding)
     }


     var leftConstraint : NSLayoutConstraint!

     if index == 0 {

         leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: mainView, attribute: NSLayoutConstraint.Attribute.left, multiplier: 1.0, constant: padding)

     }else{

         let prevButton = items[index-1]
         leftConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.left, relatedBy: NSLayoutConstraint.Relation.equal, toItem: prevButton, attribute: NSLayoutConstraint.Attribute.right, multiplier: 1.0, constant: padding)

         let firstItem = items[0]

         var widthConstraint = NSLayoutConstraint(item: button, attribute: .width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: firstItem, attribute: .width, multiplier: 1.0  , constant: 0)

         mainView.addConstraint(widthConstraint)
     }

     mainView.addConstraints([topConstraint, bottomConstraint, rightConstraint, leftConstraint])
 }
}

func setSelectedColors(){
 for item in labels {
     item.textColor = unselectedLabelColor
 }

 if labels.count > 0 {
     labels[0].textColor = selectedLabelColor
 }

 thumbView.backgroundColor = thumbColor
}

func setFont(){
 for item in labels {
     item.font = font
 }
}
}
