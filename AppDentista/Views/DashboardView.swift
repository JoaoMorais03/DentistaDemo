import SwiftUI

struct DashboardView: View {
    @State private var isLoading = false // For future backend integration
    @State private var patient: Patient? // Will be populated dynamically
    @State private var upcomingAppointment: Appointment? // Will be populated dynamically

    var body: some View {
        ViewContainer(
            title: ""
        ) {
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
                    ProfileHeaderView(name: patient?.name ?? NSLocalizedString("User", comment: "Default user name"))
                        .accessibilityLabel(NSLocalizedString("Welcome, \(patient?.name ?? "User")", comment: "Header accessibility label"))
                    
                    upcomingAppointmentSection
                    
                    dentalTipsSection
                }
            }
        }
        .onAppear {
            // Simulate backend fetch
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                patient = Patient.example
                upcomingAppointment = Appointment.exampleUpcoming.first
                isLoading = false
            }
        }
    }
    
    private var upcomingAppointmentSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: NSLocalizedString("Upcoming Appointment", comment: "Section header"))
            
            if let appointment = upcomingAppointment {
                AppointmentCard(
                    appointment: appointment,
                    showChevron: false
                )
                .accessibilityLabel(NSLocalizedString("Upcoming appointment with \(appointment.doctorName) on \(appointment.date)", comment: "Card accessibility label"))
            } else {
                EmptyStateView(
                    icon: "calendar.badge.exclamationmark",
                    title: NSLocalizedString("No upcoming appointments", comment: "Empty state title"),
                    message: NSLocalizedString("Book an appointment to see it here", comment: "Empty state message"),
                    iconColor: ColorTheme.primary
                )
                .accessibilityElement(children: .combine)
                .accessibilityLabel(NSLocalizedString("No upcoming appointments available", comment: "Accessibility label"))
            }
        }
    }
    
    private var dentalTipsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: NSLocalizedString("Dental Care Tips", comment: "Section header"))
            
            VStack(spacing: 16) {
                DentalTipCard(
                    icon: "slash.circle",
                    title: NSLocalizedString("Flossing", comment: "Tip title"),
                    description: NSLocalizedString("Floss once daily to clean between teeth where brushes can't reach", comment: "Tip description"),
                    color: ColorTheme.secondary
                )
                .accessibilityLabel(NSLocalizedString("Flossing tip: Floss once daily to clean between teeth where brushes can't reach", comment: "Card accessibility label"))
                
                DentalTipCard(
                    icon: "cup.and.saucer.fill",
                    title: NSLocalizedString("Diet", comment: "Tip title"),
                    description: NSLocalizedString("Limit sugary foods and drinks to protect your teeth and gums", comment: "Tip description"),
                    color: ColorTheme.accent
                )
                .accessibilityLabel(NSLocalizedString("Diet tip: Limit sugary foods and drinks to protect your teeth and gums", comment: "Card accessibility label"))
            }
            .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    DashboardView()
}

