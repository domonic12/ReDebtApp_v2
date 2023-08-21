//
//  ReDebt_v2App.swift
//  ReDebt_v2
//
//  Created by Raja Monica on 21/08/23.
//

import SwiftUI

@main
struct ReDebt_v2App: App {
    let persistenceController = PersistenceController.shared
    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.viewContext)
        }
    }
}
