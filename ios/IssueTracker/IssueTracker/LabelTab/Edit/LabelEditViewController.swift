//
//  LabelEditViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import UIKit

class LabelEditViewController: UITableViewController {
   private let defaultName = "example"
   private let defaultBackgroundColor = "#FFFFFF"
   private let defaultTextColor = "#000000"
   
   @IBOutlet weak var nameLabel: UILabel!
   @IBOutlet weak var descriptionLabel: UILabel!
   @IBOutlet weak var backgroundColorLabel: UILabel!
   
   @IBOutlet weak var nameField: UITextField!
   @IBOutlet weak var descriptionField: UITextField!
   @IBOutlet weak var colorField: UITextField!
   
   @IBOutlet weak var previewCanvas: UIView!
   private var labelPreview: IssueLabel!
   
   private var saveButton: UIBarButtonItem!
   
   private var networkManager: NetworkManager?
   private var detail: LabelDetail?
   
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
      setEditForm()
      setNetwork()
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
   
   private func setNetwork() {
      networkManager = NetworkManager()
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
      labelPreview = IssueLabel(name: defaultName,
                                color: defaultBackgroundColor)
      previewCanvas.addSubview(labelPreview)
      labelPreview?.translatesAutoresizingMaskIntoConstraints = false
      labelPreview?.centerXAnchor.constraint(equalTo: previewCanvas.centerXAnchor).isActive = true
      labelPreview?.centerYAnchor.constraint(equalTo: previewCanvas.centerYAnchor).isActive = true
   }
   
   private func setEditForm() {
      guard let detail else { return }
      nameField.text = detail.labelName
      descriptionField.text = detail.description
      colorField.text = detail.backgroundColor
      labelPreview.changeName(to: detail.labelName)
      labelPreview.changeColor(to: detail.backgroundColor ?? defaultBackgroundColor)
      saveButton.isEnabled = true
   }
   
   @objc private func save() {
      guard let name = nameField.text else {
         // TODO: Label 이름 빈 문자열 케이스 처리
         return
      }
      let fontColor = defaultTextColor
      let postData = LabelDetailPostDTO(
         labelName: name,
         backgroundColor: colorField.text ?? defaultBackgroundColor,
         fontColor: fontColor,
         description: descriptionField.text ?? "")
      
      if let detail {
         networkManager?.patchLabel(id: detail.labelId, newDetail: postData) { [weak self] in
            NotificationCenter.default.post(name: LabelList.Notifications.didEditLabel, object: nil)
            DispatchQueue.main.async { self?.navigationController?.popViewController(animated: true) }
         }
      } else {
         networkManager?.postNewLabel(postData) { [weak self] in
            NotificationCenter.default.post(name: LabelList.Notifications.didAddLabel, object: nil)
            DispatchQueue.main.async { self?.navigationController?.popViewController(animated: true) }
         }
      }
      
   }
}
