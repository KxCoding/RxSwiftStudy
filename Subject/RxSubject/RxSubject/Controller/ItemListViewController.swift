//
//  ItemListViewController.swift
//  RxSubject
//
//  Created by smg on 2017. 12. 6..
//  Copyright © 2017년 smg. All rights reserved.
//

import UIKit
import UIBaseKit
import SnapKit
import RxSwift

class ItemListViewController: BaseViewController {
  // MARK: - UI
  
  let bannerView = BannerView().then {
    $0.backgroundColor = .white
  }
  
  let tableView = UITableView().then {
    $0.register(ItemCell.self, forCellReuseIdentifier: ItemCell.cellIdentifier)
  }
  
  // MARK: - Properties
  
  var bannerImages: [UIImage] = [
    #imageLiteral(resourceName: "banner0"), #imageLiteral(resourceName: "banner1"), #imageLiteral(resourceName: "banner2")
  ]
  
  var items: [Item] = [
    Item(name: "1"), Item(name: "2"), Item(name: "3"),
    Item(name: "4"), Item(name: "5"), Item(name: "6"),
    Item(name: "7"), Item(name: "8"), Item(name: "9"),
    Item(name: "10"), Item(name: "11"), Item(name: "12"),
    Item(name: "13"), Item(name: "14"), Item(name: "15"),
    Item(name: "16"), Item(name: "17"), Item(name: "18")
  ]
  
  var dataSource: TableDataSource<ItemCell, Item>!
  
  // MARK: - Life Cycle
  
  override func setupViews() -> [CanBeSubview]? {
    dataSource = TableDataSource<ItemCell, Item>(
      cellIdentifier: ItemCell.cellIdentifier,
      models: items
    ) { cell, item in
      cell.textLabel?.text = item.name
      return cell
    }
    tableView.dataSource = dataSource
    
    bannerView.dataSource = self
    bannerView.delegate = self
    
    return [
      bannerView,
      tableView
    ]
  }
  
  override func setupConstraints() {
    bannerView.snp.makeConstraints() {
      $0.top.equalTo(view.safeAreaLayoutGuide.snp.top)
      $0.left.right.equalTo(view)
      $0.height.equalTo(200)
    }
    tableView.snp.makeConstraints() {
      $0.top.equalTo(bannerView.snp.bottom)
      $0.left.right.equalTo(view)
      $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
    }
  }
  
  override func bind() {
    // TODO:
    
  }
  
}

// MARK: - BannerViewDataSource

extension ItemListViewController: BannerViewDataSource {
  func numberOfItems() -> Int {
    return bannerImages.count
  }
  
  func bannerView(
    _ bannerView: BannerView,
    cellForItem cell: BannerCell,
    at indexPath: IndexPath
  ) {
    cell.imageView.image = bannerImages[indexPath.item]
  }
}

// MARK: - BannerViewDelegate

extension ItemListViewController: BannerViewDelegate {
  func bannerView(
    _ bannerView: BannerView,
    didSelectItemAt indexPath: IndexPath
  ) {
    print("selected banner index: \(indexPath.item)")
  }
}

