//
//  ContentView.swift
//  Shared
//
//  Created by Zorayr Khalapyan on 6/24/22.
//

import SwiftUI
import SDWebImageSwiftUI

let fakeData: [NotificationData] = [
    NotificationData(id: "1", title: "New partnership with Sofia Vegara", content: "She chose us as the first...", senderProfilePhoto: URL(string: "https://i.imgur.com/v4S8w7k.jpg")!),
    NotificationData(id: "2", title: "Event at NFT NYC", content: "We are hosting an event for ...", senderProfilePhoto: URL(string: "https://pbs.twimg.com/media/FV4bX_bXkAUJGRu?format=jpg&name=4096x4096")!),
    NotificationData(id: "3", title: "Whitelist access", content: "We are hosting an event for ...", senderProfilePhoto: URL(string: "https://pbs.twimg.com/profile_images/1496541840341831682/Gtzt5e-K_400x400.png")!),
]

private func cell(_ model: NotificationData) -> some View {
    ZStack {
        HStack(alignment: .center) {
            WebImage(url: model.senderProfilePhoto)
                .resizable()
                .indicator(.activity)
                .animation(.easeInOut(duration: 0.5))
                .transition(.fade)
                .scaledToFill()
                .frame(width: 70.0, height: 70.0, alignment: .center)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 0) {
                Text(model.title)
                    .fontWeight(.medium)
                    .lineLimit(2)
                    .padding([.bottom], 0)
                Text(model.content)
                    .fontWeight(.light)
                    .lineLimit(2)
                    .padding([.top], 3)
                    .padding([.bottom], 0)
                    .padding([.top], 0)
            }
            Spacer()
            Image(systemName: "chevron.right").imageScale(.small)
        }
        .padding()
        .fixedSize(horizontal: false, vertical: true)
        .frame(height: 100)
        .background(Color.white.opacity(0.10))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color.white.opacity(0.25), lineWidth: 1.25)
        )
        .clipped()
        .cornerRadius(10)
        .padding(.horizontal, 20)
    }
}

struct ContentView: View {
    init() {
        Theme.navigationBarColors(background: .clear, titleColor: .white)
    }
    
    var body: some View {
        VStack {
            ForEach(fakeData, id: \.id) { data in
                NavigationLink(destination: NotificationDetailsView(notification: data)) {
                    cell(data)
                }
            }
            Spacer()
        }
        .navigationTitle("Inbox")
        .foregroundColor(.white)
        .background(appBackgroundGradient)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
