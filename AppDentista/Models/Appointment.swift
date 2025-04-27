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
        
        var localizedName: String {
            switch self {
            case .checkup: return NSLocalizedString("Checkup", comment: "Treatment type")
            case .cleaning: return NSLocalizedString("Cleaning", comment: "Treatment type")
            case .filling: return NSLocalizedString("Filling", comment: "Treatment type")
            case .rootCanal: return NSLocalizedString("Root Canal", comment: "Treatment type")
            case .extraction: return NSLocalizedString("Extraction", comment: "Treatment type")
            case .consultation: return NSLocalizedString("Consultation", comment: "Treatment type")
            }
        }
    }
    
    static let exampleUpcoming: [Appointment] = [
        Appointment(
            patientId: Patient.example.id,
            date: Calendar.current.date(byAdding: .day, value: 3, to: Date())!,
            treatmentType: .checkup,
            isCompleted: false,
            doctorName: "Dr. Ana Sousa",
            location: "Clínica Dental Principal, Piso 2",
            notes: "Por favor, chegue 15 minutos antes da hora marcada. Lembre-se de trazer o seu cartão de seguro e identificação.",
            treatmentNotes: nil,
            needsFollowUp: false,
            followUpInDays: nil
        ),
        Appointment(
            patientId: Patient.example.id,
            date: Calendar.current.date(byAdding: .day, value: 10, to: Date())!,
            treatmentType: .cleaning,
            isCompleted: false,
            doctorName: "Dr. Ana Sousa",
            location: "Clínica Dental Principal, Piso 2",
            notes: "Por favor, chegue 15 minutos antes da hora marcada. Lembre-se de trazer o seu cartão de seguro e identificação.",
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
            doctorName: "Dr. Manuel Costa",
            location: "Clínica Dental Principal, Piso 3",
            notes: "Por favor, chegue 15 minutos antes da hora marcada. Lembre-se de trazer o seu cartão de seguro e identificação.",
            treatmentNotes: "Tratamento de canal concluído no pré-molar inferior esquerdo. Canal selado. Coroa temporária colocada.",
            needsFollowUp: false,
            followUpInDays: 7
        ),
        Appointment(
            patientId: Patient.example.id,
            date: Calendar.current.date(byAdding: .day, value: -90, to: Date())!,
            treatmentType: .cleaning,
            isCompleted: true,
            doctorName: "Dr. Ana Sousa",
            location: "Clínica Dental Principal, Piso 2",
            notes: "Por favor, chegue 15 minutos antes da hora marcada. Lembre-se de trazer o seu cartão de seguro e identificação.",
            treatmentNotes: "Limpeza dentária completa realizada. Tártaro e placa removidos. Dentes polidos.",
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
            return NSLocalizedString("Regular dental checkup completed. No cavities found. Good oral hygiene maintained.", comment: "Treatment notes")
        case .cleaning:
            return NSLocalizedString("Full dental cleaning performed. Tartar and plaque removed. Teeth polished.", comment: "Treatment notes")
        case .filling:
            return NSLocalizedString("Filling performed on upper right molar. Composite material used. Patient tolerated procedure well.", comment: "Treatment notes")
        case .rootCanal:
            return NSLocalizedString("Root canal therapy completed on lower left premolar. Canal sealed. Temporary crown placed.", comment: "Treatment notes")
        case .extraction:
            return NSLocalizedString("Extraction of wisdom tooth completed. No complications during procedure. Post-operative care instructions provided.", comment: "Treatment notes")
        case .consultation:
            return NSLocalizedString("Initial consultation for orthodontic treatment. Discussed treatment options and costs.", comment: "Treatment notes")
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
