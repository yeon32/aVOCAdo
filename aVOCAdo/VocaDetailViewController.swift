//
//  VocaDetailViewController.swift
//  aVOCAdo
//
//  Created by 김정연 on 2022/05/16.
//

import UIKit

protocol VocaDetailViewDelegate: AnyObject {
    func didSelectDelete(indexPath: IndexPath)
}

class VocaDetailViewController: UIViewController {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var meaningLabel: UILabel!
    weak var delegate: VocaDetailViewDelegate?
    
    
    var voca: Voca?
    var indexPath: IndexPath?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureView()

    }
    
    private func configureView() {
        guard let voca = self.voca else { return }
        self.wordLabel.text = voca.word
        self.meaningLabel.text = voca.meaning
    }
    
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "WriteVocaViewController") as? WriteVocaViewController else { return }
        guard let indexPath = self.indexPath else { return }
        guard let voca = self.voca else { return }
        viewController.vocaEditorMode = .edit(indexPath, voca)
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
       
    
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        guard let indexPath = self.indexPath else { return }
            self.delegate?.didSelectDelete(indexPath: indexPath)
            self.navigationController?.popViewController(animated: true)

    }

}
