//
//  DetailViewController.swift
//  Poc-RxFlow
//
//  Created by Vitor Silveira on 14/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    static func instantiate(with viewModel: DetailViewModel, login: String) -> DetailViewController {
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.viewModel = viewModel
        vc.login = login
        
        return vc
    }
    
    @IBOutlet weak var userLabel: UILabel!
    
    var viewModel: DetailViewModel!
    var login: String!

    override func viewDidLoad() {
        super.viewDidLoad()

        userLabel.text = login
    }

}
