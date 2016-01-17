//
//  ParseDownloader.swift
//  Quiz
//
//  Created by Rafal Szastok on 16/01/16.
//  Copyright © 2016 Rafal Szastok. All rights reserved.
//

import Foundation
import Parse

protocol ParseComModelMappable {
    
    init(object:PFObject)
    static func className() -> String
}

class ParseComLoader<T: ParseComModelMappable> {
    func fetchCards() -> Observable<[T]> {
        
        let observable = create { (observer: AnyObserver<[T]>) -> Disposable in
            let query = PFQuery(className: T.className() )
            query.findObjectsInBackgroundWithBlock { (response:[PFObject]?, error:NSError?) -> Void in
                if let resposne = response {
                    let flashCards = resposne.map{T.init(object: $0)}
                    observer.onNext(flashCards)
                    observer.onCompleted()
                } else {
                    observer.onError(error ?? InternalErrors.NoResult.getError())
                }
            }
            return NopDisposable.instance
        }
        return observable
    }
}