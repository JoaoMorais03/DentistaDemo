import SwiftUI

struct PrimaryButton: View {
    let title: String
    let icon: String? // Optional icon
    let action: () -> Void
    
    // Initializer with optional icon parameter
    init(title: String, icon: String? = nil, action: @escaping () -> Void) {
        self.title = title
        self.icon = icon
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            HStack {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.system(size: 16, weight: .semibold))
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
    }
}

#Preview {
    VStack(spacing: 20) {
        PrimaryButton(title: "Book Appointment", action: {})
        PrimaryButton(title: "View Appointments", icon: "list.bullet.clipboard", action: {})
    }
    .padding()
    .background(Color(.systemGroupedBackground))
} 