//
//  FlashCardModel.swift
//  Quiz
//
//  Created by Rafal Szastok on 15/01/16.
//  Copyright © 2016 Rafal Szastok. All rights reserved.
//

import Foundation
import Parse

class FlashCardModel: ParseComModelMappable {
    
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
    
    static func className() -> String {
        return "FlashCard"
    }
}
