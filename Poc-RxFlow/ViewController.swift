//
//  ViewController.swift
//  Poc-RxFlow
//
//  Created by Vitor Silveira on 14/05/19.
//  Copyright © 2019 Vitor Silveira. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {
    
    static func instantiate(with viewModel: ViewModel) -> ViewController {
        let vc = ViewController(nibName: "ViewController", bundle: nil)
        vc.viewModel = viewModel
        
        return vc
    }
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    let disposeBag = DisposeBag()

    var viewModel: ViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loginButton.rx.tap
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .bind {
                guard let login = self.loginTextField.text, !login.isEmpty, let password = self.passwordTextField.text, !password.isEmpty else { return }
                self.viewModel.doLogin(login: login, password: password)
        }.disposed(by: self.disposeBag)
    }

}
