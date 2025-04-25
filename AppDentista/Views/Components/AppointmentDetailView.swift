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
                Text("Appointment Details")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
        .sheet(isPresented: $isRescheduling) {
            NavigationView {
                RescheduleAppointmentView(appointment: appointment)
            }
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
    
    // MARK: - Action Buttons
    private var actionButtons: some View {
        VStack(spacing: 12) {
            PrimaryButton(
                title: "Reschedule",
                icon: "calendar.badge.clock",
                action: { isRescheduling = true }
            )
            
            Button {
                isCancelling = true
            } label: {
                HStack {
                    Image(systemName: "xmark.circle")
                    Text("Cancel Appointment")
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
        }
        .padding([.horizontal, .bottom])
    }
}

#Preview {
    NavigationView {
        AppointmentDetailView(appointment: Appointment.exampleUpcoming[0])
    }
} 