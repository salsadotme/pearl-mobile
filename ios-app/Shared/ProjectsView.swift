//
//  ToggleView.swift
//  Pearl
//
//  Created by Zorayr Khalapyan on 6/25/22.
//

import SwiftUI
import UIKit

struct Project: Hashable {
    let id: String
    let title: String
    let content: String
    let senderProfilePhoto: URL
}

let projects: [Project] = [
    Project(id: "1", title: "Bullish Bears", content: "Yet another Messaging Protocol", senderProfilePhoto: URL(string: "https://pbs.twimg.com/profile_images/977496875887558661/L86xyLF4_400x400.jpg")!),
    Project(id: "2", title: "Illuminati", content: "Yet another Messaging Protocol", senderProfilePhoto: URL(string: "https://pbs.twimg.com/profile_images/977496875887558661/L86xyLF4_400x400.jpg")!),
    Project(id: "3", title: "Crypto Dates", content: "Yet another Messaging Protocol", senderProfilePhoto: URL(string: "https://pbs.twimg.com/profile_images/977496875887558661/L86xyLF4_400x400.jpg")!),
    Project(id: "4", title: "FWB", content: "Yet another messaging protocol", senderProfilePhoto: URL(string: "https://pbs.twimg.com/profile_images/977496875887558661/L86xyLF4_400x400.jpg")!),
]

struct ProjectsView: View {
    
    @State private var projectToggle = true
    @State private var fakeToggle = true
    
    init() {
        Theme.navigationBarColors(background: .clear, titleColor: .white)
    }
    
    func cell(project: Project) -> some View {
        NavigationLink(destination: ToggleView()) {
            VStack {
                HStack{
                    Text(project.title)
                    Spacer()
                    Image(systemName: "arrow.right")
                }.padding(20)
                Divider()
                    .frame(height: 1.25)
                    .background(Color.white.opacity(0.25))
            }
        }
    }
    
    var body: some View {
        return NavigationView {
            VStack (alignment: .leading){
                Text("Select the projects you would like to receive notifications from.")
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 15)
                VStack(alignment: .leading, spacing: 0){
                    ForEach(projects, id: \.self) { project in
                        cell(project: project)
                    }
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color.white.opacity(0.25), lineWidth: 1.25)
                )
                Spacer()
            }
            .padding()
            .navigationTitle("Your NFTs")
            .background(
                RadialGradient(gradient: Gradient(colors: [Color(hex: 0x006D75), Color(hex: 0x00474F), Color(hex: 0x22075E)]), center: .topLeading, startRadius: 250, endRadius: 800)
            )
        }
        .foregroundColor(.white)
    }
}

struct ProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProjectsView()
    }
}
