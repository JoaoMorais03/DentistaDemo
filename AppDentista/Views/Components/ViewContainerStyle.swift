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
            ScrollView {
                content
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
            }
            .background(Color(.systemGroupedBackground))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                
                if let trailing = trailingBarItem {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        trailing
                    }
                }
            }
        }
    }
}

// Example usage:
// ViewContainer(title: "My Profile") {
//     VStack {
//         // Your content here
//     }
// }

// Example with trailing item:
// ViewContainer(
//     title: "Dashboard",
//     trailingBarItem: AnyView(
//         Button(action: {}) {
//             Image(systemName: "bell")
//         }
//     )
// ) {
//     VStack {
//         // Your content here
//     }
// } 