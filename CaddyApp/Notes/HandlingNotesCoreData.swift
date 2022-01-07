//
//  HandlingNotesCoreData.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/6/22.
//

import Foundation
import UIKit


var clubNotes = [ClubNote]()
var mainNotes = [MainNote]()
let mainContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext



// MARK: - FOR CLUBS
func getAllClubNotes() -> [ClubNote]{
    do {
        clubNotes = try mainContext.fetch(ClubNote.fetchRequest())
        for item in clubNotes {
            print(item.subTitle)
        }
        return clubNotes
    } catch {}
    return [ClubNote]()
}

func createClubNote(title: String, subtitle: String, type: AllClubNames) {
    let newItem = ClubNote(context: mainContext)
    newItem.title = title
    newItem.subTitle = subtitle
    do {
        try mainContext.save()
        let _ = getAllClubNotes()
    } catch {}
}

func deleteClubNote(note: ClubNote) {
    mainContext.delete(note)
    do {
        try mainContext.save()
        
    } catch {
        
        print("PROBLEM DELETING NOTE")
    }
}

func updateClubNote(note: ClubNote, newTitle: String, newSubtitle: String, type: AllClubNames) {
    note.title = newTitle
    note.subTitle = newSubtitle
    do {
        try mainContext.save()
    } catch {}
}

// MARK: - FOR MAIN
func getAllMainNotes() -> [MainNote]{
    do {
        print("getting main notes")
        mainNotes = try mainContext.fetch(MainNote.fetchRequest())
        print("main notes gotten")
        
        print(mainNotes)
        return mainNotes
    } catch {
        print("problem getting main notes")
    }
    return [MainNote]()
}

func createMainNote(title: String, content: String) {
    let newItem = MainNote(context: mainContext)
    newItem.title = title
    newItem.subTitle = content
    do {
        
        try mainContext.save()
        let _ = getAllMainNotes()
    } catch {
        
        print("problem saving main note")
    }
    
}

func deleteMainNote(note: MainNote) {
    mainContext.delete(note)
    do {
        try mainContext.save()
        
    } catch {
        
        print("PROBLEM DELETING NOTE")
    }
}

func updateMainNote(note: MainNote, newTitle: String, newContent: String) {
    note.title = newTitle
    note.subTitle = newContent
    do {
        try mainContext.save()
    } catch {}
}
