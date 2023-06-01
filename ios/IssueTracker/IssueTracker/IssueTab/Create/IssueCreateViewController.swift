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
      
      let newDTO = IssueDetailPostDTO(title: "", content: "", imgUrl: nil, userId: 0, userList: [], labelList: [], milestoneId: 0)
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
   
   // MARK: Properties
   
   var networkManager: NetworkManager?
   
   var formData: IssueFormData?
   var detail: IssueDetailPostDTO?
   
   // MARK: Actions
   
   @IBAction func selectAssigneeSection(_ sender: Any) {
      guard let formData else {
         // MARK: 데이터 없을 때 선택할 수 없음 > 알림창 등으로 처리
         return
      }
      
      let elements = formData.userList.map { user in PickerElement(id: user.userId, name: user.userName) }
      
      let pickerViewController = ItemPickerViewController(title: "담당자", elements: elements) { [weak self] selectedAssignees in
         self?.detail?.replaceAssigneeList(selectedAssignees)
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
   
   private func setUI() {
      setNavigationItem()
      setFont()
   }
   
   private func setNavigationItem() {
      self.navigationItem.largeTitleDisplayMode = .never
      let segmentedControl = UISegmentedControl(items: ["마크다운", "미리보기"])
      segmentedControl.selectedSegmentIndex = 0
      self.navigationItem.titleView = segmentedControl
      
      let saveButton = UIBarButtonItem(title: "저장", style: .plain, target: self, action: nil)
      saveButton.isEnabled = false
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

extension IssueCreateViewController {
   private func getFormData() {
      networkManager?.requestIssueList(completion: { [weak self] dto in
         let issueFormData = ListingItemFactory.IssueTab.makeIssueFormData(with: dto)
         self?.formData = issueFormData
      })
   }
}
