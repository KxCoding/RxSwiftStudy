//
//  BannerView.swift
//  RxSubject
//
//  Created by smg on 2017. 12. 6..
//  Copyright © 2017년 smg. All rights reserved.
//

import UIKit
import UIBaseKit
import Then
import SnapKit

// MARK: - BannerViewDataSource

protocol BannerViewDataSource: class {
  func numberOfItems() -> Int
  func bannerView(_ bannerView: BannerView, cellForItem cell: BannerCell, at indexPath: IndexPath)
}

// MARK: - BannerViewDelegate

protocol BannerViewDelegate: class {
  func bannerView(_ bannerView: BannerView, didSelectItemAt indexPath: IndexPath)
}

// MARK: - BannerView

class BannerView: BaseView {
  // Todo:
  
  weak var delegate: BannerViewDelegate?
  
  weak var dataSource: BannerViewDataSource? {
    didSet { collectionView.reloadData() }
  }
  
  private var collectionView = UICollectionView(
    frame: .zero,
    collectionViewLayout: BannerViewLayout()
  ).then {
    $0.register(BannerCell.self, forCellWithReuseIdentifier: BannerCell.cellIdentifier)
    $0.isPagingEnabled = true
    $0.showsVerticalScrollIndicator = false
    $0.showsHorizontalScrollIndicator = false
    $0.backgroundColor = .white
  }
  
  override func setupViews() -> [CanBeSubview]? {
    collectionView.dataSource = self
    collectionView.delegate = self
    
    return [
      collectionView
    ]
  }
  
  override func setupConstraints() {
    collectionView.snp.makeConstraints() {
      $0.edges.equalToSuperview()
    }
  }
}

extension BannerView: UICollectionViewDataSource {
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return dataSource != nil ? dataSource!.numberOfItems(): 0
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: BannerCell.cellIdentifier,
      for: indexPath
    ) as! BannerCell
    
    dataSource?.bannerView(self, cellForItem: cell, at: indexPath)
    
    return cell
  }
}

extension BannerView: UICollectionViewDelegateFlowLayout {
  func collectionView(
    _ collectionView: UICollectionView,
    didSelectItemAt indexPath: IndexPath
  ) {
    delegate?.bannerView(self, didSelectItemAt: indexPath)
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    layout collectionViewLayout: UICollectionViewLayout,
    sizeForItemAt indexPath: IndexPath
  ) -> CGSize {
    return self.frame.size
  }
}

// MARK: - BannerViewLayout

class BannerViewLayout: UICollectionViewFlowLayout {
  override init() {
    super.init()
    setupLayout()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupLayout()
  }
  
  func setupLayout() {
    scrollDirection = .horizontal
    minimumLineSpacing = 0
    minimumInteritemSpacing = 0
  }
}

// MARK: - BannerCell

class BannerCell: BaseCollectionViewCell {
  class var cellIdentifier: String {
    return "\(BannerCell.self)"
  }
  
  var imageView = UIImageView()
  
  override func setupViews() -> [CanBeSubview]? {
    return [
      imageView
    ]
  }
  
  override func setupConstraints() {
    imageView.snp.makeConstraints {
      $0.edges.equalToSuperview()
    }
  }
}

