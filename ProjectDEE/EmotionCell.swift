//
//  EmotionCell.swift
//  ProjectDEE
//
//  Created by Imrul Kayes on 4/1/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

class EmotionCell: UICollectionViewCell {
    
    var girls: [Haters] = [Haters]()
    static var delegate: HatersDelegate?
    @IBOutlet weak var girlsCollection: UICollectionView! {
        didSet {
            girlsCollection.delegate = self
            girlsCollection.dataSource = self
        }
    }
    
    override func awakeFromNib() {
        
        CustomCell.delegate = self
        
        let nib = UINib(nibName: "Description", bundle: nil)
        girlsCollection.register(nib, forCellWithReuseIdentifier: "DescriptionCell")
    }
}

extension EmotionCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, AdmirerDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return girls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
        cell.name.text = girls[indexPath.row].name
        cell.descriptionLabel.text = girls[indexPath.row].description
        cell.likeButton.setTitle("Likes Me", for: .normal)
        cell.likeButton.addTarget(self, action: #selector(deleteHater(_:)), for: .touchUpInside)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    @objc func deleteHater(_ sender: UIButton) {
        let index = self.girlsCollection.indexPathForItem(at: self.girlsCollection.convert(sender.center, from: sender.superview))
        
        EmotionCell.delegate?.sendHaters(name: girls[(index?.item)!].name!, description: girls[(index?.item)!].description)
        girls.remove(at: index!.item)
        self.girlsCollection.deleteItems(at: [index!])
        
    }
    
    func sendAdmirer(name: String?, description: String?) {
        girls.append(Haters(name: name, description: description))
        girlsCollection.reloadData()
    }
    
    
}

struct Haters {
    var name: String?
    var description: String?
}

//class FactoryOfGirls {
//    static func makeGirls() -> [Haters] {
//        let varG = [Haters(name: "Jinia", description: "Cutie"), Haters(name: "Shotabdi", description: "Hot"), Haters(name: "Safa", description: "Spicy"), Haters(name: "Sabila", description: "Chilli")]
//
//        return varG
//    }
//}

protocol HatersDelegate {
    func sendHaters(name: String?, description: String?)
}
