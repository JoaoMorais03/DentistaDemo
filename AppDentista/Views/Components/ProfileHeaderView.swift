import SwiftUI

struct ProfileHeaderView: View {
    let name: String
    let subtitle: String = "Welcome back!"
    let showProfileImage: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Hello, \(name)")
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
                }
            }
        }
        .padding(20)
        .background(CardStyle.apply(to: Color.clear))
        .padding(.top, 16)
    }
}

#Preview {
    VStack {
        ProfileHeaderView(name: "John Doe")
    }
    .padding()
    .background(Color(.systemGroupedBackground))
} 