import SwiftUI

struct ProfileView: View {
    @State private var patient = Patient.example
    @State private var isEditing = false
    @State private var editedName = ""
    @State private var editedEmail = ""
    @State private var editedPhone = ""
    @State private var editedStreet = ""
    @State private var editedCity = ""
    @State private var editedState = ""
    @State private var editedZipCode = ""
    @State private var editedEmergencyName = ""
    @State private var editedEmergencyRelationship = ""
    @State private var editedEmergencyPhone = ""
    @State private var selectedTab = 0
    
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    private let tabs = ["Personal", "Preferences"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Tab selector
                tabSelector
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Profile Header
                        profileHeader
                        
                        // Content based on selected tab
                        if selectedTab == 0 {
                            personalInfoSection
                        } else {
                            preferencesSection
                        }
                        
                        // Edit mode controls
                        if isEditing {
                            editControls
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 32)
                }
                .background(Color(.systemGroupedBackground))
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My Profile")
                        .font(.headline)
                        .foregroundColor(.primary)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    if !isEditing {
                        Button {
                            startEditing()
                        } label: {
                            Image(systemName: "pencil")
                                .foregroundColor(.primary)
                        }
                    }
                }
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Profile Updated"),
                    message: Text(alertMessage),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
    
    // MARK: - Tab Selector
    private var tabSelector: some View {
        HStack(spacing: 0) {
            ForEach(0..<tabs.count, id: \.self) { index in
                Button {
                    selectedTab = index
                } label: {
                    VStack(spacing: 8) {
                        Text(tabs[index])
                            .font(.subheadline)
                            .fontWeight(selectedTab == index ? .semibold : .regular)
                            .foregroundColor(selectedTab == index ? ColorTheme.primary : .secondary)
                        
                        Rectangle()
                            .fill(selectedTab == index ? ColorTheme.primary : Color.clear)
                            .frame(height: 2)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .background(Color(.systemBackground))
    }
    
    // MARK: - Profile Header
    private var profileHeader: some View {
        VStack(spacing: 16) {
            Image(systemName: "person.circle.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(ColorTheme.primary)
                .padding(.top, 16)
            
            Text(isEditing ? editedName : patient.name)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text("Patient")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(CardStyle.apply(to: Color.clear))
    }
    
    // MARK: - Personal Info Section
    private var personalInfoSection: some View {
        VStack(spacing: 16) {
            // Personal Information card
            ProfileSectionCard(title: "Personal Information", icon: "person.fill") {
                if isEditing {
                    VStack(spacing: 12) {
                        ProfileEditField(title: "Full Name", text: $editedName, icon: "person")
                        ProfileEditField(title: "Email", text: $editedEmail, icon: "envelope")
                        ProfileEditField(title: "Phone", text: $editedPhone, icon: "phone")
                    }
                } else {
                    VStack(spacing: 12) {
                        ProfileInfoRow(icon: "person", title: "Name", value: patient.name)
                        ProfileInfoRow(icon: "envelope", title: "Email", value: patient.email)
                        ProfileInfoRow(icon: "phone", title: "Phone", value: patient.phoneNumber)
                        ProfileInfoRow(icon: "calendar", title: "Date of Birth", value: formatDate(patient.birthDate))
                    }
                }
            }
            
            // Address card
            ProfileSectionCard(title: "Address", icon: "house.fill") {
                if isEditing {
                    VStack(spacing: 12) {
                        ProfileEditField(title: "Street", text: $editedStreet, icon: "mappin.and.ellipse")
                        ProfileEditField(title: "City", text: $editedCity, icon: "building.2")
                        ProfileEditField(title: "State", text: $editedState, icon: "map")
                        ProfileEditField(title: "Zip Code", text: $editedZipCode, icon: "number")
                    }
                } else {
                    ProfileInfoRow(icon: "mappin.and.ellipse", title: "Address", value: patient.address.formattedAddress())
                }
            }
            
            // Emergency Contact card
            ProfileSectionCard(title: "Emergency Contact", icon: "exclamationmark.shield.fill") {
                if isEditing {
                    VStack(spacing: 12) {
                        ProfileEditField(title: "Name", text: $editedEmergencyName, icon: "person.2")
                        ProfileEditField(title: "Relationship", text: $editedEmergencyRelationship, icon: "person.2.circle")
                        ProfileEditField(title: "Phone", text: $editedEmergencyPhone, icon: "phone.circle")
                    }
                } else {
                    VStack(spacing: 12) {
                        ProfileInfoRow(icon: "person.2", title: "Name", value: patient.emergencyContact.name)
                        ProfileInfoRow(icon: "person.2.circle", title: "Relationship", value: patient.emergencyContact.relationship)
                        ProfileInfoRow(icon: "phone.circle", title: "Phone", value: patient.emergencyContact.phoneNumber)
                    }
                }
            }
        }
    }
    
    // MARK: - Preferences Section
    private var preferencesSection: some View {
        VStack(spacing: 16) {
            // Communication Preferences card
            ProfileSectionCard(title: "Communication Preferences", icon: "bell.fill") {
                VStack(spacing: 8) {
                    ProfileToggleRow(
                        title: "Appointment Reminders",
                        isOn: .constant(patient.preferences.appointmentReminders),
                        icon: "calendar.badge.clock"
                    )
                    
                    Divider()
                    
                    ProfileToggleRow(
                        title: "Email Notifications",
                        isOn: .constant(patient.preferences.emailNotifications),
                        icon: "envelope"
                    )
                    
                    Divider()
                    
                    ProfileToggleRow(
                        title: "SMS Notifications",
                        isOn: .constant(patient.preferences.smsNotifications),
                        icon: "message"
                    )
                }
            }
            
            // Appointment Preferences card
            ProfileSectionCard(title: "Appointment Preferences", icon: "clock.fill") {
                ProfileInfoRow(
                    icon: "clock",
                    title: "Preferred Time",
                    value: patient.preferences.preferredAppointmentTime.rawValue
                )
            }
        }
    }
    
    // MARK: - Edit Controls
    private var editControls: some View {
        HStack(spacing: 16) {
            Button(action: cancelEdit) {
                HStack {
                    Image(systemName: "xmark.circle")
                    Text("Cancel")
                }
                .font(.headline)
                .foregroundColor(ColorTheme.error)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(ColorTheme.error, lineWidth: 1)
                        )
                )
            }
            
            Button(action: saveChanges) {
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text("Save")
                }
                .font(.headline)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(ColorTheme.primary)
                )
                .shadow(color: ColorTheme.primary.opacity(0.3), radius: 5, x: 0, y: 2)
            }
        }
        .padding(.top, 20)
    }
    
    // MARK: - Helper Functions
    private func startEditing() {
        editedName = patient.name
        editedEmail = patient.email
        editedPhone = patient.phoneNumber
        editedStreet = patient.address.street
        editedCity = patient.address.city
        editedState = patient.address.state
        editedZipCode = patient.address.zipCode
        editedEmergencyName = patient.emergencyContact.name
        editedEmergencyRelationship = patient.emergencyContact.relationship
        editedEmergencyPhone = patient.emergencyContact.phoneNumber
        isEditing = true
    }
    
    private func cancelEdit() {
        isEditing = false
    }
    
    private func saveChanges() {
        // In a real app, this would update the database
        showingAlert = true
        alertMessage = "Profile information updated successfully"
        isEditing = false
    }
    
    private func formatDate(_ date: Date) -> String {
        DateFormatter.mediumDate.string(from: date)
    }
}

#Preview {
    ProfileView()
} 