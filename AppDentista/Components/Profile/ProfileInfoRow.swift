import SwiftUI

struct ProfileInfoRow: View {
    let icon: String
    let title: String
    let value: String
    var accessibilityLabel: String? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(ColorTheme.primary)
                .frame(width: 20)
                .accessibility(hidden: true)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                if !value.isEmpty {
                    Text(value)
                        .font(.body)
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(accessibilityLabel ?? "\(title): \(value)")
    }
}

struct ProfileToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    let icon: String
    var accessibilityHint: String? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(ColorTheme.primary)
                .frame(width: 20)
                .accessibility(hidden: true)
            
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: ColorTheme.primary))
        }
        .padding(.vertical, 4)
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
        .accessibilityValue(isOn ? NSLocalizedString("On", comment: "Toggle state") : NSLocalizedString("Off", comment: "Toggle state"))
        .accessibilityHint(accessibilityHint ?? NSLocalizedString("Double tap to toggle setting", comment: "Toggle accessibility hint"))
    }
}

struct ProfileEditField: View {
    let title: String
    @Binding var text: String
    let icon: String
    var placeholder: String = ""
    var accessibilityHint: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(ColorTheme.primary)
                    .frame(width: 20)
                    .accessibility(hidden: true)
                
                TextField(placeholder, text: $text)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGroupedBackground))
            )
        }
        .accessibilityElement(children: .combine)
        .accessibilityLabel(title)
        .accessibilityValue(text)
        .accessibilityHint(accessibilityHint ?? NSLocalizedString("Double tap to edit", comment: "Edit field accessibility hint"))
    }
}

#Preview {
    VStack(spacing: 16) {
        ProfileInfoRow(
            icon: "person",
            title: NSLocalizedString("Name", comment: "Field label"),
            value: "John Doe",
            accessibilityLabel: NSLocalizedString("Name: John Doe", comment: "Field accessibility label")
        )
        
        ProfileToggleRow(
            title: NSLocalizedString("Email Notifications", comment: "Toggle label"),
            isOn: .constant(true),
            icon: "envelope",
            accessibilityHint: NSLocalizedString("Double tap to enable or disable email notifications", comment: "Toggle accessibility hint")
        )
        
        ProfileEditField(
            title: NSLocalizedString("Full Name", comment: "Field label"),
            text: .constant("John Doe"),
            icon: "person",
            placeholder: NSLocalizedString("Enter your name", comment: "Field placeholder"),
            accessibilityHint: NSLocalizedString("Double tap to edit your name", comment: "Field accessibility hint")
        )
    }
    .padding()
    .background(Color(.systemBackground))
} 