import SwiftUI

struct AppointmentHistoryView: View {
    @State private var isLoading = false // For future backend integration
    @State private var appointments: [Appointment] = [] // Will be populated dynamically

    var body: some View {
        ViewContainer(title: NSLocalizedString("Appointment History", comment: "View title")) {
            if isLoading {
                VStack {
                    Spacer()
                    ProgressView(NSLocalizedString("Loading...", comment: "Loading indicator"))
                        .progressViewStyle(CircularProgressViewStyle())
                    Spacer()
                }
                .frame(maxWidth: .infinity, minHeight: 400)
            } else {
                historySection
            }
        }
        .onAppear {
            // Simulate backend fetch
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                appointments = Appointment.examplePast
                isLoading = false
            }
        }
    }
    
    private var historySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: NSLocalizedString("Past Appointments", comment: "Section header"))
            
            if appointments.isEmpty {
                EmptyStateView(
                    icon: "doc.text.magnifyingglass",
                    title: NSLocalizedString("No past appointments", comment: "Empty state title"),
                    message: NSLocalizedString("Your appointment history will appear here", comment: "Empty state message"),
                    iconColor: ColorTheme.secondary
                )
                .accessibilityElement(children: .combine)
                .accessibilityLabel(NSLocalizedString("No past appointments available", comment: "Accessibility label"))
            } else {
                historyList
            }
        }
    }
    
    private var historyList: some View {
        VStack(spacing: 16) {
            ForEach(appointments) { appointment in
                NavigationLink(destination: AppointmentHistoryDetailView(appointment: appointment)) {
                    AppointmentHistoryCard(
                        appointment: appointment
                    )
                    .accessibilityLabel(NSLocalizedString("Past appointment with \(appointment.doctorName) on \(appointment.date)", comment: "Card accessibility label"))
                    .accessibilityHint(NSLocalizedString("Tap to view details", comment: "Card accessibility hint"))
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}


#Preview {
    AppointmentHistoryView()
}

