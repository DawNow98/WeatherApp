//
//  WeatherAppApp.swift
//  WeatherApp
//
//  Created by Dawid Nowacki on 06/02/2024.
//

import SwiftUI

@main
struct WeatherAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
