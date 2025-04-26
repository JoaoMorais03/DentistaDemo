import SwiftUI

struct EmptyStateView: View {
    let icon: String
    let title: String
    let message: String
    let iconColor: Color
    var accessibilityLabel: String? = nil
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: icon)
                .font(.system(size: 50))
                .foregroundColor(iconColor.opacity(0.7))
                .padding(.top, 24)
                .accessibility(hidden: true)
            
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel ?? "\(title). \(message)")
    }
}

#Preview {
    VStack {
        EmptyStateView(
            icon: "doc.text.magnifyingglass",
            title: NSLocalizedString("No appointments", comment: "Empty state title"),
            message: NSLocalizedString("Your appointments will appear here", comment: "Empty state message"),
            iconColor: ColorTheme.primary,
            accessibilityLabel: NSLocalizedString("No appointments available yet", comment: "Accessibility label")
        )
        
        EmptyStateView(
            icon: "calendar.badge.exclamationmark",
            title: NSLocalizedString("No upcoming appointments", comment: "Empty state title"),
            message: NSLocalizedString("Tap the button below to schedule one", comment: "Empty state message"),
            iconColor: ColorTheme.secondary
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
} 