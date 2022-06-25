//
//  ToggleView.swift
//  Pearl
//
//  Created by Zorayr Khalapyan on 6/25/22.
//

import SwiftUI

struct ToggleView: View {
    @State private var newDropsToggle = true
    
    init() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
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
                toggleCell(title: "New Drop", isOn: $newDropsToggle)
                toggleCell(title: "Mint allowlist", isOn: $newDropsToggle)
                toggleCell(title: "Utility announcements", isOn: $newDropsToggle)
                toggleCell(title: "Jobs", isOn: $newDropsToggle)
                toggleCell(title: "News coverage", isOn: $newDropsToggle)
                toggleCell(title: "Security", isOn: $newDropsToggle)
                toggleCell(title: "Global announcements", isOn: $newDropsToggle)
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
