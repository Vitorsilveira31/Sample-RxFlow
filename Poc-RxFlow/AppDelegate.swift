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
        window = UIWindow()
        
        if let launchOptions = launchOptions, let urlOption = launchOptions[UIApplication.LaunchOptionsKey.url], let url = urlOption as? URL {
            
            var parameters: [String: String] = [:]
            
            URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems?.forEach {
                parameters[$0.name] = $0.value
            }
            
            return self.startApp(with: .handle(host: url.host ?? "", parameters: parameters))
        }
        
        return startApp(with: .start)
    }
    
    private func startApp(with step: AppStep) -> Bool {
        guard let window = self.window else { return false }
        
        Flows.whenReady(flow1: appFlow) { [unowned window] root in
            DispatchQueue.main.async { [unowned window] in
                window.rootViewController = root
                window.makeKeyAndVisible()
            }
        }
        
        coordinator.coordinate(flow: appFlow, with: OneStepper(withSingleStep: step))
                
        return true
    }

}

