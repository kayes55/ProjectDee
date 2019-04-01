//
//  ViewController.swift
//  ProjectDEE
//
//  Created by Imrul Kayes on 3/29/19.
//  Copyright © 2019 Imrul Kayes. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var containerCollectionView: UICollectionView!
    var sectionNames: [String] = ["Admirers", "Haters"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "EmotionCell", bundle: nil)
        containerCollectionView.register(nib, forCellWithReuseIdentifier: "EmotionCell")
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sectionNames.count
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContainerCell", for: indexPath) as! CustomCell
            return cell
        } else {
            // use another cell here
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmotionCell", for: indexPath) as! EmotionCell
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var v : UICollectionReusableView! = nil
        if kind == UICollectionView.elementKindSectionHeader {
            v = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath)
            
            let lab = v.subviews[0] as! UILabel
            lab.text = sectionNames[indexPath.section]
        }
        return v
        
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
//    }
    
    
}

