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
        "Schedule conflict",
        "Found another provider",
        "No longer needed",
        "Feeling better",
        "Financial reasons",
        "Other"
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
                }
            }
            
            ToolbarItem(placement: .principal) {
                Text("Cancel Appointment")
                    .font(.headline)
                    .foregroundColor(.primary)
            }
        }
        .alert(isPresented: $showingSuccess) {
            Alert(
                title: Text("Appointment Cancelled"),
                message: Text("Your appointment has been successfully cancelled."),
                dismissButton: .default(Text("OK")) {
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
                
                VStack(alignment: .leading) {
                    Text("Cancel Appointment")
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    Text("This action cannot be undone")
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
    }
    
    // MARK: - Appointment Details
    private var appointmentDetailsCard: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Appointment Details")
                .font(.headline)
                .foregroundColor(.primary)
            
            detailRow(icon: "calendar", title: "Date", value: formattedDateTime(appointment.date))
            
            Divider()
            
            detailRow(icon: "stethoscope", title: "Treatment", value: appointment.treatmentType.rawValue)
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
            Text("Cancellation Reason")
                .font(.headline)
                .foregroundColor(.primary)
            
            Text("Please select a reason for cancellation")
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
                            } else {
                                Circle()
                                    .strokeBorder(Color(.systemGray3), lineWidth: 1)
                                    .frame(width: 20, height: 20)
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
                }
            }
            
            if cancellationReason == "Other" {
                TextField("Please specify your reason", text: $customReason)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
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
                    Text("Confirm Cancellation")
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
            
            Button {
                dismiss()
            } label: {
                Text("Keep Appointment")
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
        }
    }
    
    // MARK: - Helper Functions
    private func detailRow(icon: String, title: String, value: String) -> some View {
        HStack(spacing: 15) {
            Image(systemName: icon)
                .font(.body)
                .foregroundColor(ColorTheme.primary)
                .frame(width: 24)
            
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