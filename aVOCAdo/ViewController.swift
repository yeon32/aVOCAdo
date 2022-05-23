//
//  ViewController.swift
//  aVOCAdo
//
//  Created by 김정연 on 2022/05/16.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var vocaList = [Voca]() {
        didSet{
            self.saveVocaList()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureCollectionView()
        self.loadVocaList()
    }
    
    private func configureCollectionView() {
        self.collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10,
                                                        right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    //내용 받기 (segue를 통해서 하기 때문에 prepare 메서드를 사용)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let wireVocaViewController = segue.destination as? WriteVocaViewController{
            wireVocaViewController.delegate = self
        }
    }
    
    //앱을 꺼도 단어가 그대로 유지되게끔
    private func saveVocaList() {
        let date = self.vocaList.map {
            [
                "word": $0.word,
                "meaning": $0.meaning
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: "vocaList")
    }
    
    //저장된 값을 불러오기
    private func loadVocaList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "vocaList") as? [[String: Any]] else { return }
        self.vocaList = data.compactMap {
            guard let word = $0["word"] as? String else { return nil }
            guard let meaning = $0["meaning"] as? String else { return nil }
            return Voca(word: word, meaning: meaning)
        }
    }
}
extension ViewController: WriteVocaViewDelegate {
    func didSelectRegister(voca: Voca) {
        self.vocaList.append(voca)
        self.collectionView.reloadData()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vocaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VocaCell", for: indexPath) as? VocaCell else { return UICollectionViewCell()}
        let voca = self.vocaList[indexPath.row]
        cell.wordLabel.text = voca.word
        return cell
    }
}

//특정 셀이 선택 되었을 때
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let viewController = self.storyboard?.instantiateViewController(identifier: "VocaDetailViewController") as? VocaDetailViewController else { return }
        let voca = self.vocaList[indexPath.row]
        viewController.voca = voca
        viewController.indexPath = indexPath
        viewController.delegate = self
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
}

extension ViewController: VocaDetailViewDelegate {
    func didSelectDelete(indexPath: IndexPath) {
        self.vocaList.remove(at: indexPath.row)
        self.collectionView.deleteItems(at: [indexPath])
    }
}



 
