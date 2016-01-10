//
//  UICollectionView+Dequeue.swift
//  Quiz
//
//  Created by Rafal Szastok on 10/01/16.
//  Copyright © 2016 Rafal Szastok. All rights reserved.
//

import UIKit


protocol ReusableTableViewCellIdentifier {
    static var cellIdentifier: String {get}
}

extension UITableViewCell: ReusableTableViewCellIdentifier {
    
    class var cellIdentifier: String {
        let typeNameWithModule = NSStringFromClass(self)
        var typeName = ""
        if let strippedName = typeNameWithModule.componentsSeparatedByString(".").last {
            typeName = strippedName
        }
        
        return typeName
    }
    
    class var nibName: String {
        get {
            return cellIdentifier
        }
    }
    
    static func registerCell(tableView: UITableView) {
        let nib = UINib(nibName: nibName, bundle: NSBundle.mainBundle())
        tableView.registerNib(nib, forCellReuseIdentifier: cellIdentifier)
    }
    
    static func cell(tableView: UITableView, indexPath: NSIndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
    }
}

extension UICollectionViewCell: ReusableTableViewCellIdentifier {
    
    class var cellIdentifier: String {
        let typeNameWithModule = NSStringFromClass(self)
        var typeName = ""
        if let strippedName = typeNameWithModule.componentsSeparatedByString(".").last {
            typeName = strippedName
        }
        
        return typeName
    }
    
    class var nibName: String {
        get {
            return cellIdentifier
        }
    }
    
    static func registerCell(collectionView: UICollectionView) {
        let nib = UINib(nibName: nibName, bundle: NSBundle.mainBundle())
        collectionView.registerNib(nib, forCellWithReuseIdentifier: cellIdentifier)
    }
    
    static func cell(collectionView: UICollectionView, indexPath: NSIndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath)
    }
}
