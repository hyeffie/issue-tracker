//
//  LabelListViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/24.
//

import UIKit

class LabelListViewController: UIViewController {
   private var collectionView: UICollectionView!
   private var dataSource: DataSource!
   
   private var networkManager: NetworkManager?
   private var list: LabelList = LabelList(labels: [
      LabelList.Label(labelId: 0, labelName: "BE", backgroundColor: "#b6f482", description: "데이터베이스 수정"),
      LabelList.Label(labelId: 1, labelName: "new jeans", backgroundColor: "#10f4FF", description: "코카콜라 맛있다"),
      LabelList.Label(labelId: 2, labelName: "le serrafim", backgroundColor: "#b6f482", description: "fearless ha"),
      LabelList.Label(labelId: 3, labelName: "aespa", backgroundColor: "#FFFFFF", description: "넥레 딱대"),
   ])
   
   override func viewDidLoad() {
      super.viewDidLoad()
      self.title = "레이블"
      setCollectionView()
      configureDataSource()
      applyUpdatedSnapshot()
   }
}

extension LabelListViewController {
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
      let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { _, layoutEnvironment in
         var config = UICollectionLayoutListConfiguration(appearance: .plain)
         config.showsSeparators = true
         return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
      }
      return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
   }
}

extension LabelListViewController {
   typealias LabelCell = LabelListCell
   private enum Section {
      case label
      
      var cellClass: UICollectionViewCell.Type {
         switch self {
         case .label: return LabelCell.self
         }
      }
   }
   
   private enum Item: Hashable {
      case label(label: LabelList.Label)
   }
   
   private class DataSource: UICollectionViewDiffableDataSource<Section, Item> { }
   
   private func createLabelCellRegisteration() -> UICollectionView.CellRegistration<LabelCell, Item> {
      let cellNib = UINib(nibName: LabelCell.cellId, bundle: nil)
      return .init(cellNib: cellNib) { cell, indexPath, itemIdentifier in
         guard case Item.label(let label) = itemIdentifier else { return }
         cell.configure(with: label)
      }
   }
   
   private func configureDataSource() {
      let labelCellRegistration = createLabelCellRegisteration()
      
      dataSource = DataSource(
         collectionView: collectionView,
         cellProvider: { (collectionView, indexPath, item) -> UICollectionViewCell? in
         switch item {
         case .label:
            return collectionView.dequeueConfiguredReusableCell(
               using: labelCellRegistration,
               for: indexPath,
               item: item)
         }
      })
   }
   
   private func applyUpdatedSnapshot(animated: Bool = true) {
      var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
      snapshot.appendSections([.label])
      snapshot.appendItems(list.labels.map { label in Item.label(label: label) }, toSection: .label)
      dataSource.apply(snapshot, animatingDifferences: animated)
   }
}
