//
//  StudyCard.swift
//  StudyCards
//
//  Created by Kevin Molina on 17/06/21.
//

import FirebaseFirestoreSwift


struct StudyCard: Identifiable, Codable {
    
    @DocumentID var id: String?
    
    var question: String
    var answer: String
    var passed: Bool = false
    
}
