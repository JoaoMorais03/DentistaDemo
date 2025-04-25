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
        .navigationBarTitle("Book Appointment", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(
                title: Text("Appointment Booked!"),
                message: Text("Your \(selectedTreatment.rawValue) appointment has been booked for \(formattedDateTime)"),
                dismissButton: .default(Text("OK")) {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    // MARK: - Header View
    private var headerView: some View {
        Text("Book Your Appointment")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.primary)
            .padding(.top, 8)
    }
    
    // MARK: - Treatment Selection
    private var treatmentSelectionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Select Treatment Type")
                .font(.headline)
                .foregroundColor(.primary)
            
            Picker("Treatment Type", selection: $selectedTreatment) {
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
        }
    }
    
    // MARK: - Date Selection
    private var dateSelectionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Select Date")
                .font(.headline)
                .foregroundColor(.primary)
            
            DatePicker(
                "Select a date",
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
        }
    }
    
    // MARK: - Time Selection
    private var timeSelectionView: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Select Time")
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
                }
            }
        }
    }
    
    // MARK: - Booking Button
    private var bookingButton: some View {
        Button {
            showingConfirmation = true
        } label: {
            Text("Confirm Booking")
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
    }
    
    // MARK: - Helper Properties & Methods
    private var formattedDateTime: String {
        guard let timeSlot = selectedTimeSlot else { 
            return "selected date and time" 
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