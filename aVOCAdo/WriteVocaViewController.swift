//
//  WriteVocaViewController.swift
//  aVOCAdo
//
//  Created by 김정연 on 2022/05/16.
//

import UIKit
import AVFoundation

//delegate를 통해서 단어리스트 화면에 작성된 단어 객체를 전달
protocol WriteVocaViewDelegate: AnyObject {
    func didSelectRegister(voca: Voca)
}

class WriteVocaViewController: UIViewController, UITextFieldDelegate {

    //단어 쓰는 칸
    @IBOutlet weak var wordTextField: UITextField!
    //뜻 쓰는 칸
    @IBOutlet weak var meaningTextField: UITextField!
    //등록버튼
    @IBOutlet weak var confirmButton: UIBarButtonItem!
    //음성 버튼
    @IBOutlet weak var ttsButton: UIButton!
    
    let synthesizer = AVSpeechSynthesizer()     //음성버튼을 위한 초기화
    
    weak var delegate: WriteVocaViewDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    

    
    
    //action 등록버튼
    @IBAction func confirmButtonTapped(_ sender: UIBarButtonItem) {
        guard let word = self.wordTextField.text else {return}
        guard let meaning = self.meaningTextField.text else {return}
        let voca = Voca(word: word, meaning: meaning)
        self.delegate?.didSelectRegister(voca: voca)
        self.navigationController?.popViewController(animated: true)
    }
    
    //action TTS-음성버튼
    @IBAction func ttsButtonTapped(_ sender: UIButton) {
        let soundText = AVSpeechUtterance(string: wordTextField.text!)
        soundText.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(soundText)
    }
    
    
    //빈 화면을 클릭했을 때 키보드가 사라지게 만드는 것
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //hello
    
}


