import SwiftUI

struct RescheduleAppointmentView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.dismiss) var dismiss
    let appointment: Appointment
    
    @State private var selectedDate: Date
    @State private var selectedTimeSlot: Date?
    @State private var selectedTreatment: Appointment.TreatmentType
    @State private var showingConfirmation = false
    
    init(appointment: Appointment) {
        self.appointment = appointment
        // Initialize state variables with current appointment values
        _selectedDate = State(initialValue: appointment.date)
        _selectedTreatment = State(initialValue: appointment.treatmentType)
        _selectedTimeSlot = State(initialValue: appointment.date)
    }
    
    private let dateRange: ClosedRange<Date> = {
        let calendar = Calendar.current
        let startComponents = DateComponents(year: calendar.component(.year, from: Date()), month: calendar.component(.month, from: Date()), day: calendar.component(.day, from: Date()))
        let startDate = calendar.date(from: startComponents)!
        
        let endComponents = DateComponents(year: calendar.component(.year, from: Date()), month: calendar.component(.month, from: Date()) + 3, day: calendar.component(.day, from: Date()))
        let endDate = calendar.date(from: endComponents)!
        
        return startDate...endDate
    }()
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                headerView
                
                // Treatment info
                treatmentInfoView
                
                // Date selection
                dateSelectionView
                
                // Time slot selection
                timeSelectionView
                
                // Confirm button
                confirmButton
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationBarTitle(NSLocalizedString("Reschedule", comment: "Navigation title"), displayMode: .inline)
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
        }
        .alert(isPresented: $showingConfirmation) {
            Alert(
                title: Text(NSLocalizedString("Appointment Rescheduled!", comment: "Alert title")),
                message: Text(String(format: NSLocalizedString("Your %@ appointment has been rescheduled for %@", comment: "Alert message"), selectedTreatment.localizedName, formattedDateTime)),
                dismissButton: .default(Text(NSLocalizedString("OK", comment: "Alert button"))) {
                    // Dismiss both the reschedule view and the detail view
                    dismiss()
                }
            )
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        Text(NSLocalizedString("Reschedule Your Appointment", comment: "Header title"))
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .padding(.top, 8)
            .accessibilityAddTraits(.isHeader)
    }
    
    // MARK: - Treatment Info
    private var treatmentInfoView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(NSLocalizedString("Treatment Type", comment: "Section title"))
                .font(.headline)
                .foregroundColor(.primary)
            
            HStack {
                Image(systemName: iconName(for: selectedTreatment))
                    .foregroundColor(ColorTheme.primary)
                    .accessibility(hidden: true)
                Text(selectedTreatment.localizedName)
                    .foregroundColor(.primary)
                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
            )
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            .accessibilityElement(children: .combine)
            .accessibilityLabel(String(format: NSLocalizedString("Treatment type: %@", comment: "Accessibility label"), selectedTreatment.localizedName))
        }
    }
    
    // MARK: - Date Selection
    private var dateSelectionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(NSLocalizedString("Select New Date", comment: "Section title"))
                .font(.headline)
                .foregroundColor(.primary)
            
            DatePicker(
                NSLocalizedString("Select a date", comment: "Date picker accessibility label"),
                selection: $selectedDate,
                in: dateRange,
                displayedComponents: [.date]
            )
            .datePickerStyle(GraphicalDatePickerStyle())
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
            )
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            .accessibilityHint(NSLocalizedString("Double tap to open date picker", comment: "Accessibility hint"))
        }
    }
    
    // MARK: - Time Selection
    private var timeSelectionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(NSLocalizedString("Select New Time", comment: "Section title"))
                .font(.headline)
                .foregroundColor(.primary)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100))], spacing: 10) {
                ForEach(Appointment.getAvailableTimeSlots(for: selectedDate), id: \.self) { timeSlot in
                    Button {
                        selectedTimeSlot = timeSlot
                    } label: {
                        Text(formattedTime(timeSlot))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(selectedTimeSlot == timeSlot ? ColorTheme.primary : Color(.systemBackground))
                            .foregroundColor(selectedTimeSlot == timeSlot ? .white : .primary)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(ColorTheme.primary, lineWidth: 1)
                            )
                    }
                    .buttonStyle(PlainButtonStyle())
                    .accessibilityLabel(String(format: NSLocalizedString("Time slot: %@", comment: "Time slot accessibility label"), formattedTime(timeSlot)))
                    .accessibilityAddTraits(selectedTimeSlot == timeSlot ? [.isButton, .isSelected] : .isButton)
                    .accessibilityHint(NSLocalizedString("Double tap to select this time slot", comment: "Accessibility hint"))
                }
            }
        }
    }
    
    // MARK: - Confirm Button
    private var confirmButton: some View {
        Button {
            showingConfirmation = true
        } label: {
            Text(NSLocalizedString("Confirm Reschedule", comment: "Button title"))
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(selectedTimeSlot != nil ? ColorTheme.primary : Color(.systemGray4))
                )
                .shadow(color: selectedTimeSlot != nil ? ColorTheme.primary.opacity(0.3) : Color.clear, radius: 5, x: 0, y: 2)
        }
        .disabled(selectedTimeSlot == nil)
        .padding(.top, 16)
        .accessibilityLabel(NSLocalizedString("Confirm appointment reschedule", comment: "Button accessibility label"))
        .accessibilityHint(NSLocalizedString("Double tap to confirm your new appointment time", comment: "Button accessibility hint"))
    }
    
    // MARK: - Helper Functions
    private var formattedDateTime: String {
        guard let timeSlot = selectedTimeSlot else { 
            return NSLocalizedString("selected date and time", comment: "Default date time text") 
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: timeSlot)
    }
    
    private func formattedTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
    private func iconName(for treatmentType: Appointment.TreatmentType) -> String {
        switch treatmentType {
        case .checkup:
            return "heart.text.square.fill"
        case .cleaning:
            return "sparkles"
        case .filling:
            return "seal.fill"
        case .rootCanal:
            return "waveform.path.ecg"
        case .extraction:
            return "scissors"
        case .consultation:
            return "text.bubble.fill"
        }
    }
}