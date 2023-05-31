//
//  ItemPickerViewController.swift
//  IssueTracker
//
//  Created by Effie on 2023/05/31.
//

import UIKit

struct PickerItem: Hashable {
   let id: Int
   let name: String
}

final class ItemPickerViewController: UIViewController {
   let items: [PickerItem]
   
   private var collectionView: UICollectionView!
   private var dataSource: DataSource?
   
   required init?(coder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
   }
   
   init(title: String, items: [PickerItem]) {
      self.items = items
      super.init(nibName: nil, bundle: nil)
      
      self.title = "\(title) 선택"
   }
   
   override func viewDidLoad() {
      super.viewDidLoad()
      setCollectionView()
      configureDataSource()
      applyUpdatedSnapshot()
   }
}

// MARK: - CollectionView

extension ItemPickerViewController {
   private func setCollectionView() {
      collectionView = UICollectionView(frame: .zero, collectionViewLayout: setCollectionViewLayout())
      collectionView.translatesAutoresizingMaskIntoConstraints = false
      view.addSubview(collectionView)
      
      NSLayoutConstraint.activate([
         collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
         collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
         collectionView.topAnchor.constraint(equalTo: view.topAnchor),
         collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
      ])
      collectionView.delegate = self
   }
   
   private func setCollectionViewLayout() -> UICollectionViewCompositionalLayout {
      let sectionProvider: UICollectionViewCompositionalLayoutSectionProvider = { _, layoutEnvironment in
         var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
         config.showsSeparators = true
         return NSCollectionLayoutSection.list(using: config, layoutEnvironment: layoutEnvironment)
      }
      return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
   }
}

// MARK: - CollectionView DataSource

extension ItemPickerViewController {
   private class DataSource: UICollectionViewDiffableDataSource<Section, Item> { }
   
   typealias Item = PickerItem
   
   enum Section {
      case items
   }
   
   private func configureDataSource() {
      let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, Item> { (cell, indexPath, item) in
         var content = cell.defaultContentConfiguration()
         content.text = item.name
         cell.contentConfiguration = content
      }
      dataSource = DataSource(collectionView: collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
         return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
      }
   }
   
   private func applyUpdatedSnapshot(animated: Bool = true) {
      var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
      snapshot.appendSections([.items])
      snapshot.appendItems(items, toSection: .items)
      dataSource?.apply(snapshot, animatingDifferences: animated)
   }
   
}

// MARK: - CollectionView Delegate

extension ItemPickerViewController: UICollectionViewDelegate {
   
}
