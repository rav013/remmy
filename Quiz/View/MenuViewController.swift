//
//  ViewController.swift
//  Quiz
//
//  Created by Rafal Szastok on 07/01/16.
//  Copyright © 2016 Rafal Szastok. All rights reserved.
//

import UIKit
import Parse

class MenuViewController: UIViewController {
    
    @IBOutlet weak var mainCollectionView: UICollectionView?
    var objects:[PFObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let query = PFQuery(className: "FlashCard")
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
            if let objects = objects {
                self.objects.appendContentsOf(objects)
                self.mainCollectionView?.reloadData()
            } else {
                print("Error during downloading flash cards")
            }
        }
        
        if let collectionView = mainCollectionView {
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
            flowLayout.itemSize = FlashCardCollectionViewCell.cellSize()
            flowLayout.minimumInteritemSpacing = 10
            flowLayout.minimumLineSpacing = 10
            collectionView.collectionViewLayout = flowLayout
            collectionView.backgroundColor = UIColor(netHex: 0xffdddddd)
            
            FlashCardCollectionViewCell.registerCell(collectionView)
        }
    }
}

extension MenuViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        FlashCardCollectionViewCell.cell(collectionView, indexPath: indexPath)
        if let cell = FlashCardCollectionViewCell.cell(collectionView, indexPath: indexPath) as? FlashCardCollectionViewCell {
            let obj = objects[indexPath.row]
            cell.mainLabel?.text = "\(indexPath.row+1). \(obj["questionText"])"
            return cell
        }
        
        assertionFailure("Cannot find cells")
        return UICollectionViewCell()
    }
}