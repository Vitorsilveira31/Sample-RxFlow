//
//  AppCoordinator.swift
//  Poc-RxFlow
//
//  Created by Vitor Silveira on 14/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation
import RxFlow

enum AppStep: Step {
    case start
    case detail
    case handle(host: String, parameters: [String : String])
}

class AppFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController = UINavigationController()

    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? AppStep else { return .none }
        
        switch step {
        case .start:
            return startFlow()
        case .detail:
            return detailFlow()
        case .handle(let host, let parameters):
            return handleUrl(with: host, parameters: parameters)
        }
    }
    
    func startFlow() -> FlowContributors {
        let viewController = ViewController.instantiate(with: ViewModel())

        self.rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    
    func detailFlow() -> FlowContributors {
        let viewController = DetailViewController.instantiate(with: DetailViewModel())
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    
    func handleUrl(with host: String, parameters: [String : String]) -> FlowContributors {
        // TODO
        let viewController = DetailViewController.instantiate(with: DetailViewModel())
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
}
