import SwiftUI

struct AppointmentHistoryCard: View {
    let appointment: Appointment
    var accessibilityLabel: String? = nil
    var accessibilityHint: String? = nil
    
    var body: some View {
        HStack(spacing: 16) {
            // Date column
            AppointmentDateColumn(date: appointment.date, isUpcoming: false)
            
            // Info column
            VStack(alignment: .leading, spacing: 6) {
                Text(appointment.treatmentType.localizedName)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                AppointmentInfoGroup(
                    time: appointment.date.timeString,
                    doctor: appointment.doctorName
                )
            }
            
            Spacer()
            
            // Status indicator
            CompletedStatusPill()
            
            // Add chevron for navigation
            Image(systemName: "chevron.right")
                .foregroundColor(.secondary)
                .font(.caption)
                .accessibilityHidden(true)
        }
        .padding(16)
        .background(CardStyle.apply(to: Color.clear))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel ?? 
            NSLocalizedString("Past appointment for \(appointment.treatmentType.localizedName) with \(appointment.doctorName) on \(appointment.date.formatted(date: .long, time: .shortened)). Completed.", 
                              comment: "Card accessibility label")
        )
        .accessibilityHint(accessibilityHint ?? NSLocalizedString("Tap to view details", comment: "Card accessibility hint"))
    }
}

#Preview {
    VStack {
        AppointmentHistoryCard(
            appointment: Appointment.examplePast[0],
            accessibilityLabel: NSLocalizedString("Past dental cleaning appointment with Dr. Smith", comment: "Card accessibility label")
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}