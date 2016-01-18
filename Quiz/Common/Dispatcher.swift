//
//  Dispatcher.swift
//  Goalv8
//
//  Created by Jakub Gert on 07/10/15.
//  Copyright © 2015 Perform. All rights reserved.
//

import Foundation

class Dispatcher {
    
    typealias DispatchBlock = ((Void)->Void)
    
    enum Queue{
        case Current
        case Main
        case Background
        case Custom(dispatch_queue_t)
        
        func dispatch(callback : DispatchBlock?) -> Void {
            if let callback = callback {
                switch(self) {
                case .Current:
                    callback()
                case .Main:
                    dispatch_async(dispatch_get_main_queue(), callback)
                case .Background:
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), callback)
                case .Custom(let queue):
                    dispatch_async(queue, callback)
                }
            }
        }
        
    }
}