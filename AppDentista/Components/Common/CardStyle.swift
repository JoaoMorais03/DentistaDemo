import SwiftUI

// MARK: - Card Styles
struct CardStyle {
    /// Standard corner radius for cards across the app
    static let cornerRadius: CGFloat = 16
    
    /// Standard shadow for cards
    static func applyShadow<T: View>(to view: T) -> some View {
        view.shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    /// Apply standard card style to a view
    static func apply<T: View>(to view: T) -> some View {
        view
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color(.systemBackground))
            )
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Card Containers
struct CardContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: CardStyle.cornerRadius)
                    .fill(Color(.systemBackground))
            )
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
} 