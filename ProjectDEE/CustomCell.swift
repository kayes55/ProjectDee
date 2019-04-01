//
//  CustomCell.swift
//  ProjectDEE
//
//  Created by Imrul Kayes on 3/30/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

class CustomCell: UICollectionViewCell {
    
    var admirers = ConstructListOfAdmirer.construct()
    static var delegate: AdmirerDelegate!
    @IBOutlet weak var embeddedCollectionView: UICollectionView! {
        
        didSet {
            embeddedCollectionView.delegate = self
            embeddedCollectionView.dataSource = self
        }
        
    }
    
    override func awakeFromNib() {
        EmotionCell.delegate = self
    }
    
}


extension CustomCell: UICollectionViewDataSource, UICollectionViewDelegate, HatersDelegate {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return admirers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "embeddedCell", for: indexPath) as! EmbeddedCell
        cell.imageContainer.image = admirers[indexPath.row].image
        cell.emotionButton.setTitle("Hates Me", for: .normal)
        cell.emotionButton.addTarget(self, action: #selector(deleteAdmirer(_:)), for: .touchUpInside)
        return cell
        
    }
    
    @objc func deleteAdmirer(_ sender: UIButton) {
        let index = self.embeddedCollectionView.indexPathForItem(at: self.embeddedCollectionView.convert(sender.center, from: sender.superview))
        
        CustomCell.delegate.sendAdmirer(name: admirers[(index?.item)!].name, description: admirers[(index?.item)!].description)
        admirers.remove(at: index!.item)
        self.embeddedCollectionView.deleteItems(at: [index!])
    
    }

    func sendHaters(name: String?, description: String?) {
        admirers.append(Admirer(name: name!, image: UIImage(named: name!), description: description!))
        self.embeddedCollectionView.reloadData()
    }
}

struct Admirer {
    var name: String?
    var image: UIImage?
    var description: String?
}

class ConstructListOfAdmirer {
    static func construct() -> [Admirer] {
        let temp: [Admirer] = [
            Admirer(name: "Jinia", image: UIImage(named: "Jinia"), description: "Cutie"),
            Admirer(name: "Shotabdi", image: UIImage(named: "Shotabdi"), description: "Hot"),
            Admirer(name: "Safa", image: UIImage(named: "Safa"), description: "Spicy"),
            Admirer(name: "Sabila", image: UIImage(named: "Sabila"), description: "Chilli")]
        
        return temp
    }
}

protocol AdmirerDelegate {
    func sendAdmirer(name: String?, description: String?)
}
