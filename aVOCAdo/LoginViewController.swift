//
//  LoginViewController.swift
//  aVOCAdo
//
//  Created by 김정연 on 2022/05/02.
//

import UIKit

class LoginViewController: UIViewController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Navigation Bar 숨기기
        navigationController?.navigationBar.isHidden = true
    }
    
}
