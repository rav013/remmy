//
//  ModelProtocols.swift
//  Quiz
//
//  Created by Rafal Szastok on 15/01/16.
//  Copyright © 2016 Rafal Szastok. All rights reserved.
//

import Foundation
import Parse

protocol ParseComModel {
    
//    static var cellIdentifier: String {
//        let typeNameWithModule = NSStringFromClass(self)
//        var typeName = ""
//        if let strippedName = typeNameWithModule.componentsSeparatedByString(".").last {
//        typeName = strippedName
//        }
//        
//        return typeName
//    }
    
    init(object:PFObject)
}

class PrimaryParseComModel {
    
    static func className() -> String {
        let typeNameWithModule = NSStringFromClass(self)
        if let strippedName = typeNameWithModule.componentsSeparatedByString(".").last {
            return strippedName
        }
        return typeNameWithModule
    }
}