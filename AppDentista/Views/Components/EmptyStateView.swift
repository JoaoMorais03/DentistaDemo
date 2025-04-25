import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    let iconColor: Color
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundColor(iconColor.opacity(0.7))
                .padding(.top, 24)
            
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.secondary)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 24)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: CardStyle.cornerRadius)
                .fill(Color(.systemBackground))
        )
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

#Preview {
    VStack {
        EmptyStateView(
            icon: "doc.text.magnifyingglass",
            title: "No appointments",
            message: "Your appointments will appear here",
            iconColor: ColorTheme.primary
        )
        
        EmptyStateView(
            icon: "calendar.badge.exclamationmark",
            title: "No upcoming appointments",
            message: "Tap the button below to schedule one",
            iconColor: ColorTheme.secondary
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
} 