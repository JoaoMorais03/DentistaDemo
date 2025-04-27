import SwiftUI

struct AppointmentDetailView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isRescheduling = false
    @State private var isCancelling = false
    let appointment: Appointment
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Treatment type card
                treatmentCard
                
                // Date & Time Section
                DateTimeContainer(date: appointment.date)
                    .padding(.horizontal)
                
                // Doctor & Location Section
                detailsSection
                
                // Notes Section
                notesSection
                
                // Action buttons (only for upcoming appointments)
                if !appointment.isCompleted {
                    actionButtons
                }
            }
            .padding(.top, 16)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle(NSLocalizedString("Appointment Details", comment: "Navigation title"))
        .sheet(isPresented: $isRescheduling) {
            NavigationView {
                RescheduleAppointmentView(appointment: appointment)
            }
            .accessibilityLabel(NSLocalizedString("Reschedule appointment sheet", comment: "Accessibility label"))
        }
        .sheet(isPresented: $isCancelling) {
            NavigationView {
                CancelAppointmentConfirmation(
                    appointment: appointment,
                    onCancel: {
                        dismiss()
                    }
                )
            }
            .accessibilityLabel(NSLocalizedString("Cancel appointment sheet", comment: "Accessibility label"))
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
                    .accessibility(hidden: true)
                
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("Treatment Type", comment: "Label text"))
                        .font(.caption)
                        .foregroundColor(.secondary)
                    Text(appointment.treatmentType.localizedName)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                }
                
                Spacer()
            }
        }
        .padding(.horizontal)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(String(format: NSLocalizedString("Treatment type: %@", comment: "Accessibility label"), appointment.treatmentType.localizedName))
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
    
    // MARK: - Action Buttons
    private var actionButtons: some View {
        VStack(spacing: 12) {
            PrimaryButton(
                title: NSLocalizedString("Reschedule", comment: "Button title"),
                icon: "calendar.badge.clock",
                accessibilityLabel: NSLocalizedString("Reschedule appointment", comment: "Button accessibility label"),
                accessibilityHint: NSLocalizedString("Double tap to change the date and time of your appointment", comment: "Button accessibility hint"),
                action: { isRescheduling = true }
            )
            
            Button {
                isCancelling = true
            } label: {
                HStack {
                    Image(systemName: "xmark.circle")
                        .accessibility(hidden: true)
                    Text(NSLocalizedString("Cancel Appointment", comment: "Button title"))
                }
                .font(.headline)
                .foregroundColor(ColorTheme.error)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: CardStyle.cornerRadius)
                        .fill(Color(.systemBackground))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: CardStyle.cornerRadius)
                        .stroke(ColorTheme.error, lineWidth: 1)
                )
            }
            .accessibilityLabel(NSLocalizedString("Cancel appointment", comment: "Button accessibility label"))
            .accessibilityHint(NSLocalizedString("Double tap to cancel your appointment", comment: "Button accessibility hint"))
        }
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    NavigationView {
        AppointmentDetailView(appointment: Appointment.exampleUpcoming[0])
    }
} 