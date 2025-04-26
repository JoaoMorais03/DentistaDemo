import SwiftUI

/// A reusable component for displaying detail information in a label-value format
struct DetailRow: View {
    let icon: String
    let title: String
    let value: String
    var accessibilityLabel: String? = nil
    
    var body: some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(ColorTheme.primary)
                .frame(width: 24)
                .accessibility(hidden: true)
            
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel ?? "\(title): \(value)")
    }
}

#Preview {
    VStack(spacing: 16) {
        DetailRow(
            icon: "calendar",
            title: NSLocalizedString("Date", comment: "Detail label"),
            value: "March 15, 2023",
            accessibilityLabel: NSLocalizedString("Date: March 15, 2023", comment: "Accessibility label")
        )
        
        DetailRow(
            icon: "clock",
            title: NSLocalizedString("Time", comment: "Detail label"),
            value: "10:30 AM"
        )
        
        DetailRow(
            icon: "person",
            title: NSLocalizedString("Doctor", comment: "Detail label"),
            value: "Dr. Sarah Johnson"
        )
    }
    .padding()
    .background(Color(.systemBackground))
} 