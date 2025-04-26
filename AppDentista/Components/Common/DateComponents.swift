import SwiftUI

// MARK: - Date Display Components
struct DateTimeContainer: View {
    let date: Date
    
    var body: some View {
        HStack(spacing: 12) {
            // Date card
            DateView(date: date)
            
            // Time card
            TimeView(date: date)
        }
    }
}

struct DateView: View {
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "calendar")
                    .font(.body)
                    .foregroundColor(ColorTheme.primary)
                    .frame(width: 24)
                
                Text("Date")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(date.longDateString)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .padding(.top, 4)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 90, alignment: .leading)
        .background(CardStyle.apply(to: Color.clear))
    }
}

struct TimeView: View {
    let date: Date
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: "clock")
                    .font(.body)
                    .foregroundColor(ColorTheme.primary)
                    .frame(width: 24)
                
                Text("Time")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(date.timeString)
                .font(.body)
                .fontWeight(.medium)
                .foregroundColor(.primary)
                .padding(.top, 4)
        }
        .padding()
        .frame(maxWidth: .infinity, minHeight: 90, alignment: .leading)
        .background(CardStyle.apply(to: Color.clear))
    }
} 