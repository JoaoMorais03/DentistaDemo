import SwiftUI

struct AppointmentsView: View {
    @State private var isLoading = false // For future backend integration
    @State private var appointments: [Appointment] = [] // Will be populated dynamically

    var body: some View {
        ViewContainer(title: NSLocalizedString("My Appointments", comment: "View title")) {
            if isLoading {
                VStack {
                    Spacer()
                    ProgressView(NSLocalizedString("Loading...", comment: "Loading indicator"))
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 400)
            } else {
                VStack(spacing: 24) {
                    appointmentsSection
                    
                    // Book button
                    PrimaryButtonLink(
                        title: NSLocalizedString("Book New Appointment", comment: "Button title"),
                        icon: "calendar.badge.plus",
                        destination: BookAppointmentView(),
                        accessibilityLabel: NSLocalizedString("Book New Appointment", comment: "Button accessibility label"),
                        accessibilityHint: NSLocalizedString("Tap to schedule a new appointment", comment: "Button accessibility hint")
                    )
                    .padding(.top, 8)
                    .padding(.bottom, 16)
                }
            }
        }
        .onAppear {
            // Simulate backend fetch
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                appointments = Appointment.exampleUpcoming
                isLoading = false
            }
        }
    }
    
    private var appointmentsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: NSLocalizedString("Upcoming Appointments", comment: "Section header"))
            
            if appointments.isEmpty {
                EmptyStateView(
                    icon: "calendar.badge.exclamationmark",
                    title: NSLocalizedString("No upcoming appointments", comment: "Empty state title"),
                    message: NSLocalizedString("Tap the button below to schedule one", comment: "Empty state message"),
                    iconColor: ColorTheme.primary
                )
                .accessibilityElement(children: .combine)
                .accessibilityLabel(NSLocalizedString("No upcoming appointments available", comment: "Accessibility label"))
            } else {
                appointmentsList
            }
        }
    }
    
    private var appointmentsList: some View {
        VStack(spacing: 16) {
            ForEach(appointments) { appointment in
                NavigationLink(destination: AppointmentDetailView(appointment: appointment)) {
                    AppointmentCard(
                        appointment: appointment,
                        showChevron: true
                    )
                    .accessibilityLabel(NSLocalizedString("Upcoming appointment with \(appointment.doctorName) on \(appointment.date)", comment: "Card accessibility label"))
                    .accessibilityHint(NSLocalizedString("Tap to view details", comment: "Card accessibility hint"))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}

#Preview {
    AppointmentsView()
}
