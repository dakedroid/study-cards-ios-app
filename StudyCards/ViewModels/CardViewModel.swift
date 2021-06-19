//
//  CardViewModel.swift
//  StudyCards
//
//  Created by Kevin Molina on 18/06/21.
//

import Combine

final class CardViewModel: ObservableObject, Identifiable {
    
    private let cardRepository = CardRepository()
    
    @Published var studyCard: StudyCard
    
    var id = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(studyCard: StudyCard) {
        self.studyCard = studyCard
        $studyCard
            .compactMap{$0.id}
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
    }
    
    
    
}
