//
//  LoginViewController.swift
//  aVOCAdo
//
//  Created by 김정연 on 2022/05/09.
//

import UIKit


class LoginViewController: UIViewController{
    
    @IBOutlet weak var emailLoginButton: UIButton!
    @IBOutlet weak var googleLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    
    //레이아웃
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //세개의 버튼에 동일하게 UI가 적용됨
        [emailLoginButton, googleLoginButton,
         appleLoginButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor
            $0?.layer.cornerRadius = 30
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //navigation bar 숨기기
        navigationController?.navigationBar.isHidden = true
    
      
    }
    
    
    @IBAction func googleLoginButtonTapped(_ sender: UIButton) {
     //Firebase 인증
    }
    
    
    @IBAction func appleLoginButtonTapped(_ sender: UIButton) {
        //Firebase 인증
    }
    
    
    
    
}
