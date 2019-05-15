//
//  AppFlow.swift
//  Poc-RxFlow
//
//  Created by Vitor Silveira on 14/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation
import RxFlow

enum AppStep: Step {
    case start
    case detail(login: String)
    case handle(host: Host, parameters: [String : String])
}

enum Host: String {
    case start = "start"
    case detail = "detail"
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
        case .detail(let login):
            return detailFlow(login: login)
        case .handle(let host, let parameters):
            return handleUrl(with: host, parameters: parameters)
        }
    }
    
    func startFlow() -> FlowContributors {
        let viewController = ViewController.instantiate(with: ViewModel())

        self.rootViewController.pushViewController(viewController, animated: false)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
    
    func detailFlow(login: String) -> FlowContributors {
        let flow = DetailFlow(rootViewController)
        return .one(flowContributor: .contribute(withNextPresentable: flow, withNextStepper: OneStepper(withSingleStep: DetailStep.detail(login: login))))
    }
    
    func handleUrl(with host: Host, parameters: [String : String]) -> FlowContributors {
        switch host {
        case .start:
            return .none
        case .detail:
            return detailFlow(login: parameters["login"] ?? "")
        }
    }
}
