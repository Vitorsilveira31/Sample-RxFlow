//
//  DetailViewController.swift
//  Poc-RxFlow
//
//  Created by Vitor Silveira on 14/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    static func instantiate(with viewModel: DetailViewModel) -> DetailViewController {
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.viewModel = viewModel
        
        return vc
    }
    
    var viewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
