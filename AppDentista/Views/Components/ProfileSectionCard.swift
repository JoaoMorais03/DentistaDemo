import SwiftUI

struct ProfileSectionCard<Content: View>: View {
    let title: String
    let icon: String
    let content: Content
    
    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
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
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
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
    }
}

#Preview {
    VStack {
        ProfileSectionCard(title: "Personal Information", icon: "person.fill") {
            VStack(spacing: 12) {
                ProfileInfoRow(
                    icon: "person",
                    title: "Name",
                    value: "John Doe"
                )
                ProfileInfoRow(
                    icon: "envelope",
                    title: "Email",
                    value: "johndoe@example.com"
                )
            }
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
} 