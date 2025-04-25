import SwiftUI

struct AppointmentsView: View {
    @State private var presentedAppointment: Appointment?
    
    var body: some View {
        ViewContainer(title: "My Appointments") {
            VStack(spacing: 24) {
                // Appointments list
                appointmentsSection
                
                // Book button
                NavigationLink(destination: BookAppointmentView()) {
                    PrimaryButton(
                        title: "Book New Appointment",
                        icon: "calendar.badge.plus",
                        action: {}
                    )
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .sheet(item: $presentedAppointment) { appointment in
            NavigationView {
                AppointmentDetailView(appointment: appointment)
            }
        }
    }
    
    // MARK: - Appointments Section
    private var appointmentsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Upcoming Appointments")
                .padding(.top, 16)
            
            if Appointment.exampleUpcoming.isEmpty {
                EmptyStateView(
                    icon: "calendar.badge.exclamationmark",
                    title: "No upcoming appointments",
                    message: "Tap the button below to schedule one",
                    iconColor: ColorTheme.primary
                )
            } else {
                appointmentsList
            }
        }
    }
    
    private var appointmentsList: some View {
        VStack(spacing: 16) {
            ForEach(Appointment.exampleUpcoming) { appointment in
                AppointmentCard(
                    appointment: appointment,
                    onTap: { presentedAppointment = appointment }
                )
            }
        }
    }
}

#Preview {
    AppointmentsView()
}
