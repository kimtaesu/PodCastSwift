//
//  AppDelegate.swift
//  PodCastSwift
//
//  Created by tskim on 20/05/2019.
//  Copyright © 2019 hucet. All rights reserved.
//

import UIKit

class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var appDependency: AppDependency!
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
        ) -> Bool {
        printEmulatorInfo()
        self.appDependency = self.appDependency ?? CompositionRoot.resolve()
        self.window = self.appDependency.window
        self.appDependency.configureSDKs()
        return true
    }
}

extension AppDelegate {
    func printEmulatorInfo() {
        logger.debug("Library: \(FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask).first!.path)")
    }
}
