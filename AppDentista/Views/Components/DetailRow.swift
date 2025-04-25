import SwiftUI

/// A reusable component for displaying detail information in a label-value format
struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(ColorTheme.primary)
                .frame(width: 24)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        DetailRow(
            icon: "calendar",
            title: "Date",
            value: "March 15, 2023"
        )
        
        DetailRow(
            icon: "clock",
            title: "Time",
            value: "10:30 AM"
        )
        
        DetailRow(
            icon: "person",
            title: "Doctor",
            value: "Dr. Sarah Johnson"
        )
    }
    .padding()
    .background(Color(.systemBackground))
} 