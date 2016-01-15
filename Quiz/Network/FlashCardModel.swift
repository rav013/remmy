//
//  FlashCardModel.swift
//  Quiz
//
//  Created by Rafal Szastok on 15/01/16.
//  Copyright © 2016 Rafal Szastok. All rights reserved.
//

import Foundation
import Parse

class FlashCardModel: PrimaryParseComModel, ParseComModel {
    
    let questionText: String?
    let questionImageData: UIImage?
    let answerText: String?
    let anwserImageData: UIImage?
    
    required init(object: PFObject) {
        questionText = object["questionText"] as? String
        questionImageData = object["questionImage"] as? UIImage
        answerText = object["answerText"] as? String
        anwserImageData = object["answerImage"] as? UIImage
    }
}


//enum Result<T> {
//    case Success(T)
//    case Failure(NSError)
//}

//typealias FlashCardResponse = Result<FlashCardModel>

class ParseComLoader<T: ParseComModel> { //PrimatyParseComModel
    func fetchCards() -> Observable<[T]> {
        
        let observable = create { (observer: AnyObserver<[T]>) -> Disposable in
            let query = PFQuery(className: FlashCardModel.className() )
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