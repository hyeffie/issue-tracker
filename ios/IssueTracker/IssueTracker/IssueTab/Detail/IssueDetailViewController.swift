//
//  IssueDetailViewController.swift
//  IssueTracker
//
//  Created by Wood on 2023/05/26.
//

import UIKit

class IssueDetailViewController: UIViewController {
   @IBOutlet weak var collectionView: UICollectionView!
   private var issueDetailUseCase = IssueDetailUseCase()
   private var uiColorFactory = UIColorFactory()
   private var observers: [NSObjectProtocol] = []

   var issueId: Int?
   private var writerName = ""
   private let headerId = "IssueDetailCollectionViewHeader"
   private let cellId = "CommentCell"
   private let openColor  = "#007AFF"
   private let closeColor = "#543ABE"
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setUI()
      setCollectionView()
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
                                             selector: #selector(reload(_:)),
                                             name: IssueDetailUseCase.didLoadDetailData,
                                             object: issueDetailUseCase)
      
   }
   
   @objc func reload(_ notification: Notification) {
      DispatchQueue.main.async {
         self.collectionView.reloadData()
      }
   }
   
//   func createLayout() -> UICollectionViewLayout {
//      let sectionProvider = { (sectionIndex: Int,
//                               layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
//
//          var config = UICollectionLayoutListConfiguration(appearance: .plain)
//          config.showsSeparators = false
//
//          let section = NSCollectionLayoutSection.list(
//              using: config,
//              layoutEnvironment: layoutEnvironment
//          )
//
//          return section
//      }
//      return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
//   }
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
      writerName = headerData.userName
      
      let time = LastTimeGenerator.calculateLastTime(past: headerData.editTime)
      header.editTime.text = "\(time) 전, \(headerData.userName)님이 작성했습니다."
      header.title.text = headerData.title
      header.number.text = "#\(headerData.number)"
      
      return header
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      numberOfItemsInSection section: Int
   ) -> Int {
      return issueDetailUseCase.commentCount
   }
   
   func collectionView(
      _ collectionView: UICollectionView,
      cellForItemAt indexPath: IndexPath
   ) -> UICollectionViewCell {
      guard let cell = collectionView.dequeueReusableCell(
         withReuseIdentifier: cellId,
         for: indexPath
      ) as? CommentCell else { return UICollectionViewCell() }

      guard let comment = issueDetailUseCase.sendComent(row: indexPath.row) else {
         return cell
      }
      
      cell.configure(writerName: writerName, comment: comment)
//      DispatchQueue.main.async {
//         cell.configureImage(image: self.issueDetailUseCase.sendImage(row: indexPath.row))
//      }
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
      let width = self.collectionView.frame.width
      let estimatedHeight: CGFloat = 300.0
      guard let dummyCell = collectionView.dequeueReusableCell(
         withReuseIdentifier: cellId,
         for: indexPath
      ) as? CommentCell else { return CGSize() }
      
      referDetail(at: indexPath) { (detail) in
         dummyCell.configure(writerName: writerName, comment: detail)
      }
      
      return CGSize(width: self.collectionView.frame.width, height: estimatedHeight)
   }
   
   func referDetail(at indexPath: IndexPath, handler: (IssueDetailDTO.Comment) -> Void) {
      guard let detail = self.issueDetailUseCase.sendComent(row: indexPath.row) else {
         return
      }
      handler(detail)
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
