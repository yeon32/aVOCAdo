//
//  WriteVocaViewController.swift
//  aVOCAdo
//
//  Created by 김정연 on 2022/05/16.
//

import UIKit
import AVFoundation

protocol WriteVocaViewDelegate: AnyObject {
    func didSelectRegister(voca: Voca)
}

class WriteVocaViewController: UIViewController, UITextFieldDelegate {

    //단어 쓰는 칸
    @IBOutlet weak var vocaTextField: UITextField!
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
        self.configureInputField()
        self.confirmButton.isEnabled = false //등록버튼 비활성화
        
    }
    
    
    //모든 칸이 적혀졌을 때 등록버튼이 활성화
    private func configureInputField() {
        self.meaningTextField.delegate = self
        self.vocaTextField.addTarget(self, action: #selector(vocaTextFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    //action 등록버튼
    @IBAction func confirmButtonTapped(_ sender: UIBarButtonItem) {
        guard let voca = self.vocaTextField.text else {return}
        guard let meaning = self.meaningTextField.text else {return}
        let Voca = Voca(voca: voca, meaning: meaning)
        self.delegate?.didSelectRegister(voca: Voca)
        self.navigationController?.popViewController(animated: true)
    }
    
    //action TTS-음성버튼
    @IBAction func ttsButtonTapped(_ sender: UIButton) {
        let soundText = AVSpeechUtterance(string: vocaTextField.text!)
        soundText.voice = AVSpeechSynthesisVoice(language: "en-US")
        synthesizer.speak(soundText)
    }
    
    
    //빈 화면을 클릭했을 때 키보드가 사라지게 만드는 것
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //단어칸이 입력될 때마다 등록버튼 활성화 여부 판단
    @objc private func vocaTextFieldDidChange(_ textField: UITextField) {
        self.validateInputField()
    }
    
    //단어칸, 뜻칸이 모두 채워졌을 때 등록버튼 활성화
    private func validateInputField() {
        self.confirmButton.isEnabled = !(self.vocaTextField.text?.isEmpty ?? true) &&
        !(self.meaningTextField.text?.isEmpty ?? true)
    }
}


extension WriteVocaViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        self.validateInputField()
    }
}

