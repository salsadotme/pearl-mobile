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
                Text("Words cannot express how proud we are to have been selected as the launch partner of Sofia’s NFT Club, an initiative led by Sofia Vergara and LatinWe! \n\nSofia’s NFT Club was launched to educate new audiences about web3 and will do a deep dive into one NFT project each month; and May is the month of Angels! \n\nLearn more about our partnership and how you can participate. ")
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
