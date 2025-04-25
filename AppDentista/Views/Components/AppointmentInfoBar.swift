import SwiftUI

/// A reusable component for displaying appointment details in a row format
struct AppointmentInfoBar: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: icon)
                .font(.caption2)
                .foregroundColor(.secondary)
            
            Text(value)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
    }
}

/// A reusable component that groups together common appointment info rows
struct AppointmentInfoGroup: View {
    let time: String
    let doctor: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            AppointmentInfoBar(
                icon: "clock.fill",
                title: "Time",
                value: time
            )
            
            AppointmentInfoBar(
                icon: "person.fill",
                title: "Doctor",
                value: doctor
            )
        }
    }
}

#Preview {
    VStack(alignment: .leading, spacing: 16) {
        AppointmentInfoBar(
            icon: "clock.fill",
            title: "Time",
            value: "3:00 PM"
        )
        
        AppointmentInfoGroup(
            time: "2:00 PM",
            doctor: "Dr. Sarah Johnson"
        )
    }
    .padding()
    .background(Color(.systemBackground))
} 