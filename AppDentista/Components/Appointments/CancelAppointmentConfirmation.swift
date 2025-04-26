import SwiftUI

struct CancelAppointmentConfirmation: View {
    @Environment(\.dismiss) var dismiss
    let appointment: Appointment
    let onCancel: () -> Void
    
    @State private var cancellationReason = ""
    @State private var customReason = ""
    @State private var isSubmitting = false
    @State private var showingSuccess = false
    
    private let reasonOptions = [
        NSLocalizedString("Schedule conflict", comment: "Cancellation reason"),
        NSLocalizedString("Found another provider", comment: "Cancellation reason"),
        NSLocalizedString("No longer needed", comment: "Cancellation reason"),
        NSLocalizedString("Feeling better", comment: "Cancellation reason"),
        NSLocalizedString("Financial reasons", comment: "Cancellation reason"),
        NSLocalizedString("Other", comment: "Cancellation reason")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Warning header
                warningHeader
                
                // Appointment details
                appointmentDetailsCard
                
                // Reason selection
                reasonSelectionCard
                
                // Action buttons
                actionButtons
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
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
                        .accessibilityLabel(NSLocalizedString("Close", comment: "Button accessibility label"))
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text(NSLocalizedString("Cancel Appointment", comment: "Navigation title"))
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibilityAddTraits(.isHeader)
            }
        }
        .alert(isPresented: $showingSuccess) {
            Alert(
                title: Text(NSLocalizedString("Appointment Cancelled", comment: "Alert title")),
                message: Text(NSLocalizedString("Your appointment has been successfully cancelled.", comment: "Alert message")),
                dismissButton: .default(Text(NSLocalizedString("OK", comment: "Alert button"))) {
                    onCancel()
                    dismiss()
                }
            )
        }
    }
    
    // MARK: - Warning Header
    private var warningHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 28))
                    .foregroundColor(ColorTheme.warning)
                    .frame(width: 40, height: 40)
                    .accessibility(hidden: true)
                
                VStack(alignment: .leading) {
                    Text(NSLocalizedString("Cancel Appointment", comment: "Warning header"))
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text(NSLocalizedString("This action cannot be undone", comment: "Warning subtext"))
                        .font(.caption)
                        .foregroundColor(ColorTheme.warning)
                }
                
                Spacer()
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
        )
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(NSLocalizedString("Warning: Cancel Appointment. This action cannot be undone.", comment: "Warning accessibility label"))
        .accessibilityAddTraits(.isHeader)
    }
    
    // MARK: - Appointment Details
    private var appointmentDetailsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(NSLocalizedString("Appointment Details", comment: "Section header"))
                .font(.headline)
                .foregroundColor(.primary)
                .accessibilityAddTraits(.isHeader)
            
            detailRow(
                icon: "calendar", 
                title: NSLocalizedString("Date", comment: "Detail label"), 
                value: formattedDateTime(appointment.date)
            )
            
            Divider()
            
            detailRow(
                icon: "stethoscope", 
                title: NSLocalizedString("Treatment", comment: "Detail label"), 
                value: appointment.treatmentType.rawValue
            )
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
        )
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    // MARK: - Reason Selection
    private var reasonSelectionCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(NSLocalizedString("Cancellation Reason", comment: "Section header"))
                .font(.headline)
                .foregroundColor(.primary)
                .accessibilityAddTraits(.isHeader)
            
            Text(NSLocalizedString("Please select a reason for cancellation", comment: "Selection instruction"))
                .font(.subheadline)
                .foregroundColor(.secondary)
            
            VStack(spacing: 12) {
                ForEach(reasonOptions, id: \.self) { reason in
                    Button {
                        cancellationReason = reason
                    } label: {
                        HStack {
                            Text(reason)
                                .foregroundColor(.primary)
                            
                            Spacer()
                            
                            if cancellationReason == reason {
                                Image(systemName: "checkmark.circle.fill")
                                    .foregroundColor(ColorTheme.primary)
                                    .accessibility(hidden: true)
                            } else {
                                Circle()
                                    .strokeBorder(Color(.systemGray3), lineWidth: 1)
                                    .frame(width: 20, height: 20)
                                    .accessibility(hidden: true)
                            }
                        }
                        .padding(.vertical, 12)
                        .padding(.horizontal, 16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(cancellationReason == reason ? ColorTheme.primary.opacity(0.1) : Color(.systemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(
                                    cancellationReason == reason ? ColorTheme.primary : Color.gray.opacity(0.3),
                                    lineWidth: 1
                                )
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(reason)
                    .accessibilityHint(NSLocalizedString("Double tap to select this reason", comment: "Accessibility hint"))
                    .accessibilityAddTraits(cancellationReason == reason ? .isSelected : [])
                }
            }
            
            if cancellationReason == NSLocalizedString("Other", comment: "Cancellation reason") {
                TextField(NSLocalizedString("Please specify your reason", comment: "Text field placeholder"), text: $customReason)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .accessibilityHint(NSLocalizedString("Double tap to enter custom cancellation reason", comment: "Accessibility hint"))
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
        )
        .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
    }
    
    // MARK: - Action Buttons
    private var actionButtons: some View {
        VStack(spacing: 12) {
            Button {
                isSubmitting = true
                // Simulate network request
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    isSubmitting = false
                    showingSuccess = true
                }
            } label: {
                HStack {
                    if isSubmitting {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            .padding(.trailing, 8)
                    }
                    Text(NSLocalizedString("Confirm Cancellation", comment: "Button title"))
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(cancellationReason.isEmpty ? Color(.systemGray4) : ColorTheme.error)
                )
                .shadow(color: ColorTheme.error.opacity(cancellationReason.isEmpty ? 0 : 0.3), radius: 5, x: 0, y: 2)
            }
            .disabled(cancellationReason.isEmpty || isSubmitting)
            .accessibilityLabel(NSLocalizedString("Confirm appointment cancellation", comment: "Button accessibility label"))
            .accessibilityHint(NSLocalizedString("Double tap to cancel your appointment", comment: "Button accessibility hint"))
            
            Button {
                dismiss()
            } label: {
                Text(NSLocalizedString("Keep Appointment", comment: "Button title"))
                    .font(.headline)
                    .foregroundColor(ColorTheme.primary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color(.systemBackground))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(ColorTheme.primary, lineWidth: 1)
                    )
            }
            .accessibilityLabel(NSLocalizedString("Keep appointment", comment: "Button accessibility label"))
            .accessibilityHint(NSLocalizedString("Double tap to keep your appointment and go back", comment: "Button accessibility hint"))
        }
    }
    
    // MARK: - Helper Functions
    private func detailRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(ColorTheme.primary)
                .frame(width: 24)
                .accessibility(hidden: true)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(value)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            
            Spacer()
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(title): \(value)")
    }
    
    private func formattedDateTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationView {
        CancelAppointmentConfirmation(
            appointment: Appointment.exampleUpcoming[0],
            onCancel: {}
        )
    }
} 