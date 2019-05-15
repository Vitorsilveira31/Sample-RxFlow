//
//  AppDelegate.swift
//  Poc-RxFlow
//
//  Created by Vitor Silveira on 14/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit
import RxFlow

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private var coordinator = FlowCoordinator()
    private var appFlow = AppFlow()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        
        guard let window = self.window else { return false }
        
        let appFlow = AppFlow()
        
        Flows.whenReady(flow1: appFlow) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }

        self.coordinator.coordinate(flow: appFlow, with: OneStepper(withSingleStep: AppStep.start))
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        if let scheme = url.scheme, scheme.localizedCaseInsensitiveCompare("com.sample.flow") == .orderedSame {
            var parameters: [String: String] = [:]
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            
            self.coordinator.coordinate(flow: appFlow, with: OneStepper(withSingleStep: AppStep.handle(host: Host(rawValue: url.host ?? "") ?? .start, parameters: parameters)))
        }
        
        return true
    }
    
}

