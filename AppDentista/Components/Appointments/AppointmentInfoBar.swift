import SwiftUI

/// A reusable component for displaying appointment details in a row format
struct AppointmentInfoBar: View {
    let icon: String
    let title: String
    let value: String
    var accessibilityLabel: String? = nil
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption2)
                .foregroundColor(.secondary)
                .accessibility(hidden: true)
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel ?? "\(title): \(value)")
    }
}

/// A reusable component that groups together common appointment info rows
struct AppointmentInfoGroup: View {
    let time: String
    let doctor: String
    var accessibilityLabel: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            AppointmentInfoBar(
                icon: "clock.fill",
                title: NSLocalizedString("Time", comment: "Appointment detail"),
                value: time
            )
            
            AppointmentInfoBar(
                icon: "person.fill",
                title: NSLocalizedString("Doctor", comment: "Appointment detail"),
                value: doctor
            )
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel ?? String(format: NSLocalizedString("Time: %@, Doctor: %@", comment: "Appointment info accessibility label"), time, doctor))
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        AppointmentInfoBar(
            icon: "clock.fill",
            title: NSLocalizedString("Time", comment: "Appointment detail"),
            value: "3:00 PM",
            accessibilityLabel: NSLocalizedString("Appointment time: 3:00 PM", comment: "Accessibility label")
        )
        
        AppointmentInfoGroup(
            time: "2:00 PM",
            doctor: "Dr. Sarah Johnson",
            accessibilityLabel: NSLocalizedString("Appointment at 2:00 PM with Dr. Sarah Johnson", comment: "Accessibility label")
        )
    }
    .padding()
    .background(Color(.systemBackground))
} 