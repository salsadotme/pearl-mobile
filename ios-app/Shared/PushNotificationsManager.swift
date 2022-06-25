//
//  PushNotificationsManager.swift
//  Pearl
//
//  Created by Zorayr Khalapyan on 6/25/22.
//

import Foundation
import FirebaseMessaging
import FirebaseFunctions
import SwiftUI

class PushNotificationManager: NSObject {
    
    public static var sharedInstance = PushNotificationManager()
    private override init() {}
    
    static func subscribeToProject(project: String, type: String) {
        let topic = "\(project)-\(type)"
        Messaging.messaging().subscribe(toTopic: topic) { _ in
            print("Subscribed to topic: \(topic)")
        }
    }
    
    static func unsubscribeFromProject(project: String, type: String) {
        Messaging.messaging().unsubscribe(fromTopic: project + "-" + type) { _ in
            print("Subscribed to prpject's topic.")
        }
    }
    
    
    static func registerForRemoteNotifications(didAuthorize: (() -> Void)? = nil) {
        let application = UIApplication.shared
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(
                    options: [.alert, .badge, .sound],
                    completionHandler: {(granted, _) in
                        DispatchQueue.main.async {
                            if granted {
                                application.registerForRemoteNotifications()
                                if let didAuthorize = didAuthorize {
                                    didAuthorize()
                                }
                            }
                        }
                    })
            } else if settings.authorizationStatus == .authorized {
                DispatchQueue.main.async {
                    application.registerForRemoteNotifications()
                    if let didAuthorize = didAuthorize {
                        didAuthorize()
                    }
                }
            }
        }
    }
}

/**
 * Make sure you are looking at Firebase iOS 10+ documentaiton, they have one for older versions as well.
 * Here is a good link: https://firebase.google.com/docs/cloud-messaging/ios/receive#handle-swizzle
 */
extension PushNotificationManager: UNUserNotificationCenterDelegate {
    /**
     * Remember this is only for deciding what to do when the notification is recieved in the foreground!
     * Will not get called when the app is in the background!
     */
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let userInfo = notification.request.content.userInfo
        print(userInfo)
        completionHandler([[.banner, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        completionHandler()
    }
}
