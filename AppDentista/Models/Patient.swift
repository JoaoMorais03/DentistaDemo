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
            
            var localizedName: String {
                switch self {
                case .morning: return NSLocalizedString("Morning", comment: "Appointment time preference")
                case .afternoon: return NSLocalizedString("Afternoon", comment: "Appointment time preference")
                case .evening: return NSLocalizedString("Evening", comment: "Appointment time preference")
                }
            }
        }
    }
    
    static let example = Patient(
        name: "João Silva",
        email: "joao.silva@exemplo.pt",
        phoneNumber: "912 345 678",
        birthDate: Calendar.current.date(from: DateComponents(year: 1985, month: 6, day: 15))!,
        address: Address(
            street: "Rua da Liberdade, 123",
            city: "Lisboa",
            state: "Lisboa",
            zipCode: "1250-096"
        ),
        emergencyContact: EmergencyContact(
            name: "Maria Silva",
            relationship: "Cônjuge",
            phoneNumber: "913 987 654"
        ),
        preferences: Preferences(
            appointmentReminders: true,
            emailNotifications: true,
            smsNotifications: false,
            preferredAppointmentTime: .afternoon
        )
    )
} 
