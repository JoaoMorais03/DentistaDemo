import SwiftUI

struct DashboardView: View {
    // Example patient data
    let patient = Patient.example
    @State private var showingNotification = false
    
    var body: some View {
        ViewContainer(
            title: "",
            trailingBarItem: AnyView(
                Button(action: {
                    showingNotification.toggle()
                }) {
                    Image(systemName: "bell")
                        .foregroundColor(.primary)
                }
            )
        ) {
            VStack(spacing: 24) {
                // Header
                ProfileHeaderView(name: patient.name)
                
                // Appointment Card
                upcomingAppointmentSection
                
                // Tips Section
                dentalTipsSection
            }
        }
        .alert(isPresented: $showingNotification) {
            Alert(
                title: Text("Today's Appointment"),
                message: Text("Dental cleaning at 2:00 PM. Please arrive 15 minutes early."),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    // MARK: - Upcoming Appointment Section
    private var upcomingAppointmentSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                SectionHeader(title: "Upcoming Appointment")
                
                Spacer()
                
                NavigationLink(destination: AppointmentsView()) {
                    Text("View All")
                        .font(.subheadline)
                        .foregroundColor(ColorTheme.primary)
                }
            }
            
            // Use the first example appointment from the model
            if !Appointment.exampleUpcoming.isEmpty {
                AppointmentCard(
                    appointment: Appointment.exampleUpcoming[0],
                    onTap: {}
                )
            } else {
                // Fallback if no example appointments exist
                EmptyStateView(
                    icon: "calendar.badge.exclamationmark",
                    title: "No upcoming appointments",
                    message: "Book an appointment to see it here",
                    iconColor: ColorTheme.primary
                )
            }
        }
    }
    
    // MARK: - Dental Tips Section
    private var dentalTipsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Dental Care Tips")
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    DentalTipCard(
                        icon: "toothbrush",
                        title: "Brushing",
                        description: "Brush teeth twice daily for 2 minutes using fluoride toothpaste",
                        color: ColorTheme.primary
                    )
                    
                    DentalTipCard(
                        icon: "slash.circle",
                        title: "Flossing",
                        description: "Floss once daily to clean between teeth where brushes can't reach",
                        color: ColorTheme.secondary
                    )
                    
                    DentalTipCard(
                        icon: "cup.and.saucer.fill",
                        title: "Diet",
                        description: "Limit sugary foods and drinks to protect your teeth and gums",
                        color: ColorTheme.accent
                    )
                }
                .padding(.bottom, 8)
            }
        }
    }
}

#Preview {
    DashboardView()
}
