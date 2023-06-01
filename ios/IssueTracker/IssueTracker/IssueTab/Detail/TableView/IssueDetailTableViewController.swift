//
//  IssueDetailTableViewController.swift
//  IssueTracker
//
//  Created by Wood on 2023/06/01.
//

import UIKit

class IssueDetailTableViewController: UIViewController {
   @IBOutlet weak var tableView: UITableView!
   private var issueDetailUseCase = IssueDetailUseCase()
   private var writerName = ""
   private let headerId = "DetailTableHeader"
   private let cellId = "DetailTableCell"
   
   var issueId: Int?
   var delegate: (any DataSenderDelegate)?
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setUI()
      setTableView()
      setObserver()
      issueDetailUseCase.loadData(issueId: issueId)
   }
   
   private func setUI() {
      addEditButton()
      configureTabBar(isHiding: true)
      hideTitleView()
   }
   
   private func addEditButton() {
      guard let editImage = UIImage(systemName: "ellipsis") else { return }
      let editButton = UIBarButtonItem(image: editImage)
      self.navigationItem.rightBarButtonItem = editButton
   }
   
   private func hideTitleView() {
      self.navigationItem.largeTitleDisplayMode = .never
   }
   
   private func setTableView() {
      let cell = UINib(nibName: cellId, bundle: nil)
      self.tableView.register(cell, forCellReuseIdentifier: cellId)
      
      let header = UINib(nibName: headerId, bundle: nil)
      self.tableView.register(header, forCellReuseIdentifier: headerId)
   }
   
   private func setObserver() {
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(reload(_:)),
                                             name: IssueDetailDTO.Notifications.didLoadDetail,
                                             object: nil)
   }
   
   @objc func reload(_ notification: Notification) {
      DispatchQueue.main.async {
         self.tableView.reloadData()
      }
   }
}

extension IssueDetailTableViewController: UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return issueDetailUseCase.commentCount + 1
   }
   
   func tableView(_ tableView: UITableView,
                  cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      guard indexPath.row > 0 else {
         guard let header = tableView.dequeueReusableCell(withIdentifier: headerId, for: indexPath) as? DetailTableHeader else {
            return UITableViewCell()
         }
         
         let headerData = issueDetailUseCase.sendHeaderData()
         writerName = headerData.userName
         header.configure(headerData: headerData)
         return header
      }
      
      guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? DetailTableCell else {
         return UITableViewCell()
      }
      
      guard let comment = issueDetailUseCase.sendComent(row: indexPath.row) else { return cell }
      cell.configure(writerName: writerName, comment: comment)
      return cell
   }
}

extension IssueDetailTableViewController {
   func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
      return UITableView.automaticDimension
   }
}
