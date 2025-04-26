import SwiftUI

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