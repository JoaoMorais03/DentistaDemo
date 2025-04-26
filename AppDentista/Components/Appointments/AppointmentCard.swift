import SwiftUI

struct AppointmentCard: View {
    let appointment: Appointment
    var accessibilityLabel: String? = nil
    var accessibilityHint: String? = nil
    var showChevron: Bool = true
    
    var body: some View {
        HStack(spacing: 16) {
            // Date column
            AppointmentDateColumn(date: appointment.date)
            
            // Info column
            VStack(alignment: .leading, spacing: 6) {
                Text(appointment.treatmentType.rawValue)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                AppointmentInfoGroup(
                    time: appointment.date.timeString,
                    doctor: appointment.doctorName
                )
            }
            
            Spacer()
            
            if showChevron {
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .accessibilityHidden(true)
            }
        }
        .padding(16)
        .background(CardStyle.apply(to: Color.clear))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel ?? 
            NSLocalizedString("Appointment for \(appointment.treatmentType.rawValue) with \(appointment.doctorName) on \(appointment.date.formatted(date: .long, time: .shortened))", 
                              comment: "Card accessibility label")
        )
        .if(accessibilityHint != nil) { view in
            view.accessibilityHint(accessibilityHint!)
        }
        .accessibilityHint(accessibilityHint ?? NSLocalizedString("Tap to view details", comment: "Card accessibility hint"))
    }
}

#Preview {
    VStack {
        AppointmentCard(
            appointment: Appointment.exampleUpcoming[0],
            accessibilityLabel: NSLocalizedString("Upcoming dental cleaning appointment", comment: "Card accessibility label")
        )
        AppointmentCard(
            appointment: Appointment.examplePast[0]
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
} 