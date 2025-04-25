//
//  AppDentistaApp.swift
//  AppDentista
//
//  Created by João Morais on 24/04/2025.
//

import SwiftUI

@main
struct AppDentistaApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(.light)
                .accentColor(ColorTheme.primary)
                .onAppear {
                    // Set global UI appearance
                    UINavigationBar.appearance().backgroundColor = UIColor(ColorTheme.background)
                    UITabBar.appearance().backgroundColor = UIColor.white
                }
        }
    }
}
