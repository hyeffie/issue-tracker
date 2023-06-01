//
//  IssueCreateViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/31.
//

import UIKit

class IssueCreateViewController: UIViewController, StoryboardBased {
   // MARK: Static
   
   static func instantiate(detail: IssueDetailPostDTO? = nil) -> Self {
      let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
      let viewController = storyboard.instantiateInitialViewController() as! Self
      
      let newDTO = IssueDetailPostDTO(userId: 0, title: "", content: "", imgUrl: nil, userList: [], labelList: [], milestoneId: 1)
      viewController.detail = detail ?? newDTO
      return viewController
   }
   
   // MARK: Outlets
   
   @IBOutlet weak var titleLabel: UILabel!
   @IBOutlet weak var titleTextField: UITextField!
   @IBOutlet weak var contentField: UITextView!
   @IBOutlet weak var additionalInfoLabel: UILabel!
   @IBOutlet weak var assigneeLabel: UILabel!
   @IBOutlet weak var labelLabel: UILabel!
   @IBOutlet weak var milestoneLabel: UILabel!
   @IBOutlet weak var selectedAssigneeLabel: UILabel!
   @IBOutlet weak var selectedLabelLabel: UILabel!
   @IBOutlet weak var selectedMilestoneLabel: UILabel!
   
   @IBOutlet weak var assigneeStateLabel: UILabel!
   @IBOutlet weak var labelStateLabel: UILabel!
   @IBOutlet weak var milestoneStateLabel: UILabel!
   
   // MARK: Properties
   
   var networkManager: NetworkManager?
   
   var formData: IssueFormData?
   var detail: IssueDetailPostDTO?
   
   var saveButton: UIBarButtonItem?
   
   // MARK: Actions
   
   @IBAction func titleChanged(_ sender: UITextField) {
      guard let final = sender.text else { return }
      saveButton?.isEnabled = final.count > 0
   }
   
   @IBAction func selectAssigneeSection(_ sender: Any) {
      guard let formData else {
         // MARK: 데이터 없을 때 선택할 수 없음 > 알림창 등으로 처리
         return
      }
      
      let elements = formData.userList.map { user in PickerElement(id: user.userId, name: user.userName) }
      
      let pickerViewController = ItemPickerViewController(title: "담당자", elements: elements) { [weak self] selectedAssignees, state in
         self?.detail?.replaceAssigneeList(selectedAssignees)
         self?.assigneeStateLabel.text = state
      }
      let navigationViewController = UINavigationController(rootViewController: pickerViewController)
      self.present(navigationViewController, animated: true)
   }
   
   @IBAction func selectLabelSection(_ sender: Any) {
      guard let formData else {
         // MARK: 데이터 없을 때 선택할 수 없음 > 알림창 등으로 처리
         return
      }
      
      let elements = formData.labelList.map { label in PickerElement(id: label.labelId, name: label.labelName) }
      
      let pickerViewController = ItemPickerViewController(title: "레이블", elements: elements) { [weak self] selectedLabels, state in
         self?.detail?.replaceLabelList(selectedLabels)
         self?.labelStateLabel.text = state
      }
      
      let navigationViewController = UINavigationController(rootViewController: pickerViewController)
      self.present(navigationViewController, animated: true)
   }
   
   @IBAction func selectMilestoneSection(_ sender: Any) {
      guard let formData else {
         // MARK: 데이터 없을 때 선택할 수 없음 > 알림창 등으로 처리
         return
      }
      
      let elements = formData.miletoneList.map { milestone in PickerElement(id: milestone.milestoneId, name: milestone.milestoneName) }
      
      let pickerViewController = ItemPickerViewController(
         title: "마일스톤",
         elements: elements,
         multiSelectable: false) { [weak self] selectedMilestone, state in
            self?.detail?.replaceMilestone(selectedMilestone.first)
            self?.milestoneStateLabel.text = state
      }
      let navigationViewController = UINavigationController(rootViewController: pickerViewController)
      self.present(navigationViewController, animated: true)
   }
   
   // MARK: View life-cycle methods
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setUI()
      setNetworkManager()
      getFormData()
   }
   
   // MARK: Private Methods
   
   private func setUI() {
      setNavigationItem()
      setFont()
      titleTextField.delegate = self
      titleTextField.inputAccessoryView = UIToolbar.makeDoneButtonToolBar(action: { [weak self] action in self?.doneInput() })
      contentField.inputAccessoryView = UIToolbar.makeDoneButtonToolBar(action: { [weak self] action in self?.doneInput() })
   }
   
   private func setNavigationItem() {
      self.navigationItem.largeTitleDisplayMode = .never
      let segmentedControl = UISegmentedControl(items: ["마크다운", "미리보기"])
      segmentedControl.selectedSegmentIndex = 0
      self.navigationItem.titleView = segmentedControl
      
      saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: #selector(save))
      saveButton?.isEnabled = false
      self.navigationItem.rightBarButtonItem = saveButton
   }
   
   private func setFont() {
      titleLabel.apply(typography: .init(weight: .regular, size: .large), textColor: .gray800)
      titleTextField.apply(typography: .init(weight: .regular, size: .large), textColor: .gray800)
      
      additionalInfoLabel.apply(typography: .init(weight: .bold, size: .medium), textColor: .gray800)
      [assigneeLabel, labelLabel, milestoneLabel].forEach { label in
         label.apply(typography: .init(weight: .regular, size: .large), textColor: .gray800)
      }
      [selectedAssigneeLabel, selectedLabelLabel, selectedMilestoneLabel].forEach { label in
         label.apply(typography: .init(weight: .regular, size: .large), textColor: .gray700)
      }
      contentField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
   }
   
   private func setNetworkManager() {
      networkManager = NetworkManager()
   }
}

// MARK: Request

extension IssueCreateViewController {
   private func getFormData() {
      networkManager?.requestIssueList(completion: { [weak self] dto in
         let issueFormData = ListingItemFactory.IssueTab.makeIssueFormData(with: dto)
         self?.formData = issueFormData
      })
   }
}

// MARK: 저장 (추가)

extension IssueCreateViewController {
   @objc func save() {
      guard var detail else {
         // TODO: 저장 불가
         return
      }
      guard let title = titleTextField.text, title.isEmpty == false else {
         // TODO: 저장 불가
         return
      }
      let content = contentField.text ?? "문제가 뭐니"
      detail.replaceData(userId: 1, title: title, content: content)
      
      networkManager?.postNewIssue(detail, completion: {
         NotificationCenter.default.post(name: IssueList.Notifications.didAddIssue, object: self)
         DispatchQueue.main.async { self.navigationController?.popViewController(animated: true) }
      })
   }
}

extension IssueCreateViewController: UITextFieldDelegate {
   private func doneInput() {
      self.view.endEditing(true)
   }
   
   func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      doneInput()
      return true
   } 
}
