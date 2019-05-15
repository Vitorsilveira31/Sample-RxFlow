//
//  DetailFlow.swift
//  Poc-RxFlow
//
//  Created by BTG mobile on 15/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation
import RxFlow

enum DetailStep: Step {
    case detail(login: String)
}

class DetailFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    private let rootViewController: UINavigationController
    
    init(_ rootViewController: UINavigationController) {
        self.rootViewController = rootViewController
    }
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? DetailStep else { return .none }
        
        switch step {
        case .detail(let login):
            return detailFlow(login: login)
        }
    }
    
    func detailFlow(login: String) -> FlowContributors {
        let viewController = DetailViewController.instantiate(with: DetailViewModel(), login: login)
        
        self.rootViewController.pushViewController(viewController, animated: true)
        return .one(flowContributor: .contribute(withNextPresentable: viewController, withNextStepper: viewController.viewModel))
    }
}
