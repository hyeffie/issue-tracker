//
//  LabelEditViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import UIKit

class LabelEditViewController: UITableViewController {
   private let defaultName = "example"
   
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var descriptionLabel: UILabel!
   @IBOutlet weak var backgroundColorLabel: UILabel!
   
   @IBOutlet weak var nameField: UITextField!
   @IBOutlet weak var descriptionField: UITextField!
   @IBOutlet weak var colorField: UITextField!
   
   @IBOutlet weak var previewCanvas: UIView!
   private var labelPreview: IssueLabel!
   
   private var saveButton: UIBarButtonItem!
   
   private var detail: LabelDetail? = nil
   
   static func instantiate(detail: LabelDetail? = nil) -> Self {
      let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
      let viewController = storyboard.instantiateInitialViewController() as! Self
      viewController.detail = detail
      return viewController
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "새로운 레이블"
      self.navigationItem.largeTitleDisplayMode = .never
      self.tableView.separatorInset = .zero
      self.tableView.allowsSelection = false
      self.nameField.autocapitalizationType = .none
      self.nameField.autocorrectionType = .no
      setLabelFont()
      setPreview()
      setSaveButton()
   }
   
   @IBAction func nameHasChanged(_ sender: UITextField) {
      guard let final = sender.text else { return }
      if final.count > 0 {
         saveButton.isEnabled = true
         labelPreview.text = final
      } else {
         saveButton.isEnabled = false
         labelPreview.text = defaultName
      }
   }
   
   @IBAction func randomizeColor(_ sender: Any) {
      let newColorHex = Color.randomizeColorHex()
      colorField.text = "#\(newColorHex)"
      labelPreview.changeColor(to: "#\(newColorHex)")
   }
   
   @objc private func save() {
      
   }
   
   private func setSaveButton() {
      saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(save))
      self.navigationItem.rightBarButtonItem = saveButton
      saveButton.isEnabled = false
   }
   
   private func setLabelFont() {
      [nameLabel, descriptionLabel, backgroundColorLabel].forEach { label in
         label.apply(typography: .init(weight: .regular, size: .large), textColor: .gray800)
      }
      
      [nameField, descriptionField, colorField].forEach { field in
         field?.apply(typography: .init(weight: .regular, size: .large), textColor: .gray900)
      }
   }
   
   private func setPreview() {
      previewCanvas.layer.cornerRadius = 20
      labelPreview = IssueLabel(name: defaultName, color: "#FFFFFF")
      previewCanvas.addSubview(labelPreview)
      labelPreview?.translatesAutoresizingMaskIntoConstraints = false
      labelPreview?.centerXAnchor.constraint(equalTo: previewCanvas.centerXAnchor).isActive = true
      labelPreview?.centerYAnchor.constraint(equalTo: previewCanvas.centerYAnchor).isActive = true
   }
}
