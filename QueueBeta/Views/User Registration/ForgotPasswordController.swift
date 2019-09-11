//
//  ForgotPasswordController.swift
//  QueueBeta
//
//  Created by Patrick Cockrill on 8/29/19.
//  Copyright © 2019 Patrick Cockrill. All rights reserved.
//

import UIKit

class ForgotPasswordController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(handleDismiss))
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = false
        
        view.backgroundColor = .white
    }
    
    @objc func handleDismiss() {
        dismiss(animated: true, completion: nil)
    }
}
