//
//  CookapediaApp.swift
//  Cookapedia
//
//  Created by Everett Brothers on 1/23/24.
//

import SwiftUI
import GoogleMobileAds

@main
struct CookapediaApp: App {
    let persistenceController = PersistenceController.shared
    
    init() {
        GADMobileAds.sharedInstance().start()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
