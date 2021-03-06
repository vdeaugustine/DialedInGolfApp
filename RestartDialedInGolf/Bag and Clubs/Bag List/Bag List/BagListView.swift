//
//  BagListView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/16/22.
//

import AlertToast
import BottomSheet
import SwiftUI

func loadBag() -> Bag? {
    var retBag: Bag?
    if let existingBag = UserDefaults.standard.object(forKey: bagEnum.bag.rawValue) as? Data {
        do {
            let decoder = JSONDecoder()
            let thisBag = try decoder.decode(Bag.self, from: existingBag)
            retBag = thisBag
        } catch {
            print(error)
        }
    }
    return retBag
}

struct BagListView: View {
    @EnvironmentObject var modelData: ModelData
    @State private var showingAlert = false

    private let sections: [ClubType] = [.wood, .iron, .hybrid, .wedge]
    var body: some View {
        VStack {
            List {
                ForEach(sections, id: \.self) { sectionClubType in
                    ClubSectionView(clubType: sectionClubType)
                }
            }
        }
        .navigationTitle("Your Bag")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            // Top right button pressed when user would like to add a club
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink {
                    AddClubView()
                } label: {
                    Label("Add Club", systemImage: "plus")
                }
            }

            // Button the user can tap to reset their clubs to default. It will present an alert and if the alert is accepted, then it resets the clubs
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Reset") {
                    showingAlert = true
                }

                .confirmationDialog("Are you sure you want to reset all clubs? This action cannot be undone", isPresented: $showingAlert, titleVisibility: .visible) {
                    Button("Reset", role: .destructive) {
                        modelData.makeDefault()
                    }
                }
                .preferredColorScheme(.dark)
            }
        }
    }
}

struct BagListView_Previews: PreviewProvider {
    static var previews: some View {
        BagListView()
            .environmentObject(ModelData(forType: .preview))
            .preferredColorScheme(.dark)
    }
}
