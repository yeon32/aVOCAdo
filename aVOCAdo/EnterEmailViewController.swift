//
//  EnterEmailViewController.swift
//  aVOCAdo
//
//  Created by 김정연 on 2022/05/09.
//

import UIKit
import FirebaseAuth

class EnterEmailViewController:UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nextButton.layer.cornerRadius = 30
        
        nextButton.isEnabled = false
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        //화면을 켰을 때 emailTextField에 커서가 깜빡이도록 위치
        emailTextField.becomeFirstResponder()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        //Navigation bar 보이기
        navigationController?.navigationBar.isHidden = false
    }
    
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        //Firebase 이메일/비밀번호 인증
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        
        //신규 사용자 생성
        Auth.auth().createUser(withEmail: email, password: password) {[weak self] authResult, error in guard let self = self else {return}
            
            if let error = error {
                let code = (error as NSError).code
                switch code {
                case 17007: //이미 가입한 계정일 때
                    self.loginUser(withEmail: email, password: password)
                default: //위에 말고도 또다른 에러가 났을 경우
                    self.errorMessageLabel.text = error.localizedDescription
                }
            } else { //어떠한 에러도 나지 않을 때
                self.showMainViewController()
               
            }
            
        }
    }
    
    private func showMainViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let mainViewController = storyboard.instantiateViewController(identifier: "MainViewController")
        mainViewController.modalPresentationStyle = .fullScreen
        navigationController?.show(mainViewController, sender: nil)
    }
    
    private func loginUser(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) {[weak self] _, error in
            guard let self = self else {return}
            
            if let error = error {
                self.errorMessageLabel.text = error.localizedDescription
            } else {
                self.showMainViewController()
            }
        }
    }
    
}

extension EnterEmailViewController:
    UITextFieldDelegate {
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            view.endEditing(true)
            return false
        }
        
        //이메일,비밀번호 둘다 작성했을 때 활성화시키기
        func textFieldDidEndEditing(_ textField: UITextField) {
            let isEmailEmpty = emailTextField.text == ""
            let isPasswordEmpty =
            passwordTextField.text == ""
            
            nextButton.isEnabled = !isEmailEmpty && !isPasswordEmpty
        }
        
    }
