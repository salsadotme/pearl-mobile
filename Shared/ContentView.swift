//
//  ContentView.swift
//  Shared
//
//  Created by Zorayr Khalapyan on 6/24/22.
//

import SwiftUI
import SDWebImageSwiftUI

let fakeData: [NotificationData] = [
    NotificationData(id: "1", title: "Hello World 1", content: "Yet another Messaging Protocol", senderProfilePhoto: URL(string: "https://pbs.twimg.com/profile_images/977496875887558661/L86xyLF4_400x400.jpg")!),
    NotificationData(id: "1", title: "Hello World 2", content: "Yet another Messaging Protocol", senderProfilePhoto: URL(string: "https://pbs.twimg.com/profile_images/977496875887558661/L86xyLF4_400x400.jpg")!),
    NotificationData(id: "1", title: "Hello World 3", content: "Yet another Messaging Protocol", senderProfilePhoto: URL(string: "https://pbs.twimg.com/profile_images/977496875887558661/L86xyLF4_400x400.jpg")!),
    NotificationData(id: "1", title: "Hello World 4", content: "Yet another messaging protocol", senderProfilePhoto: URL(string: "https://pbs.twimg.com/profile_images/977496875887558661/L86xyLF4_400x400.jpg")!),
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
                    .padding([.top], 8)
                    .padding([.bottom], 0)
                Text(model.content)
                    .fontWeight(.regular)
                    .lineLimit(2)
                    .padding([.top], 3)
                    .padding([.bottom], 0)
                    .foregroundColor(.blue)
                .padding([.top], 0)
            }
            Image(systemName: "chevron.right").imageScale(.small)
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(height: 100)
        
        Button(action: {
            
        }) {
            EmptyView()
        }
    }
}

struct ContentView: View {
    var body: some View {
        return VStack {
            List {
                ForEach(fakeData, id: \.id) { data in
                    cell(data)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
