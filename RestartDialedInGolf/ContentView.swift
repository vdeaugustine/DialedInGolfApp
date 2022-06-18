//
//  ContentView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var selection: Tab = .bag
    enum Tab {
        case bag, notes, advice
    }

    var body: some View {
        TabView(selection: $selection) {
            NavigationView {
                Text("HI")
                    .navigationTitle("Get Advice")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Get Advice", systemImage: "lightbulb")
            }
            .tag(Tab.advice)

            NavigationView {
                BagListView()
                    .navigationTitle("Your Bag")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Bag", systemImage: "star")
            }
            .tag(Tab.bag)

            NavigationView {
                Text("yo")
                    .navigationTitle("Notes")
                    .navigationBarTitleDisplayMode(.inline)
            }
            .tabItem {
                Label("Notes", systemImage: "square.and.pencil")
            }
            .tag(Tab.notes)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData(forType: .preview))
            .preferredColorScheme(.dark)
    }
}
