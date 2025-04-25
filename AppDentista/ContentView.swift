//
//  ContentView.swift
//  AppDentista
//
//  Created by João Morais on 24/04/2025.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            
            AppointmentsView()
                .tabItem {
                    Label("Appointments", systemImage: "calendar")
                }
            
            AppointmentHistoryView()
                .tabItem {
                    Label("History", systemImage: "list.clipboard")
                }
            
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .accentColor(ColorTheme.primary)
    }
}

#Preview {
    ContentView()
}
