//
//  ContentView.swift
//  StudyCards
//
//  Created by Kevin Molina on 17/06/21.
//

import SwiftUI

struct CardListView: View {
  
    
    @ObservedObject var cardlisViewModel: CardListViewModel
    @State private var showingForm = false
    @State private var showPassed = false
    
    var body: some View {
   
        NavigationView {
            VStack {
                Toggle(isOn: $showPassed){
                    Text("\(showPassed ? "Hide" : "Show") passed questions")}.padding()
                List {
                    ForEach(cardlisViewModel.cardViewModels.filter{
                        
                        $0.studyCard.passed == showPassed
                    }){ cardVM in
                        
                        CardView(cardViewModel: cardVM)
                            .onLongPressGesture {
                                var studyCard = cardVM.studyCard
                                studyCard.passed.toggle()
                                cardlisViewModel.update(studyCard)
                            }
                        
                    }.onDelete(perform: delete)
                }.listStyle(InsetListStyle())
                .navigationTitle("StudyCards")
                
                
                Button(action: {
                    showingForm = true
                }){
                    
                    Circle()
                        .fill(Color.green)
                        .frame(height: 60)
                        .overlay(Image(systemName: "plus").foregroundColor(.white))
                    
                }.sheet(isPresented: $showingForm){
                    FormView { (studyCard) in
                        cardlisViewModel.add(studyCard)
                        showingForm = false 
                        
                    }
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet){
        
        offsets.map {cardlisViewModel.cardViewModels[$0].studyCard}.forEach(cardlisViewModel.remove)
    }
    
}

struct CardListView_Previews: PreviewProvider {
    static var previews: some View {
        CardListView(cardlisViewModel : CardListViewModel())
    }
}
