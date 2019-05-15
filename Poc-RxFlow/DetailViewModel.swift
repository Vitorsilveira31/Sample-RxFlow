//
//  DetailViewModel.swift
//  Poc-RxFlow
//
//  Created by Vitor Silveira on 14/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import Foundation
import RxFlow
import RxCocoa

class DetailViewModel: NSObject, Stepper {
    
    var steps = PublishRelay<Step>()
    
}
