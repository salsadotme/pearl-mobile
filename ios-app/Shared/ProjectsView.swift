//
//  ToggleView.swift
//  Pearl
//
//  Created by Zorayr Khalapyan on 6/25/22.
//

import SwiftUI
import UIKit
import SDWebImageSwiftUI

struct Project: Hashable {
    let id: String
    let title: String
    let content: String
    let projectProfilePhoto: URL
}

let projects: [Project] = [
    Project(id: "1", title: "Bullish Bears", content: "Yet another Messaging Protocol", projectProfilePhoto: URL(string: "https://pbs.twimg.com/profile_images/977496875887558661/L86xyLF4_400x400.jpg")!),
    Project(id: "2", title: "Illuminati", content: "Yet another Messaging Protocol", projectProfilePhoto: URL(string: "https://pbs.twimg.com/media/FV4bX_bXkAUJGRu?format=jpg&name=4096x4096")!),
    Project(id: "3", title: "Crypto Dates", content: "Yet another Messaging Protocol", projectProfilePhoto: URL(string: "https://i.imgur.com/v4S8w7k.jpg")!),
    Project(id: "4", title: "FWB", content: "Yet another messaging protocol", projectProfilePhoto: URL(string: "https://pbs.twimg.com/profile_images/1460869637139271680/d0X1drlC_400x400.jpg")!),
]

struct ProjectsView: View {
    
    @State private var projectToggle = true
    @State private var fakeToggle = true
    
    init() {
        Theme.navigationBarColors(background: .clear, titleColor: .white)
    }
    
    func cell(project: Project, isLast:Bool) -> some View {
        NavigationLink(destination: ToggleView(title: project.title)) {
            VStack (alignment: .center, spacing: 0) {
                HStack(alignment: .center) {
                    WebImage(url: project.projectProfilePhoto)
                        .resizable()
                        .indicator(.activity)
                        .transition(.fade(duration: 0.5))
                        .scaledToFill()
                        .frame(width: 40.0, height: 40.0, alignment: .center)
                        .clipShape(Circle())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 15)
                    Text(project.title)
                    Spacer()
                    Image(systemName: "arrow.right")
                        .padding()
                }
                if (!isLast) {
                    Divider()
                        .frame(height: 1.25)
                        .background(Color.white.opacity(0.25))
                }
            }.background(Color.white.opacity(0.10))
        }
    }
    
    var body: some View {
        VStack (alignment: .leading){
            Text("Select the projects you would like to receive notifications from.")
                .fixedSize(horizontal: false, vertical: true)
                .padding(.bottom, 15)
            VStack(alignment: .leading, spacing: 0){
                ForEach(projects, id: \.self) { project in
                    cell(project: project, isLast: project.id == "4")
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color.white.opacity(0.25), lineWidth: 1.25)
            )
            Spacer()
            NavigationLink(destination: ContentView()) {
                Text("Continue")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(hex: 0x1890FF)))
            }
        }
        .padding()
        .navigationTitle("Your NFTs")
        .background(appBackgroundGradient)
        .foregroundColor(.white)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
