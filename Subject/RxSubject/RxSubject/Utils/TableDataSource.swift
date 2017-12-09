//
//  TableDataSource.swift
//  RxSubject
//
//  Created by smg on 2017. 12. 6..
//  Copyright © 2017년 smg. All rights reserved.
//

import UIKit

class TableDataSource<Cell, Model>
  : NSObject
  , UITableViewDataSource where Cell: UITableViewCell {
  
  typealias CellConfiguration = (Cell, Model) -> Cell
  
  var models: [Model]
  
  private let configureCell: CellConfiguration
  private let cellIdentifier: String
  
  init(
    cellIdentifier: String,
    models: [Model],
    configureCell: @escaping CellConfiguration
  ) {
    self.models = models
    self.cellIdentifier = cellIdentifier
    self.configureCell = configureCell
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? Cell
    
    guard let currentCell = cell else {
      fatalError("Identifier or class not registered with this tableview")
    }
    
    let model = models[indexPath.row]
    
    return configureCell(currentCell, model)
  }
}
