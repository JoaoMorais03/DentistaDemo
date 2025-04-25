import Foundation

struct Appointment: Identifiable {
    let id = UUID()
    let patientId: UUID
    let date: Date
    let treatmentType: TreatmentType
    let isCompleted: Bool
    
    // Added fields to match what's displayed in views
    let doctorName: String
    let location: String
    let notes: String
    let treatmentNotes: String?  // Optional since it's only used for completed appointments
    let needsFollowUp: Bool
    let followUpInDays: Int?     // Optional, only applicable when needsFollowUp is true
    
    enum TreatmentType: String, CaseIterable {
        case checkup = "Checkup"
        case cleaning = "Cleaning"
        case filling = "Filling"
        case rootCanal = "Root Canal"
        case extraction = "Extraction"
        case consultation = "Consultation"
    }
    
    static let exampleUpcoming: [Appointment] = [
        Appointment(
            patientId: Patient.example.id,
            date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
            treatmentType: .checkup,
            isCompleted: false,
            doctorName: "Dr. Emma Williams",
            location: "Main Dental Clinic, Floor 2",
            notes: "Please arrive 15 minutes before your appointment time. Remember to bring your insurance card and ID.",
            treatmentNotes: nil,
            needsFollowUp: false,
            followUpInDays: nil
        ),
        Appointment(
            patientId: Patient.example.id,
            date: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
            treatmentType: .cleaning,
            isCompleted: false,
            doctorName: "Dr. Emma Williams",
            location: "Main Dental Clinic, Floor 2",
            notes: "Please arrive 15 minutes before your appointment time. Remember to bring your insurance card and ID.",
            treatmentNotes: nil,
            needsFollowUp: false,
            followUpInDays: nil
        )
    ]
    
    static let examplePast: [Appointment] = [
        Appointment(
            patientId: Patient.example.id,
            date: Calendar.current.date(byAdding: .day, value: -45, to: Date())!,
            treatmentType: .rootCanal,
            isCompleted: true,
            doctorName: "Dr. Sarah Johnson",
            location: "Main Dental Clinic, Floor 3",
            notes: "Please arrive 15 minutes before your appointment time. Remember to bring your insurance card and ID.",
            treatmentNotes: "Root canal therapy completed on lower left premolar. Canal sealed. Temporary crown placed.",
            needsFollowUp: false,
            followUpInDays: 7
        ),
        Appointment(
            patientId: Patient.example.id,
            date: Calendar.current.date(byAdding: .day, value: -90, to: Date())!,
            treatmentType: .cleaning,
            isCompleted: true,
            doctorName: "Dr. Emma Williams",
            location: "Main Dental Clinic, Floor 2",
            notes: "Please arrive 15 minutes before your appointment time. Remember to bring your insurance card and ID.",
            treatmentNotes: "Full dental cleaning performed. Tartar and plaque removed. Teeth polished.",
            needsFollowUp: true,
            followUpInDays: 180
        )
    ]
    
    static func getAvailableTimeSlots(for date: Date) -> [Date] {
        let calendar = Calendar.current
        let startTime = calendar.date(
            bySettingHour: 9, 
            minute: 0, 
            second: 0, 
            of: date
        )!
        
        return stride(from: 0, to: 8, by: 1).map { hour in
            calendar.date(byAdding: .hour, value: hour, to: startTime)!
        }
    }
    
    // Helper functions to generate appropriate treatment notes based on treatment type
    static func getTreatmentNotes(for treatmentType: TreatmentType) -> String {
        switch treatmentType {
        case .checkup:
            return "Regular dental checkup completed. No cavities found. Good oral hygiene maintained."
        case .cleaning:
            return "Full dental cleaning performed. Tartar and plaque removed. Teeth polished."
        case .filling:
            return "Filling performed on upper right molar. Composite material used. Patient tolerated procedure well."
        case .rootCanal:
            return "Root canal therapy completed on lower left premolar. Canal sealed. Temporary crown placed."
        case .extraction:
            return "Extraction of wisdom tooth completed. No complications during procedure. Post-operative care instructions provided."
        case .consultation:
            return "Initial consultation for orthodontic treatment. Discussed treatment options and costs."
        }
    }
    
    // Helper function to determine if a treatment type needs follow-up
    static func needsFollowUp(for treatmentType: TreatmentType) -> Bool {
        switch treatmentType {
        case .rootCanal, .extraction, .filling:
            return true
        default:
            return false
        }
    }
    
    // Helper function to determine recommended follow-up timeframe in days
    static func followUpTimeframe(for treatmentType: TreatmentType) -> Int? {
        switch treatmentType {
        case .rootCanal:
            return 14  // 2 weeks
        case .extraction:
            return 7   // 1 week
        case .filling:
            return 30  // 1 month
        default:
            return nil
        }
    }
} 
