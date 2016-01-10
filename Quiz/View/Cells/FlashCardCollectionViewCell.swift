//
//  FlashCardCollectionViewCell.swift
//  Quiz
//
//  Created by Rafal Szastok on 10/01/16.
//  Copyright © 2016 Rafal Szastok. All rights reserved.
//

import UIKit

class FlashCardCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView?
    @IBOutlet weak var mainLabel: UILabel?
    
    static func cellSize() -> CGSize {
        return CGSize(width: 140, height: 140)
    }
}
