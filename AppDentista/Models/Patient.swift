import Foundation

struct Patient: Identifiable {
    let id = UUID()
    let name: String
    let email: String
    let phoneNumber: String
    let birthDate: Date
    let address: Address
    let emergencyContact: EmergencyContact
    let preferences: Preferences
    
    struct Address {
        let street: String
        let city: String
        let state: String
        let zipCode: String
        
        func formattedAddress() -> String {
            return "\(street), \(city), \(state) \(zipCode)"
        }
    }
    
    struct EmergencyContact {
        let name: String
        let relationship: String
        let phoneNumber: String
    }
    
    struct Preferences {
        let appointmentReminders: Bool
        let emailNotifications: Bool
        let smsNotifications: Bool
        let preferredAppointmentTime: AppointmentTime
        
        enum AppointmentTime: String, CaseIterable {
            case morning = "Morning"
            case afternoon = "Afternoon"
            case evening = "Evening"
        }
    }
    
    static let example = Patient(
        name: "Sarah Johnson",
        email: "sarah.johnson@example.com",
        phoneNumber: "(555) 123-4567",
        birthDate: Calendar.current.date(from: DateComponents(year: 1985, month: 6, day: 15))!,
        address: Address(
            street: "123 Main Street",
            city: "Portland",
            state: "OR",
            zipCode: "97201"
        ),
        emergencyContact: EmergencyContact(
            name: "John Johnson",
            relationship: "Spouse",
            phoneNumber: "(555) 987-6543"
        ),
        preferences: Preferences(
            appointmentReminders: true,
            emailNotifications: true,
            smsNotifications: false,
            preferredAppointmentTime: .afternoon
        )
    )
} 
