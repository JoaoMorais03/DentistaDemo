import SwiftUI

// MARK: - Appointment Card Components
struct AppointmentDateColumn: View {
    let date: Date
    let isUpcoming: Bool
    
    init(date: Date, isUpcoming: Bool = true) {
        self.date = date
        self.isUpcoming = isUpcoming
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill((isUpcoming ? ColorTheme.primary : ColorTheme.secondary).opacity(0.1))
                .frame(width: 60, height: 60)
            
            VStack(spacing: 4) {
                Text(date.dayString)
                    .font(.title3)
                    .bold()
                
                Text(date.monthUppercased)
                    .font(.caption)
                    .bold()
            }
            .foregroundColor(isUpcoming ? ColorTheme.primary : ColorTheme.secondary)
        }
    }
} 