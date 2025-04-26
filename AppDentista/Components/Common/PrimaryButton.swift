import SwiftUI

struct PrimaryButton: View {
    let title: String
    let icon: String? // Optional icon
    let action: () -> Void
    var accessibilityLabel: String? = nil
    var accessibilityHint: String? = nil
    
    // Initializer with optional icon parameter
    init(title: String, icon: String? = nil, accessibilityLabel: String? = nil, accessibilityHint: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
                        .accessibility(hidden: true)
                }
                
                Text(title)
                    .font(.system(size: 16, weight: .semibold))
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(ColorTheme.primary)
            )
            .shadow(color: ColorTheme.primary.opacity(0.3), radius: 5, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
        .accessibilityLabel(accessibilityLabel ?? title)
        .if(accessibilityHint != nil) { view in
            view.accessibilityHint(accessibilityHint!)
        }
    }
}

// Extension to conditionally apply modifiers
extension View {
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(
            title: NSLocalizedString("Book Appointment", comment: "Button title"),
            accessibilityHint: NSLocalizedString("Tap to schedule a new appointment", comment: "Button accessibility hint"),
            action: {}
        )
        
        PrimaryButton(
            title: NSLocalizedString("View Appointments", comment: "Button title"),
            icon: "list.bullet.clipboard",
            accessibilityLabel: NSLocalizedString("View all appointments", comment: "Button accessibility label"),
            action: {}
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
} 