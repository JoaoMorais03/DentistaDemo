import SwiftUI

/// A wrapper view to provide consistent container styling for all main views
struct ViewContainer<Content: View>: View {
    let title: String
    let content: Content
    var trailingBarItem: AnyView? = nil
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    init(title: String, trailingBarItem: AnyView, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
        self.trailingBarItem = trailingBarItem
    }
    
    var body: some View {
        NavigationView {
            // Single ZStack covering entire view with background
            ZStack {
                // Background that fills entire screen
                Color(.systemGroupedBackground)
                    .edgesIgnoringSafeArea(.all)
                
                // ScrollView without its own background color
                ScrollView {
                    // Add top padding to the content to prevent it from being too close to the navigation bar
                    VStack(spacing: 0) {
                        content
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 8)
                    .padding(.bottom, 32)
                }
                .background(Color.clear) // Ensure ScrollView has no background
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .accessibilityAddTraits(.isHeader)
                }
                
                if let trailing = trailingBarItem {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        trailing
                    }
                }
            }
            .toolbarBackground(.visible, for: .navigationBar)
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Use consistent navigation style
    }
}