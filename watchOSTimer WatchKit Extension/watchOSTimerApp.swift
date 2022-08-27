//
//  watchOSTimerApp.swift
//  watchOSTimer WatchKit Extension
//
//  Created by Matheus Góes on 27/08/22.
//

import SwiftUI

@main
struct watchOSTimerApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
