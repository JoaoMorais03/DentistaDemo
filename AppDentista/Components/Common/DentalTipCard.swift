import SwiftUI

struct DentalTipCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    var accessibilityLabel: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .frame(width: 36, height: 36)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(color)
                    )
                    .accessibility(hidden: true)
                
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
            }
            
            Text(description)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)
        }
        .padding(16)
        .background(CardStyle.apply(to: Color.clear))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel ?? "\(title) tip: \(description)")
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack(spacing: 16) {
            DentalTipCard(
                icon: "slash.circle",
                title: NSLocalizedString("Flossing", comment: "Tip title"),
                description: NSLocalizedString("Floss once daily to clean between teeth where brushes can't reach", comment: "Tip description"),
                color: ColorTheme.secondary
            )
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
} 