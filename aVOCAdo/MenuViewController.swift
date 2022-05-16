//
//  MenuViewController.swift
//  aVOCAdo
//
//  Created by 김정연 on 2022/05/15.
//

import UIKit


class MenuViewController: UIViewController{
    
    
    @IBOutlet weak var ElementButton: UIButton!
    @IBOutlet weak var HighButton: UIButton!
    @IBOutlet weak var MyVocaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [ElementButton, HighButton,
         MyVocaButton].forEach {
            $0?.layer.borderWidth = 1
            $0?.layer.borderColor = UIColor.white.cgColor  //흰색
            $0?.layer.cornerRadius = 30
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    
    }
    
    
    @IBAction func ElementButtonTapped(_ sender: UIButton) {
    }
    
    
    @IBAction func HighButtonTapped(_ sender: UIButton) {
    }



    @IBAction func MyVocaButtonTapped(_ sender: UIButton) {
    }
    


}
