import SwiftUI

struct AppointmentCard: View {
    let appointment: Appointment
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
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
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.secondary)
                    .font(.caption)
            }
            .padding(16)
            .background(CardStyle.apply(to: Color.clear))
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack {
        AppointmentCard(
            appointment: Appointment.exampleUpcoming[0],
            onTap: {}
        )
        AppointmentCard(
            appointment: Appointment.examplePast[0],
            onTap: {}
        )
    }
    .padding()
    .background(Color(.systemGroupedBackground))
} 