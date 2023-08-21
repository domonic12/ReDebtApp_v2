import Foundation
import SwiftUI
import SpriteKit

class BubbleViewModel: ObservableObject {
       
    @Published var onFirstScreenView: Bool = false
    @Published var onSelectedBubble: Bool = false
    @Published var selectedName: String = ""
    @Published var datas: [DataItem] = []
    @Published var currentDatas: [DataItem] = []
    @Published var bubbleScene: BubblesScene = BubblesScene()
    @Published var onNewTransactionView: Bool = false
    
    // Your Core Data fetching logic
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Person.name, ascending: false)], animation: .default)
     public var persons: FetchedResults<Person>
    // Your utility functions (map, normalizeSize)
    func map(minRange:Double, maxRange:Double, minDomain:Double, maxDomain:Double, value:Double) -> Double {
            return minDomain + (maxDomain - minDomain) * (value - minRange) / (maxRange - minRange)
        }
    
        func normalizeSize(x: Double, min: Double, max:Double) -> Double{
            print(min)
            return map(minRange: abs(max), maxRange: abs(min), minDomain: 50, maxDomain: 150, value: abs(x))
        }
    
    
    
    // Your update functions (updateBubble, createScene)
    func updateBubble() {
            print("[updateBubbble][bubbleScene]", bubbleScene.children)
    
    
            let status = datas.count > 0 ? true : false
    
            datas.removeAll()
    
            for person in persons {
                var maxx = persons.map { $0.totalDebt }.max() ?? 0
                var minx = persons.map { $0.totalDebt }.min() ?? 0
                if person.totalDebt != 0 {
                    // need to change the value of min and max if min = max because x/0 is nan
                    if minx == maxx{
                        minx = minx+1
    
                    }
                    
                    let size = normalizeSize(x: person.totalDebt, min: minx, max: maxx)
                                    let _ = print("[updateBubbble][size] \(normalizeSize(x: person.totalDebt, min: minx, max: maxx))")
                    
                                    datas.append(DataItem(title: person.name ?? "no name", size: size, color: person.totalDebt < 0 ? Color(hex:0xFF7090) : Color(hex:0x8FCBFF)))
                    
                    
                                    let _ = print("[updateBubbble][normalizeSize][person.totalDebt] \(person.totalDebt)")
                                    let _ = print("[updateBubbble][normalizeSize][max] \(minx)")
                                    let _ = print("[updateBubbble][normalizeSize][min] \(maxx)")
                                }
                    
                    
                            }
        let _ = print("halo\(datas)")
        
        
                print("[updateBubbble][datas.count]", datas.count)
                print("[updateBubbble][currentDatas.count]", currentDatas.count)
        
                var iteration = 0
                for data in datas {
                    if !currentDatas.isEmpty {
                        print("[updateBubbble][currentDatas]", currentDatas)
                        let isDuplicate = currentDatas.contains(where: {
                            print("[updateBubbble][$0.id]", $0.title)
                            print("[updateBubbble][dataId]", data.title)
        
                            return $0.title == data.title
        
                        })
                        print("[updateBubbble][isDuplicate]", isDuplicate)
                        if isDuplicate {
                            continue
                        }
                    }
        
                    bubbleScene.updateChild(BubbleNode.instantiate(data: data), iteration: iteration, status: status)
        
                    currentDatas.append(DataItem(id: data.id ,title: data.title, size: data.size, color: data.color, offset: data.offset))
                    iteration += 1
                }
        
                print("[updateBubbble][bubbleScene]", bubbleScene.children)
            }
    func createScene() {
            datas = []
    
            bubbleScene.topOffset = CGFloat(-275)
            bubbleScene.onTap = { value in
                self.selectedName = value
            }
    
            bubbleScene.size = CGSize(width: 300, height: 550)
            bubbleScene.scaleMode = .aspectFill
            print("[createScene][bubbleScene]", bubbleScene.children)
    
            updateBubble()
        }
    }


