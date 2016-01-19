//
//  AppDelegate.swift
//  Mobilize
//
//  Created by Miguel Araújo on 10/19/15.
//  Copyright © 2015 Miguel Araújo. All rights reserved.
//

import UIKit
import Parse
import ParseCrashReporting
import FBSDKCoreKit
import ParseFacebookUtilsV4
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Parse.enableLocalDatastore()
    Parse.setApplicationId("Ind4ALgVPaHk9NDFkRMgZWYm4q1ngr7ouD2387GT", clientKey: "dOIxXW8MYQY37X7PhCqtktaEhvsF5Nyu1HjnB8Qj")
    PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
    PFFacebookUtils.initializeFacebookWithApplicationLaunchOptions(launchOptions)
    
    if application.applicationState != UIApplicationState.Background {
      let preBackgroundPush = !application.respondsToSelector("backgroundRefreshStatus")
      let oldPushHandlerOnly = !self.respondsToSelector("application:didReceiveRemoteNotification:fetchCompletionHandler:")
      var pushPayload = false
      
      if let options = launchOptions {
        pushPayload = options[UIApplicationLaunchOptionsRemoteNotificationKey] != nil
      }
      
      if (preBackgroundPush || oldPushHandlerOnly || pushPayload) {
        PFAnalytics.trackAppOpenedWithLaunchOptions(launchOptions)
      }
    }
    
    if application.respondsToSelector("registerUserNotificationSettings:") {
      let userNotificationTypes = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
      application.registerUserNotificationSettings(userNotificationTypes)
      application.registerForRemoteNotifications()
    } else {
      let types = UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
      application.registerUserNotificationSettings(types)
    }
    
    return true
  }
  
  func applicationWillResignActive(application: UIApplication) {
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    FBSDKAppEvents.activateApp()
  }
  
  func applicationWillTerminate(application: UIApplication) {
  }
  
  func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
    let installation = PFInstallation.currentInstallation()
    installation.setDeviceTokenFromData(deviceToken)
    installation.saveInBackground()
  }
  
  func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
    if error.code == 3010 {
      print("Push notifications are not supported in the iOS Simulator.\n")
    } else {
      print("application:didFailToRegisterForRemoteNotificationsWithError: %@\n", error)
    }
  }
  
  func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
    PFPush.handlePush(userInfo)
    if application.applicationState == UIApplicationState.Inactive {
      PFAnalytics.trackAppOpenedWithRemoteNotificationPayload(userInfo)
    }
  }
  
  func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
    return FBSDKApplicationDelegate.sharedInstance().application(application, openURL: url, sourceApplication: sourceApplication, annotation: annotation)
  }
}
