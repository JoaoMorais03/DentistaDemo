import SwiftUI

struct AppointmentHistoryView: View {
    @State private var presentedHistoryAppointment: Appointment?
    
    var body: some View {
        ViewContainer(title: "Appointment History") {
            VStack(spacing: 24) {
                // History list
                historySection
            }
        }
        .sheet(item: $presentedHistoryAppointment) { appointment in
            NavigationView {
                AppointmentHistoryDetailView(appointment: appointment)
            }
        }
    }
    
    // MARK: - History Section
    private var historySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeader(title: "Past Appointments")
                .padding(.top, 16)
            
            if Appointment.examplePast.isEmpty {
                EmptyStateView(
                    icon: "doc.text.magnifyingglass",
                    title: "No past appointments",
                    message: "Your appointment history will appear here",
                    iconColor: ColorTheme.secondary
                )
            } else {
                historyList
            }
        }
    }
    
    private var historyList: some View {
        VStack(spacing: 16) {
            ForEach(Appointment.examplePast) { appointment in
                AppointmentHistoryCard(
                    appointment: appointment,
                    onTap: { presentedHistoryAppointment = appointment }
                )
            }
        }
    }
}

#Preview {
    AppointmentHistoryView()
} 