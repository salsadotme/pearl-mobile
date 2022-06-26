////
////  ToggleView.swift
////  Pearl
////
////  Created by Zorayr Khalapyan on 6/25/22.
////
//
//import SwiftUI
//import UIKit
//
//var titles = ["First Section" : ["Manage your workout", "View recorded workouts", "Weight tracker", "Mediation"], "Second Section" : ["Your workout", "Recorded workouts", "Tracker", "Mediations"]]
//
//
//struct ProjectsView: View {
//    
//    @State private var projectToggle = true
//    @State private var fakeToggle = true
//    
//    init() {
//        UITableView.appearance().backgroundColor = .clear
//        UITableViewCell.appearance().backgroundColor = .clear
//        
//        Theme.navigationBarColors(background: .clear, titleColor: .white)
//    }
//    
//    var body: some View {
//        return NavigationView {
//            VStack {
//                Group {
//                    Text("Your NFTs")
//                        .font(.system(size: 24, weight: .medium, design: .default))
//                        .frame(maxWidth: .infinity, maxHeight: 20, alignment: .leading)
//                }.padding(.horizontal, 29)
//                List {
//                    Section("Select the projects you would like to receive notifications from.") {
//                        VStack(alignment: .leading, spacing: 0){
//                            ForEach("First Section", id: \.self) { title in
//                                HStack{
//                                    Text(title)
//                                    Spacer()
//                                    Image(systemName: "arrow.right")
//                                }//: HSTACK
//                                .padding(20)
//                                Divider()
//                            }//: LOOP
//                        }//: VSTACK
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10, style: .circular).stroke(Color(uiColor: .tertiaryLabel), lineWidth: 1)
//                        )
//                        .foregroundColor(Color(uiColor: .tertiaryLabel))
//                    }
//                }
//                .listStyle(InsetListStyle())
//            }
//        }
//        .navigationTitle("Preferences")
//        .navigationBarTitleDisplayMode(.inline)
//        .background(
//            RadialGradient(gradient: Gradient(colors: [Color(hex: 0x006D75), Color(hex: 0x00474F), Color(hex: 0x22075E)]), center: .topLeading, startRadius: 250, endRadius: 800)
//            
//        )
//    }
//}
//
//struct ProjectsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectsView()
//    }
//}
