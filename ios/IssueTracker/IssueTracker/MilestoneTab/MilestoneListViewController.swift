//
//  MilestoneListViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/25.
//

import UIKit

class MilestoneListViewController: UIViewController {
   private var collectionView: UICollectionView!
   private var dataSource: DataSource!
   
   private var networkManager: NetworkManager?
   private var list: MilestoneList = MilestoneList(milestones: [
      .init(milestoneId: 0, name: "[BE] 이슈 관리 기능", description: "평냉엔 소주", completedAt: Date(), countAllOpenedIssues: 20, countAllClosedIssues: 2, progress: Double(2 / 22)),
      .init(milestoneId: 1, name: "[iOS] 이슈 관리 기능", description: "평냉엔 소주? 이게 맞아?", completedAt: Date(), countAllOpenedIssues: 0, countAllClosedIssues: 2, progress: Double(2 / 2)),
   ])
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.view.backgroundColor = .systemBackground
      self.title = "마일스톤"
      setCollectionView()
      configureDataSource()
      applyUpdatedSnapshot()
   }
}

extension MilestoneListViewController {
   private func setCollectionView() {
      collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(collectionView)
      
      NSLayoutConstraint.activate([
         collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
         collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
         collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
         collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
      ])
   }
   
   private func setCollectionViewLayout() -> UICollectionViewCompositionalLayout {
      let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { [weak self] _, layoutEnvironment in
         var config = UICollectionLayoutListConfiguration(appearance: .plain)
         config.showsSeparators = true
         config.trailingSwipeActionsConfigurationProvider = self?.createSwipeActionProvider()
         return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
      }
      return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
   }
}

extension MilestoneListViewController {
   func createSwipeActionProvider() -> UICollectionLayoutListConfiguration.SwipeActionsConfigurationProvider {
      return { _ in
         var actions: [UIContextualAction]
         let delete = SwiptAction.delete.makeAction(hasImage: false, withHandler: { _, _, _ in })
         let edit = SwiptAction.edit.makeAction(hasImage: false, withHandler: { _, _, _ in })
         return UISwipeActionsConfiguration(actions: [delete, edit])
      }
   }
}

extension MilestoneListViewController {
   typealias MilestoneCell = LabelListCell
   private enum Section {
      case milestone
      
      var cellClass: UICollectionViewCell.Type {
         switch self {
         case .milestone: return MilestoneCell.self
         }
      }
   }
   
   private enum Item: Hashable {
      case milestone(milestone: MilestoneList.Milestone)
   }
   
   private class DataSource: UICollectionViewDiffableDataSource<Section, Item> { }
   
   private func createMilestoneCellRegisteration() -> UICollectionView.CellRegistration<MilestoneCell, Item> {
      let cellNib = UINib(nibName: MilestoneCell.cellId, bundle: nil)
      return .init(cellNib: cellNib) { cell, indexPath, itemIdentifier in
         guard case Item.milestone(let milestone) = itemIdentifier else { return }
//         cell.configure(with: milestone)
      }
   }
   
   private func configureDataSource() {
      let milestoneCellRegistration = createMilestoneCellRegisteration()
      
      dataSource = DataSource(
         collectionView: collectionView,
         cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
         switch item {
         case .milestone:
            return collectionView.dequeueConfiguredReusableCell(
               using: milestoneCellRegistration,
               for: indexPath,
               item: item)
         }
      })
   }
   
   private func applyUpdatedSnapshot(animated: Bool = true) {
      var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
      snapshot.appendSections([.milestone])
      snapshot.appendItems(list.milestones.map { milestone in Item.milestone(milestone: milestone) }, toSection: .milestone)
      dataSource.apply(snapshot, animatingDifferences: animated)
   }
}
