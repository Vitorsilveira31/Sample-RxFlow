//
//  ViewModel.swift
//  Poc-RxFlow
//
//  Created by Vitor Silveira on 14/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation
import RxFlow
import RxCocoa

class ViewModel: NSObject, Stepper {
    
    var steps = PublishRelay<Step>()
    
    public func doLogin(login: String, password: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.steps.accept(AppStep.detail)
        }
    }
}
