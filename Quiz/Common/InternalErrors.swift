//
//  DomesticErrors.swift
//  Quiz
//
//  Created by Rafal Szastok on 16/01/16.
//  Copyright © 2016 Rafal Szastok. All rights reserved.
//

import Foundation

enum InternalErrors: Int {
    private struct Consts {
        static let LocalDomain = "Quiz"
    }
    
    case NoResult = 3000
    
    func getError() -> NSError {
        switch self {
        case .NoResult:
            let userInfo = [NSLocalizedDescriptionKey : "No items to return."]
            return NSError(domain: Consts.LocalDomain, code: self.rawValue, userInfo: userInfo)
        }
        
    }
}