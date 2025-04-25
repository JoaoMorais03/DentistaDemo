import SwiftUI

struct AppointmentHistoryDetailView: View {
    @Environment(\.dismiss) var dismiss
    let appointment: Appointment
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Treatment type card
                treatmentCard
                
                // Status card
                statusCard
                
                // Date & Time Section
                DateTimeContainer(date: appointment.date)
                    .padding(.horizontal)
                
                // Doctor & Location Section
                detailsSection
                
                // Notes Section
                notesSection
            }
            .padding(.top, 16)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.primary)
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Appointment History")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
    }
    
    // MARK: - Treatment Card
    private var treatmentCard: some View {
        CardContainer {
            HStack {
                Image(systemName: appointment.treatmentType.iconName)
                    .font(.system(size: 28))
                    .foregroundColor(ColorTheme.primary)
                    .frame(width: 40, height: 40)
                
                VStack(alignment: .leading) {
                    Text("Treatment Type")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(appointment.treatmentType.rawValue)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Status Card
    private var statusCard: some View {
        CardContainer {
            HStack {
                VStack(alignment: .leading) {
                    Text("Status")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    CompletedStatusPill()
                        .padding(.top, 4)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Details Section
    private var detailsSection: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 16) {
                SectionHeader(title: "Details")
                
                DetailRow(
                    icon: "person.fill",
                    title: "Doctor",
                    value: appointment.doctorName
                )
                
                Divider()
                
                DetailRow(
                    icon: "mappin.and.ellipse",
                    title: "Location",
                    value: appointment.location
                )
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Notes Section
    private var notesSection: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 16) {
                SectionHeader(title: "Notes")
                
                Text(appointment.notes)
                    .font(.body)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    NavigationView {
        AppointmentHistoryDetailView(appointment: Appointment.examplePast[0])
    }
} 