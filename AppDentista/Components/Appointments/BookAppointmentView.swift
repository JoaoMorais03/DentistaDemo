import SwiftUI

struct BookAppointmentView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedDate = Date()
    @State private var selectedTimeSlot: Date?
    @State private var selectedTreatment: Appointment.TreatmentType = .checkup
    @State private var showingConfirmation = false
    
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
                
                // Treatment selection
                treatmentSelectionView
                
                // Date selection
                dateSelectionView
                
                // Time slot selection
                timeSelectionView
                
                // Confirm button
                bookingButton
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(Color(.systemGroupedBackground).ignoresSafeArea())
        .navigationBarTitle(NSLocalizedString("Book Appointment", comment: "Navigation title"), displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(
                title: Text(NSLocalizedString("Appointment Booked!", comment: "Alert title")),
                message: Text(String(format: NSLocalizedString("Your %@ appointment has been booked for %@", comment: "Alert message"), selectedTreatment.rawValue, formattedDateTime)),
                dismissButton: .default(Text(NSLocalizedString("OK", comment: "Alert button"))) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        Text(NSLocalizedString("Book Your Appointment", comment: "Header title"))
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .padding(.top, 8)
            .accessibilityAddTraits(.isHeader)
    }
    
    // MARK: - Treatment Selection
    private var treatmentSelectionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(NSLocalizedString("Select Treatment Type", comment: "Section title"))
                .font(.headline)
                .foregroundColor(.primary)
            
            Picker(NSLocalizedString("Treatment Type", comment: "Picker title"), selection: $selectedTreatment) {
                ForEach(Appointment.TreatmentType.allCases, id: \.self) { treatment in
                    Text(treatment.rawValue).tag(treatment)
                }
            }
            .pickerStyle(MenuPickerStyle())
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemBackground))
            )
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            .accessibilityHint(NSLocalizedString("Double tap to select treatment type", comment: "Accessibility hint"))
        }
    }
    
    // MARK: - Date Selection
    private var dateSelectionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(NSLocalizedString("Select Date", comment: "Section title"))
                .font(.headline)
                .foregroundColor(.primary)
            
            DatePicker(
                NSLocalizedString("Select a date", comment: "DatePicker accessibility label"),
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
            Text(NSLocalizedString("Select Time", comment: "Section title"))
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
    
    // MARK: - Booking Button
    private var bookingButton: some View {
        Button {
            showingConfirmation = true
        } label: {
            Text(NSLocalizedString("Confirm Booking", comment: "Button title"))
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
        .accessibilityLabel(NSLocalizedString("Confirm appointment booking", comment: "Button accessibility label"))
        .accessibilityHint(NSLocalizedString("Double tap to book your appointment", comment: "Button accessibility hint"))
    }
    
    // MARK: - Helper Properties & Methods
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
}

#Preview {
    NavigationView {
        BookAppointmentView()
    }
} 