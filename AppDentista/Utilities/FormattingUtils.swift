import SwiftUI
import Foundation

// MARK: - Date Formatting
extension DateFormatter {
    /// Standard date formatter with medium date style
    static let mediumDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter
    }()
    
    /// Standard date and time formatter
    static let mediumDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        return formatter
    }()
    
    /// Long date formatter
    static let longDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        formatter.locale = Locale.current
        return formatter
    }()
    
    /// Time only formatter
    static let shortTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        formatter.locale = Locale.current
        return formatter
    }()
    
    /// Day only formatter (numeric)
    static let dayOnly: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd"
        formatter.locale = Locale.current
        return formatter
    }()
    
    /// Month only formatter (abbreviated)
    static let monthAbbreviated: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM"
        formatter.locale = Locale.current
        return formatter
    }()
}

// MARK: - Formatting Extensions
extension Date {
    /// Returns the day number as a string
    var dayString: String {
        return DateFormatter.dayOnly.string(from: self)
    }
    
    /// Returns the month abbreviation as an uppercase string
    var monthUppercased: String {
        return DateFormatter.monthAbbreviated.string(from: self).uppercased()
    }
    
    /// Returns the time as a string
    var timeString: String {
        return DateFormatter.shortTime.string(from: self)
    }
    
    /// Returns a medium-formatted date and time
    var formattedDateTime: String {
        return DateFormatter.mediumDateTime.string(from: self)
    }
    
    /// Returns a long-formatted date
    var longDateString: String {
        return DateFormatter.longDate.string(from: self)
    }
}

// MARK: - Treatment Type Icons
extension Appointment.TreatmentType {
    /// Returns the appropriate SF Symbol name for each treatment type
    var iconName: String {
        switch self {
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