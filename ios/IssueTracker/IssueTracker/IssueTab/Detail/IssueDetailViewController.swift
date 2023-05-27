//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/26.
//

import UIKit

class IssueDetailViewController: UIViewController {
   @IBOutlet weak var collectionView: UICollectionView!
   var issueId: Int?
   var issueDetailUseCase = IssueDetailUseCase()
   var lastTimeGenerator = LastTimeGenerator()
   var uiColorFactory = UIColorFactory()
   
   let headerId = "IssueDetailCollectionViewHeader"
   let cellId = "IssueDetailCollectionViewCell"
   let openColor  = "#007AFF"
   let closeColor = "#543ABE"
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setUI()
      setCollectionView()
      setObserver()
      issueDetailUseCase.loadData(issueId: issueId)
   }
   
   private func setUI() {
      addEditButton()
      hideTabBar()
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
   
   private func setCollectionView() {
      let detailHeader = UINib(nibName: headerId, bundle: nil)
      collectionView.register(detailHeader,
                              forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                              withReuseIdentifier: headerId)
      let detailCell = UINib(nibName: cellId, bundle: nil)
      collectionView.register(detailCell,
                              forCellWithReuseIdentifier: cellId)
   }
   
   private func setObserver() {
      NotificationCenter.default.addObserver(self,
                                             selector: #selector(updateCell(_:)),
                                             name: IssueDetailDTO.Notifications.didLoadDetail,
                                             object: nil)
   }
   
   @objc func updateCell(_ notification: Notification) {
      DispatchQueue.main.async {
         self.collectionView.reloadData()
      }
   }
}

extension IssueDetailViewController: UICollectionViewDelegate {}

extension IssueDetailViewController: UICollectionViewDataSource {
   func numberOfSections(in collectionView: UICollectionView) -> Int {
      return 1
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      viewForSupplementaryElementOfKind kind: String,
      at indexPath: IndexPath
   ) -> UICollectionReusableView {
      guard let header = collectionView.dequeueReusableSupplementaryView(
         ofKind: kind,
         withReuseIdentifier: headerId,
         for: indexPath
      ) as? IssueDetailCollectionViewHeader else { return UICollectionReusableView() }
      
      let headerData = issueDetailUseCase.sendHeaderData()
      
      let time = lastTimeGenerator.calculateLastTime(past: headerData.editTime)
      header.editTime.text = "\(time) 전, \(headerData.userName)님이 작성했습니다."
      header.title.text = headerData.title
      header.number.text = "#\(headerData.number)"
      
      switch headerData.status {
      case false:
         header.status.text = "열린 이슈"
         header.status.backgroundColor = uiColorFactory.make(hexColor: openColor)
      case true:
         header.status.text = "닫힌 이슈"
         header.status.backgroundColor = uiColorFactory.make(hexColor: closeColor)
      }
      
      return header
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      numberOfItemsInSection section: Int
   ) -> Int {
      return 5
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      cellForItemAt indexPath: IndexPath
   ) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(
         withReuseIdentifier: cellId,
         for: indexPath
      ) as? IssueDetailCollectionViewCell else { return UICollectionViewCell() }
      return cell
   }
}

extension IssueDetailViewController: UICollectionViewDelegateFlowLayout {
   func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      referenceSizeForHeaderInSection section: Int
   ) -> CGSize {
      return CGSize(width: self.collectionView.frame.width, height: 100)
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      sizeForItemAt indexPath: IndexPath
   ) -> CGSize {
      return CGSize(width: self.collectionView.frame.width, height: 100)
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      minimumLineSpacingForSectionAt section: Int
   ) -> CGFloat {
      return 1.0
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      layout collectionViewLayout: UICollectionViewLayout,
      insetForSectionAt section: Int
   ) -> UIEdgeInsets {
      return UIEdgeInsets(top: 4.0, left: 0, bottom: 0, right: 0)
   }
}
