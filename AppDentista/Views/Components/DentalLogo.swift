import SwiftUI

struct DentalLogo: View {
    var size: CGFloat = 40
    
    var body: some View {
        ZStack {
            Circle()
                .fill(ColorTheme.primary)
                .frame(width: size, height: size)
            
            Image(systemName: "plus.circle.fill")
                .resizable()
                .scaledToFit()
                .foregroundColor(.white)
                .padding(size * 0.2)
                .frame(width: size, height: size)
        }
    }
}

#Preview {
    VStack {
        DentalLogo(size: 60)
        DentalLogo()
        DentalLogo(size: 30)
    }
    .padding()
} 