//
//  ARMApp.swift
//  ARM
//
//  Created by Дана Муртазина on 23.05.2021.
//

import SwiftUI

@main
struct ARMApp: App {
    @StateObject var placementSettings = PlacementSettings()
    @StateObject var sessionSettings = SessionSettings()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
                .environmentObject(sessionSettings)
        }
    }
}
