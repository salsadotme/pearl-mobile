//
//  NotificationDetailsView.swift
//  Pearl
//
//  Created by Zorayr Khalapyan on 6/26/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct NotificationDetailsView: View {
    var notification: NotificationData

    var body: some View {
        VStack () {
            VStack (alignment: .leading) {
                HStack {
                    WebImage(url: notification.senderProfilePhoto)
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                        .frame(width: 40.0, height: 40.0, alignment: .center)
                        .clipShape(Circle())
                    Text(notification.title)
                        .font(.system(size: 17, weight: .bold))
                    Spacer()
                }
                Text("GM Bears, we know you’ve been busy hacking this weekend. You pushed code instead of pulling a date, skipped drinks for coffees at 3am and missed your favourite DJs. But don’t you worry. The Bear team has got you covered.\n\nAll Bear holders are invited to our afterparty. Location will be sent through Pearl at 6pm. If you know you know 🐻")
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .circular)
                    .stroke(Color.white.opacity(0.25), lineWidth: 1.25)
                    .background(Color.white.opacity(0.1))
            )
            Spacer()
        }
        .padding()
        .background(appBackgroundGradient)
        .navigationTitle(notification.title)
        .foregroundColor(.white)
        
        
    }
}

struct NotificationDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationDetailsView(notification: NotificationData(id: "1", title: "New partnership with Sofia Vegara", content: "She chose us as the first...", senderProfilePhoto: URL(string: "https://i.imgur.com/v4S8w7k.jpg")!))
    }
}
