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
        .navigationTitle(NSLocalizedString("Appointment History", comment: "Navigation title"))
    }
    
    // MARK: - Treatment Card
    private var treatmentCard: some View {
        CardContainer {
            HStack {
                Image(systemName: appointment.treatmentType.iconName)
                    .font(.system(size: 28))
                    .foregroundColor(ColorTheme.primary)
                    .frame(width: 40, height: 40)
                    .accessibility(hidden: true)
                
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("Treatment Type", comment: "Label text"))
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
        .accessibilityElement(children: .combine)
        .accessibilityLabel(String(format: NSLocalizedString("Treatment type: %@", comment: "Accessibility label"), appointment.treatmentType.rawValue))
    }
    
    // MARK: - Status Card
    private var statusCard: some View {
        CardContainer {
            HStack {
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("Status", comment: "Label text"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    CompletedStatusPill()
                        .padding(.top, 4)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(NSLocalizedString("Status: Completed", comment: "Accessibility label"))
    }
    
    // MARK: - Details Section
    private var detailsSection: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 16) {
                SectionHeader(title: NSLocalizedString("Details", comment: "Section header"))
                    .accessibilityAddTraits(.isHeader)
                
                DetailRow(
                    icon: "person.fill",
                    title: NSLocalizedString("Doctor", comment: "Detail label"),
                    value: appointment.doctorName,
                    accessibilityLabel: String(format: NSLocalizedString("Doctor: %@", comment: "Accessibility label"), appointment.doctorName)
                )
                
                Divider()
                
                DetailRow(
                    icon: "mappin.and.ellipse",
                    title: NSLocalizedString("Location", comment: "Detail label"),
                    value: appointment.location,
                    accessibilityLabel: String(format: NSLocalizedString("Location: %@", comment: "Accessibility label"), appointment.location)
                )
            }
        }
        .padding(.horizontal)
    }
    
    // MARK: - Notes Section
    private var notesSection: some View {
        CardContainer {
            VStack(alignment: .leading, spacing: 16) {
                SectionHeader(title: NSLocalizedString("Notes", comment: "Section header"))
                    .accessibilityAddTraits(.isHeader)
                
                Text(appointment.notes)
                    .font(.body)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(.horizontal)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(String(format: NSLocalizedString("Notes: %@", comment: "Accessibility label"), appointment.notes))
    }
}

#Preview {
    NavigationView {
        AppointmentHistoryDetailView(appointment: Appointment.examplePast[0])
    }
} 