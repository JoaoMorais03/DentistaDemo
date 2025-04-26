import SwiftUI

struct ProfileHeaderView: View {
    let name: String
    let subtitle: String
    let showProfileImage: Bool
    var accessibilityLabel: String? = nil
    
    init(name: String, 
         subtitle: String = NSLocalizedString("Welcome back!", comment: "Welcome message"), 
         showProfileImage: Bool = true,
         accessibilityLabel: String? = nil) {
        self.name = name
        self.subtitle = subtitle
        self.showProfileImage = showProfileImage
        self.accessibilityLabel = accessibilityLabel
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(String(format: NSLocalizedString("Hello, %@", comment: "Greeting with name"), name))
                        .font(.title2)
                        .bold()
                        .foregroundColor(.primary)
                    
                    Text(subtitle)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                if showProfileImage {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 36))
                        .foregroundColor(ColorTheme.primary)
                        .accessibility(hidden: true)
                }
            }
        }
        .padding(20)
        .background(CardStyle.apply(to: Color.clear))
        .padding(.top, 16)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel ?? String(format: NSLocalizedString("Welcome, %@", comment: "Welcome accessibility label"), name))
    }
}

#Preview {
    VStack {
        ProfileHeaderView(name: "John Doe")
        
        ProfileHeaderView(
            name: "Jane Smith",
            subtitle: NSLocalizedString("Welcome to your dental care app", comment: "Custom welcome message"),
            accessibilityLabel: NSLocalizedString("Welcome to DentistApp, Jane", comment: "Custom accessibility label")
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
} 