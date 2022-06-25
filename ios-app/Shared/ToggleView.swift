//
//  ToggleView.swift
//  Pearl
//
//  Created by Zorayr Khalapyan on 6/25/22.
//

import SwiftUI

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

    @State private var fakeToggle = true
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
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
        .frame(height: 56)
    }
    
    var body: some View {
        return VStack {
            Text("Select the type of notifications you’d like to receive (you can change this later)")
                .padding(.horizontal)
            List {
                toggleCell(title: "New Drop", isOn: $model.newDropsToggle)
                toggleCell(title: "Mint allowlist", isOn: $model.allowlistToggle)
                toggleCell(title: "Utility announcements", isOn: $fakeToggle)
                toggleCell(title: "Jobs", isOn: $fakeToggle)
                toggleCell(title: "News coverage", isOn: $fakeToggle)
                toggleCell(title: "Security", isOn: $fakeToggle)
                toggleCell(title: "Global announcements", isOn: $fakeToggle)
            }
        }
        .background(Color.blue)
    }
}

struct ToggleView_Previews: PreviewProvider {
    static var previews: some View {
        ToggleView()
    }
}
