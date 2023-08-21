import SwiftUI
import SpriteKit

struct BubbleView: View {
        @Environment(\.managedObjectContext) private var viewContext
        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: false)], animation: .default)
        private var persons: FetchedResults<Person>

        @Binding var onFirstScreenView: Bool
        @Binding var onSelectedBubble: Bool
        @Binding var selectedName: String
        @State var datas: [DataItem] = []
        @State var currentDatas: [DataItem] = []
        @State var bubbleScene: BubblesScene = BubblesScene()
        @State private var onNewTransactionView: Bool = false
        @StateObject private var viewModel = BubbleViewModel()
        var body: some View {
            if viewModel.persons.count < 1 {
    
                FirstScreenView(firstTimer: $viewModel.onFirstScreenView)
                    .onAppear {
                        viewModel.onFirstScreenView = false
                    }
                    .navigationDestination(
                        isPresented: $viewModel.onFirstScreenView) {
                            NewTransactionView().navigationBarBackButtonHidden(true)
                            Text("")
                                .hidden()
                        }
            }else {
                VStack {
                    HStack {
                        Text("Navigate Your Debt Transaction")
                        Text("Easily")
                            .foregroundColor(.pink)
                    }
                    .padding(3)
                    .fontWeight(.medium)
    
                    HStack {
                        Text("Tap")
                            .foregroundColor(.pink)
                        Text("to see the detail")
                    }
                    .fontWeight(.light)
                    .multilineTextAlignment(.center)
    
                }.padding()
    
                SpriteView(scene: viewModel.bubbleScene)
                    .onChange(of: viewModel.selectedName) { newValue in
                        viewModel.onSelectedBubble = true
                        print("onchange")
                    }
                    .onAppear {
                        print("onappear")
                        viewModel.onFirstScreenView = true

                        viewModel.createScene()
                    }
                    .onDisappear {
                        print("disappear")
            
                    }
                
    
                Spacer()
    
                VStack {
                    Text("^")
                        .fontWeight(.black)
                    Text("Slide to Add New Transaction")
                        .fontWeight(.medium)
                }
                .navigationDestination(
                    isPresented: $viewModel.onNewTransactionView) {
                        NewTransactionView()
                        Text("")
                            .hidden()
                    }
                    .gesture(
                        DragGesture()
                            .onChanged { drag in
                                if drag.location.y < -60 {
                                    viewModel.onNewTransactionView = true
                                }
                            }
                    )
            }
        }
    
    
}

