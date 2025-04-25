import SwiftUI

struct ProfileInfoRow: View {
    let icon: String
    let title: String
    let value: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(ColorTheme.primary)
                .frame(width: 20)
            
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
    }
}

struct ProfileToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    let icon: String
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .foregroundColor(ColorTheme.primary)
                .frame(width: 20)
            
            Text(title)
                .font(.body)
                .foregroundColor(.primary)
            
            Spacer()
            
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle(tint: ColorTheme.primary))
        }
        .padding(.vertical, 4)
    }
}

struct ProfileEditField: View {
    let title: String
    @Binding var text: String
    let icon: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            HStack {
                Image(systemName: icon)
                    .foregroundColor(ColorTheme.primary)
                    .frame(width: 20)
                
                TextField("", text: $text)
                    .font(.body)
                    .foregroundColor(.primary)
            }
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGroupedBackground))
            )
        }
    }
}

#Preview {
    VStack(spacing: 16) {
        ProfileInfoRow(
            icon: "person",
            title: "Name",
            value: "John Doe"
        )
        
        ProfileToggleRow(
            title: "Email Notifications",
            isOn: .constant(true),
            icon: "envelope"
        )
        
        ProfileEditField(
            title: "Full Name",
            text: .constant("John Doe"),
            icon: "person"
        )
    }
    .padding()
    .background(Color(.systemBackground))
} 