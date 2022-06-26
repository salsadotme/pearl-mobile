//
//  ContentView.swift
//  Shared
//
//  Created by Zorayr Khalapyan on 6/24/22.
//

import SwiftUI
import SDWebImageSwiftUI
import FirebaseCore
import FirebaseFirestore

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
                .transition(.fade(duration: 0.5))
                .scaledToFill()
                .frame(width: 70.0, height: 70.0, alignment: .center)
                .clipShape(Circle())
            VStack(alignment: .leading, spacing: 0) {
                Text(model.title)
                    .fontWeight(.medium)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding([.bottom], 0)
                Text(model.content)
                    .fontWeight(.light)
                    .lineLimit(2)
                    .multilineTextAlignment(.leading)
                    .padding([.top], 3)
                    .padding([.bottom], 0)
            }
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
    let db = Firestore.firestore()
    
    @Environment(\.scenePhase) var scenePhase
    
    @State private var messages: [NotificationData] = []
    
    init() {
        Theme.navigationBarColors(background: .clear, titleColor: .white)
    }
    
    private func fetch() {
        db.collection("recipients")
            .document("0x06e6f7D896696167B2dA9281EbAF8a14580fbFCc")
            .collection("messages")
            .order(by: "sentAt", descending: true)
            .getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    print(querySnapshot!.count)
                    messages.removeAll()
                    for document in querySnapshot!.documents {
                        let maybePhoto = document.get("senderProfilePhoto")
                        let photo = maybePhoto != nil ? URL(string: maybePhoto as! String) : URL(string: "https://firebasestorage.googleapis.com/v0/b/pearl-dev-f60a5.appspot.com/o/dallemini_2022-6-26_2-48-5.png?alt=media")
                        messages.append(NotificationData(id: document.documentID, title: document.get("title") as! String, content: document.get("body") as! String, senderProfilePhoto: photo!))
                    }
                }
            }
    }
    
    var body: some View {
        VStack {
            ForEach(messages, id: \.id) { data in
                NavigationLink(destination: NotificationDetailsView(notification: data)) {
                    cell(data)
                }
            }
            Spacer()
        }
        .navigationTitle("Inbox")
        .toolbar {
            Button("gracew.eth") {
                print("Help tapped!")
            }.foregroundColor(Color.white.opacity(0.4))
        }
        .foregroundColor(.white)
        .background(appBackgroundGradient)
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                fetch()
            }
        }
        .onAppear {
            fetch()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ContentView()
        }
        
    }
}
