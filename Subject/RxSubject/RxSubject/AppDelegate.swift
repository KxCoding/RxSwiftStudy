//
//  AppDelegate.swift
//  RxSubject
//
//  Created by smg on 2017. 12. 6..
//  Copyright © 2017년 smg. All rights reserved.
//

import UIKit
import Then

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions
    launchOptions: [UIApplicationLaunchOptionsKey: Any]?
  ) -> Bool {
    setupApplication()
    return true
  }
  
  func setupApplication() {
    window = UIWindow(frame: UIScreen.main.bounds).then {
      $0.rootViewController = ItemListViewController()
      $0.makeKeyAndVisible()
    }
  }
}


















