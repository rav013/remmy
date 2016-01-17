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
    
    let disposeBag = DisposeBag()
    
    var flashCards:[FlashCardModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let loader = ParseComLoader<FlashCardModel>()
        loader.fetchCards().subscribe(onNext: { (cardsModel) -> (Void) in
            self.flashCards = cardsModel
            self.mainCollectionView?.reloadData()
            print("Card has been downloaded")
        }, onError: { (error) -> Void in
            print("Downloading error \(error)")
        })
        .addDisposableTo(disposeBag)
        
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
        return flashCards.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        FlashCardCollectionViewCell.cell(collectionView, indexPath: indexPath)
        if let cell = FlashCardCollectionViewCell.cell(collectionView, indexPath: indexPath) as? FlashCardCollectionViewCell {
            cell.mainLabel?.text = flashCards[indexPath.row].questionText
            return cell
        }
        
        assertionFailure("Cannot find cells")
        return UICollectionViewCell()
    }
}