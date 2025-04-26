import SwiftUI

struct PrimaryButtonLink<Destination: View>: View {
    let title: String
    let icon: String? // Optional icon
    let destination: Destination
    var accessibilityLabel: String? = nil
    var accessibilityHint: String? = nil
    
    init(title: String, 
         icon: String? = nil, 
         destination: Destination, 
         accessibilityLabel: String? = nil, 
         accessibilityHint: String? = nil) {
        self.title = title
        self.icon = icon
        self.destination = destination
        self.accessibilityLabel = accessibilityLabel
        self.accessibilityHint = accessibilityHint
    }
    
    var body: some View {
        NavigationLink(destination: destination) {
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

#Preview {
    NavigationView {
        VStack(spacing: 20) {
            PrimaryButtonLink(
                title: NSLocalizedString("Book Appointment", comment: "Button title"),
                destination: Text("Booking View"),
                accessibilityHint: NSLocalizedString("Tap to schedule a new appointment", comment: "Button accessibility hint")
            )
            
            PrimaryButtonLink(
                title: NSLocalizedString("View Appointments", comment: "Button title"),
                icon: "list.bullet.clipboard",
                destination: Text("Appointments List"),
                accessibilityLabel: NSLocalizedString("View all appointments", comment: "Button accessibility label")
            )
        }
        .padding()
        .background(Color(.systemGroupedBackground))
    }
} 