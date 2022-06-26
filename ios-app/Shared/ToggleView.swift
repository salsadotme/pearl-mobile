//
//  ToggleView.swift
//  Pearl
//
//  Created by Zorayr Khalapyan on 6/25/22.
//

import SwiftUI
import UIKit

class SubscriptionModel: ObservableObject {
    
    private func toggleSubscription(project: String, type: String, isSubscribed: Bool) {
        if (isSubscribed) {
            PushNotificationManager.subscribeToProject(project: project, type: type)
        } else {
            PushNotificationManager.unsubscribeFromProject(project:  project, type: type)
        }
    }
    
    @Published var newDropsToggle: Bool = false {
        didSet {
            toggleSubscription(project: "bullish-bears", type: "new-drops", isSubscribed: newDropsToggle)
        }
    }
    
    @Published var allowlistToggle = true {
        didSet {
            toggleSubscription(project: "bullish-bears", type: "allowlist", isSubscribed: allowlistToggle)
        }
    }
}

struct ToggleView: View {
    @ObservedObject var model: SubscriptionModel
    
    @State private var projectToggle = true
    @State private var fakeToggle = true
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        
        Theme.navigationBarColors(background: .clear, titleColor: .white)
        
        self.model = SubscriptionModel()
    }
    
    private func toggleCell(title: String, isOn: Binding<Bool>) -> some View {
        Toggle(isOn: isOn) {
            Text(title)
                .fontWeight(.medium)
                .padding([.bottom], 0)
                .padding([.top], 0)
        }
        .fixedSize(horizontal: false, vertical: true)
        .frame(height: 30)
        .tint(Color(hex: 0x1890FF))
    }
    
    var body: some View {
        VStack {
            Group {
                Text("Bullish Bears")
                    .font(.system(size: 20, weight: .regular, design: .default))
                    .frame(maxWidth: .infinity, maxHeight: 30, alignment: .leading)
                toggleCell(title: "I want to receive notifications for this project", isOn: $projectToggle)
                    .padding(.vertical)
                Divider()
                    .padding(.horizontal, 10)
            }
            .padding(.top, 10)
            .padding(.horizontal, 29)
            
            List {
                Section {
                    toggleCell(title: "New Drop", isOn: $model.newDropsToggle)
                    toggleCell(title: "Mint allowlist", isOn: $model.allowlistToggle)
                    toggleCell(title: "Utility announcements", isOn: $fakeToggle)
                    toggleCell(title: "Jobs", isOn: $fakeToggle)
                    toggleCell(title: "News coverage", isOn: $fakeToggle)
                    toggleCell(title: "Security", isOn: $fakeToggle)
                    toggleCell(title: "Global announcements", isOn: $fakeToggle)
                } header: {
                    Text("Select the type of notifications you’d like to receive (you can change this later)")
                        .font(.system(size: 17, weight: .light, design: .default))
                }
                .listRowBackground(Color.clear)
            }
        }
        .navigationTitle("Preferences")
        .navigationBarTitleDisplayMode(.inline)
        .background(
            RadialGradient(gradient: Gradient(colors: [Color(hex: 0x006D75), Color(hex: 0x00474F), Color(hex: 0x22075E)]), center: .topLeading, startRadius: 250, endRadius: 800)
            
        )
        .foregroundColor(.white)
        
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView()
    }
}
