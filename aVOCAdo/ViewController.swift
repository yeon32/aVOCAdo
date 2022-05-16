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
        self.collectionView.collectionViewLayout = UICollectionViewLayout()
        self.collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 10,
                                                        right: 10)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let WireVocaViewController = segue.destination as? WriteVocaViewController{
            WireVocaViewController.delegate = self
        }
    }
    private func saveVocaList() {
        let date = self.vocaList.map {
            [
                "voca": $0.voca,
                "meaning": $0.meaning
            ]
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(date, forKey: "vocaList")
    }
    private func loadVocaList() {
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "vocaList") as? [[String: Any]] else { return }
        self.vocaList = data.compactMap {
            guard let voca = $0["voca"] as? String else { return nil }
            guard let meaning = $0["meaning"] as? String else { return nil }
            return Voca(voca: voca, meaning: meaning)
        }
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.vocaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VocaCell", for: indexPath) as? VocaCell else { return UICollectionViewCell()}
        let voca = self.vocaList[indexPath.row]
        cell.vocaLabel.text = voca.voca
        return cell
    }
}

extension ViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
                        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (UIScreen.main.bounds.width / 2) - 20, height: 200)
    }
}


extension ViewController: WriteVocaViewDelegate {
    func didSelectRegister(voca: Voca) {
        self.vocaList.append(voca)
        self.collectionView.reloadData()
    }
}
 
