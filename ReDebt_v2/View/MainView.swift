//
//  CoreDataMainView2.swift
//  ReDebt_v2
//
//  Created by Raja Monica on 21/08/23.
//

import SwiftUI

struct DataItem: Identifiable {
    var id = UUID()
    var title: String
    var size: CGFloat
    var color: Color
    var offset = CGSize.zero
}

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: false)], animation: .default)
    private var persons: FetchedResults<Person>
    
    @State private var selectedName: String = ""
    @State private var onDetailView: Bool = false
    @State private var onFirstScreen: Bool = false

    
    var body: some View {
        NavigationStack {
            VStack {
                BubbleView(onFirstScreenView: $onFirstScreen, onSelectedBubble: $onDetailView, selectedName: $selectedName)
                    .navigationDestination(
                        isPresented: $onDetailView) {
                            DetailView(targetPerson: $selectedName, onClose: $onDetailView)
                            Text("")
                                .hidden()
                        }
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
