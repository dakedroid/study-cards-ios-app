//
//  StudyCardsApp.swift
//  StudyCards
//
//  Created by Kevin Molina on 17/06/21.
//

import SwiftUI
import Firebase

@main
struct StudyCardsApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            CardListView( cardlisViewModel: CardListViewModel() )
        }
    }
}
