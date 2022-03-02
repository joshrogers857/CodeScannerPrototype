//
//  CodeScannerPrototypeApp.swift
//  CodeScannerPrototype
//
//  Created by Joshua Rogers on 01/03/2022.
//

import SwiftUI

@main
struct CodeScannerPrototypeApp: App {
    let persistenceController = PersistenceController.shared
    
    //Automatically save when the app is defocused
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
        .onChange(of: scenePhase) { _ in
            //Automatically save when the app is defocused
            persistenceController.save()
        }
    }
}
