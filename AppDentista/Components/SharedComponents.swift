import SwiftUI

// MARK: - Card Styles
struct CardStyle {
    /// Standard corner radius for cards across the app
    static let cornerRadius: CGFloat = 16
    
    /// Standard shadow for cards
    static func applyShadow<T: View>(to view: T) -> some View {
        view.shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    /// Apply standard card style to a view
    static func apply<T: View>(to view: T) -> some View {
        view
            .background(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(Color(.systemBackground))
            )
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Card Containers
struct CardContainer<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: CardStyle.cornerRadius)
                    .fill(Color(.systemBackground))
            )
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
}

// MARK: - Section Components
struct SectionHeader: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

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

// MARK: - Status Indicator Components
struct CompletedStatusPill: View {
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(ColorTheme.success)
            Text("Completed")
                .font(.caption)
                .bold()
                .foregroundColor(ColorTheme.success)
        }
        .padding(.horizontal, 8)
        .padding(.vertical, 4)
        .background(
            Capsule()
                .fill(ColorTheme.success.opacity(0.1))
        )
    }
} 