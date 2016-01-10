//
//  AppDelegate.swift
//  Quiz
//
//  Created by Rafal Szastok on 07/01/16.
//  Copyright © 2016 Rafal Szastok. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // [Optional] Power your app with Local Datastore. For more info, go to
        // https://parse.com/docs/ios/guide#local-datastore
        Parse.enableLocalDatastore()
        
        // Initialize Parse.
        Parse.setApplicationId("YzkVuhv8j8x79roFfXrL4l099hNntmiN41vYS0QV",
            clientKey: "34kXNmQMmNSgBq722QQYfFB5ITOOlpVknvT41hBe")
        
        // [Optional] Track statistics around application opens.
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
        
        // ...
        return true
    }

}

