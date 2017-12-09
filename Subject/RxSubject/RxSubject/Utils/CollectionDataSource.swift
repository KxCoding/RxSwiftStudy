//
//  CollectionDataSource.swift
//  PhotoPicker
//
//  Created by smg on 2017. 12. 2..
//  Copyright © 2017년 smg. All rights reserved.
//

import UIKit

class CollectionDataSource<C, M>
  : NSObject
  , UICollectionViewDataSource where C: UICollectionViewCell {
  
  typealias CellConfiguration = (C, M) -> C
  
  var models: [M]
  
  private let configureCell: CellConfiguration
  private let cellIdentifier: String
  
  init(
    cellIdentifier: String,
    models: [M],
    configureCell: @escaping CellConfiguration
  ) {
    self.models = models
    self.cellIdentifier = cellIdentifier
    self.configureCell = configureCell
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    numberOfItemsInSection section: Int
  ) -> Int {
    return models.count
  }
  
  func collectionView(
    _ collectionView: UICollectionView,
    cellForItemAt indexPath: IndexPath
  ) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: cellIdentifier,
      for: indexPath
    ) as? C
    
    guard let currentCell = cell else {
      fatalError("Identifier or class not registered with this collection view")
    }
    
    let model = models[indexPath.row]
    
    return configureCell(currentCell, model)
  }
}

