import SwiftUI

struct DentalTipCard: View {
    let icon: String
    let title: String
    let description: String
    let color: Color
    
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
        .frame(width: 240)
        .padding(16)
        .background(CardStyle.apply(to: Color.clear))
    }
}

#Preview {
    ScrollView(.horizontal) {
        HStack(spacing: 16) {
            DentalTipCard(
                icon: "toothbrush",
                title: "Brushing",
                description: "Brush teeth twice daily for 2 minutes using fluoride toothpaste",
                color: ColorTheme.primary
            )
            
            DentalTipCard(
                icon: "slash.circle",
                title: "Flossing",
                description: "Floss once daily to clean between teeth where brushes can't reach",
                color: ColorTheme.secondary
            )
        }
        .padding()
    }
    .background(Color(.systemGroupedBackground))
} 