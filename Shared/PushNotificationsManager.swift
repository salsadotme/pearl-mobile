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

enum FirebaseMessagingTopics: CaseIterable {
    
    typealias AllCases = [FirebaseMessagingTopics]
    static var allCases: [FirebaseMessagingTopics] {
        return [
            .wallet(walletId: ""),
        ]
    }
    
    case all
    
    case wallet(walletId: String)
    
    func toString() -> String {
        switch self {
        case .all:
            return "all"
        case let .wallet(walletId):
            return "wallet-\(walletId)"
        }
    }
    
    static func topicFromString(_ string: String) -> FirebaseMessagingTopics? {
        for topic in FirebaseMessagingTopics.allCases {
            if string.starts(with: topic.toString()) {
                if case .wallet = topic {
                    let topicComponents = string.split(separator: "-")
                    if topicComponents.count != 2 {
                        return nil
                    }
                    return .wallet(walletId: String(topicComponents[1]))
                } else {
                    return topic
                }
            }
        }
        assertionFailure("What's this new topic \(string), I haven't heard about?")
        return .all
    }
    
    static func currentWalletTopic() -> String {
        // TODO: Wire this shit up baby!
        return FirebaseMessagingTopics.wallet(walletId: "0xB3DACD1C7Db88Cb28D4F024165ef7e9dbC12C268").toString()
    }
}

private let gcmMessageIDKey = "gcm.message_id"

class PushNotificationManager: NSObject {
    
    public static var sharedInstance = PushNotificationManager()
    private override init() {}
    
    // MARK: Push Registration Logic
    
    static func subscribe() {
        Messaging.messaging().subscribe(toTopic: FirebaseMessagingTopics.all.toString()) { _ in
            print("Subscribed to all topic.")
        }
        Messaging.messaging().subscribe(toTopic: FirebaseMessagingTopics.currentWalletTopic()) { _ in
            print("Subscribed to current user topic.")
        }
    }
    
    static func registerForRemoteNotifications(didAuthorize: (() -> Void)? = nil) {
        // DEBUG CODE: Uncomment for debugging deep links.
        // Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { timer in
        //DeepLinkManager.sharedInstance.deepLinkDestination = .matchingView(socialId: "T4az9EUhBD24dzSRrB2z")
        //DeepLinkManager.sharedInstance.deepLinkDestination = .chat(chatId: "L6mRqMzaARZTb0WtzfhQ", options: .openPendingParticipantsView)
        // }
        
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
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        print(userInfo)
        completionHandler([[.banner, .sound]])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        if let topicString = userInfo["topic"] as? String, let topic = FirebaseMessagingTopics.topicFromString(topicString) {
            if response.actionIdentifier == UNNotificationDefaultActionIdentifier {
                switch topic {
                case .all:
                    break;
                case let .wallet(walletId: walletId):
                    print(walletId)
                }
            }
            completionHandler()
        }
        
    }
}
