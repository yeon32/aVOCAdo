//
//  MainViewController.swift
//  aVOCAdo
//
//  Created by 김정연 on 2022/05/09.
//

import UIKit
import FirebaseAuth

class MainViewController: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var gotomenuButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //popGesture 막기
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    
    /*
    //MenuViewController로 화면 넘어가는 Segue
    @IBAction func move(_ sender: Any) {
        self.performSegue(withIdentifier: "MenuSegue", sender: self)
    }
     */
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
        
        let email = Auth.auth().currentUser?.email ?? "고객"
        
        welcomeLabel.text = """
        환영합니다!
        \(email)님
        """
    }
    
    
    //누르면 첫번째 화면 (loginviewcontroller)로 넘어감
    @IBAction func logoutButtonTapped(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        
        do {
            try firebaseAuth.signOut()
            self.navigationController?.popToRootViewController(animated: true)
        } catch let signOutError as NSError {
            print("ERROR: signout \(signOutError.localizedDescription)")
        }

    }
    
    
}
