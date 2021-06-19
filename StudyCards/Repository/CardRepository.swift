//
//  CardReposisory.swift
//  StudyCards
//
//  Created by Kevin Molina on 17/06/21.
//

import FirebaseFirestore
import FirebaseFirestoreSwift
import Combine

final class CardRepository: ObservableObject {
    
    private let PATH = "studyCards"
    private let store = Firestore.firestore()
    @Published var studyCards : [StudyCard] = []
    
    
    init() {
        get()
    }
    
    func get() {
        store.collection(PATH).addSnapshotListener { (snapshot, error) in
            if let error = error {
                print (error)
                return
            }
            
            self.studyCards = snapshot?.documents.compactMap{
                try? $0.data(as: StudyCard.self)
            } ?? []
            
        }
    }
    
    func add(_ studycard: StudyCard)
    {
        do {
            
            _ = try store.collection(PATH).addDocument(from: studycard)
     
        } catch{
            fatalError("Added a study card failed")
        }
    }
    
    func remove (_ studycard: StudyCard) {
        guard let documentId = studycard.id else {return}
        store.collection(PATH).document(documentId).delete() { error in
            if let error = error {
                print("Unable to Remove the card: \(error.localizedDescription)")
            }
            
        }
        
    }
    
    func update (_ studycard: StudyCard) {
        
        guard let documentId = studycard.id else {return}
        
        do {
            
            try store.collection(PATH).document(documentId).setData(from: studycard)
     
        } catch{
            fatalError("Updating a study card failed")
        }

    }
    
}
