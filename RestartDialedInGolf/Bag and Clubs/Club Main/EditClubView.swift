//
//  EditClubView.swift
//  RestartDialedInGolf
//
//  Created by Vincent DeAugustine on 6/26/22.
//

import AlertToast
import SwiftUI

struct EditClubView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var modelData: ModelData
    var club: Club
    private var modelClub: Club {
        guard let theClub = modelData.bag.clubs.first(where: { $0 == club }) else {
            return Club(number: "NA", type: .wood, name: "NA", distance: 999)
        }
        
        return theClub
    }

    @State var distanceEntered: String = ""
    @State var showToast = false

    var body: some View {
        Form {
            HStack {
                Text("Distance")
                Spacer()
                TextField("\(modelClub.getDistance())", text: $distanceEntered, onEditingChanged: { isEditing in
                    if isEditing {
                        self.distanceEntered = ""
                    }
                })
                    .keyboardType(.numberPad)
                    .multilineTextAlignment(.trailing)

                Text("yards")
            }
        }
        .onAppear {
            if distanceEntered.isEmpty {
                distanceEntered = "\(modelClub.getDistance())"
            }
        }
        .onTapGesture {
            dismissKeyboard()
            if distanceEntered.isEmpty {
                distanceEntered = "\(modelClub.getDistance())"
            }
        }
        .navigationTitle("Edit distance for \(modelClub.getName())")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
                    guard let intOfStr = Int(distanceEntered) else {
                        showToast.toggle()
                        return
                    }

                    do {
                        try modelData.bag.editClubDistance(intOfStr, forClub: modelClub)
                    } catch {
                        showToast.toggle()
                        print(error)
                        return
                    }

                    modelData.saveBag()

                    dismiss()
                }
            }
        }
    }
}

struct EditClubView_Previews: PreviewProvider {
    @StateObject static var modelData = ModelData(forType: .preview)
    static var previews: some View {
        EditClubView(club: modelData.bag.clubs.first!)
            .environmentObject(modelData)
            .preferredColorScheme(.dark)
    }
}
