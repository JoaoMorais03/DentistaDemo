import SwiftUI

struct ProfileSectionCard<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    var accessibilityLabel: String? = nil
    
    init(title: String, icon: String, accessibilityLabel: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.accessibilityLabel = accessibilityLabel
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Header
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .frame(width: 32, height: 32)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(ColorTheme.primary)
                    )
                    .accessibility(hidden: true)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibilityAddTraits(.isHeader)
                
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 16)
            
            Divider()
                .padding(.horizontal, 16)
            
            // Content
            content
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
        }
        .background(CardStyle.apply(to: Color.clear))
        .accessibilityElement(children: .contain)
        .accessibilityLabel(accessibilityLabel ?? title)
    }
}

#Preview {
    VStack {
        ProfileSectionCard(
            title: NSLocalizedString("Personal Information", comment: "Section title"),
            icon: "person.fill",
            accessibilityLabel: NSLocalizedString("Personal Information section", comment: "Section accessibility label")
        ) {
            VStack(spacing: 12) {
                ProfileInfoRow(
                    icon: "person",
                    title: NSLocalizedString("Name", comment: "Field label"),
                    value: "John Doe"
                )
                ProfileInfoRow(
                    icon: "envelope",
                    title: NSLocalizedString("Email", comment: "Field label"),
                    value: "johndoe@example.com"
                )
            }
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
} 