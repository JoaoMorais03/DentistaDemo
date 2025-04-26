import SwiftUI

struct ProfileView: View {
    @State private var patient: Patient?
    @State private var isEditing = false
    @State private var isLoading = false // For future backend integration
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
    
    private let tabs = [
        NSLocalizedString("Personal", comment: "Tab label"),
        NSLocalizedString("Preferences", comment: "Tab label")
    ]
    
    var body: some View {
        ViewContainer(
            title: NSLocalizedString("My Profile", comment: "View title"),
            trailingBarItem: !isEditing ? AnyView(
                Button {
                    startEditing()
                } label: {
                    Image(systemName: "pencil")
                        .foregroundColor(.primary)
                        .accessibilityLabel(NSLocalizedString("Edit profile", comment: "Button accessibility label"))
                        .accessibilityHint(NSLocalizedString("Tap to edit your profile information", comment: "Button accessibility hint"))
                }
            ) : AnyView(EmptyView())
        ) {
            VStack(spacing: 24) {
                if isLoading {
                    VStack {
                        Spacer()
                        ProgressView(NSLocalizedString("Loading...", comment: "Loading indicator"))
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, minHeight: 300)
                } else {
                    // Tab selector
                    tabSelector
                    
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
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(
                title: Text(NSLocalizedString("Profile Updated", comment: "Alert title")),
                message: Text(alertMessage),
                dismissButton: .default(Text(NSLocalizedString("OK", comment: "Alert dismiss button")))
            )
        }
        .onAppear {
            // Simulate backend fetch
            isLoading = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                patient = Patient.example
                isLoading = false
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
                    .accessibilityLabel(tabs[index])
                    .accessibilityAddTraits(selectedTab == index ? .isSelected : [])
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
                .accessibilityHidden(true)
            
            Text(isEditing ? editedName : patient?.name ?? NSLocalizedString("User", comment: "Default user name"))
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.primary)
            
            Text(NSLocalizedString("Patient", comment: "User role label"))
                .font(.subheadline)
                .foregroundColor(.secondary)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
        .padding(20)
        .background(CardStyle.apply(to: Color.clear))
        .accessibilityElement(children: .combine)
        .accessibilityLabel(NSLocalizedString("Profile information for \(patient?.name ?? "User")", comment: "Profile header accessibility label"))
    }
    
    // MARK: - Personal Info Section
    private var personalInfoSection: some View {
        VStack(spacing: 16) {
            // Personal Information card
            ProfileSectionCard(
                title: NSLocalizedString("Personal Information", comment: "Section title"),
                icon: "person.fill"
            ) {
                if isEditing {
                    VStack(spacing: 12) {
                        ProfileEditField(
                            title: NSLocalizedString("Full Name", comment: "Field label"),
                            text: $editedName,
                            icon: "person"
                        )
                        .accessibilityHint(NSLocalizedString("Enter your full name", comment: "Field accessibility hint"))
                        
                        ProfileEditField(
                            title: NSLocalizedString("Email", comment: "Field label"),
                            text: $editedEmail,
                            icon: "envelope"
                        )
                        .accessibilityHint(NSLocalizedString("Enter your email address", comment: "Field accessibility hint"))
                        
                        ProfileEditField(
                            title: NSLocalizedString("Phone", comment: "Field label"),
                            text: $editedPhone,
                            icon: "phone"
                        )
                        .accessibilityHint(NSLocalizedString("Enter your phone number", comment: "Field accessibility hint"))
                    }
                } else {
                    VStack(spacing: 12) {
                        ProfileInfoRow(
                            icon: "person",
                            title: NSLocalizedString("Name", comment: "Field label"),
                            value: patient?.name ?? ""
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(NSLocalizedString("Name: \(patient?.name ?? "")", comment: "Field accessibility label"))
                        
                        ProfileInfoRow(
                            icon: "envelope",
                            title: NSLocalizedString("Email", comment: "Field label"),
                            value: patient?.email ?? ""
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(NSLocalizedString("Email: \(patient?.email ?? "")", comment: "Field accessibility label"))
                        
                        ProfileInfoRow(
                            icon: "phone",
                            title: NSLocalizedString("Phone", comment: "Field label"),
                            value: patient?.phoneNumber ?? ""
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(NSLocalizedString("Phone: \(patient?.phoneNumber ?? "")", comment: "Field accessibility label"))
                        
                        ProfileInfoRow(
                            icon: "calendar",
                            title: NSLocalizedString("Date of Birth", comment: "Field label"),
                            value: formatDate(patient?.birthDate ?? Date())
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(NSLocalizedString("Date of Birth: \(formatDate(patient?.birthDate ?? Date()))", comment: "Field accessibility label"))
                    }
                }
            }
            
            // Address card
            ProfileSectionCard(
                title: NSLocalizedString("Address", comment: "Section title"),
                icon: "house.fill"
            ) {
                if isEditing {
                    VStack(spacing: 12) {
                        ProfileEditField(
                            title: NSLocalizedString("Street", comment: "Field label"),
                            text: $editedStreet,
                            icon: "mappin.and.ellipse"
                        )
                        .accessibilityHint(NSLocalizedString("Enter your street address", comment: "Field accessibility hint"))
                        
                        ProfileEditField(
                            title: NSLocalizedString("City", comment: "Field label"),
                            text: $editedCity,
                            icon: "building.2"
                        )
                        .accessibilityHint(NSLocalizedString("Enter your city", comment: "Field accessibility hint"))
                        
                        ProfileEditField(
                            title: NSLocalizedString("State", comment: "Field label"),
                            text: $editedState,
                            icon: "map"
                        )
                        .accessibilityHint(NSLocalizedString("Enter your state", comment: "Field accessibility hint"))
                        
                        ProfileEditField(
                            title: NSLocalizedString("Zip Code", comment: "Field label"),
                            text: $editedZipCode,
                            icon: "number"
                        )
                        .accessibilityHint(NSLocalizedString("Enter your zip code", comment: "Field accessibility hint"))
                    }
                } else {
                    ProfileInfoRow(
                        icon: "mappin.and.ellipse",
                        title: NSLocalizedString("Address", comment: "Field label"),
                        value: patient?.address.formattedAddress() ?? ""
                    )
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel(NSLocalizedString("Address: \(patient?.address.formattedAddress() ?? "")", comment: "Field accessibility label"))
                }
            }
            
            // Emergency Contact card
            ProfileSectionCard(
                title: NSLocalizedString("Emergency Contact", comment: "Section title"),
                icon: "exclamationmark.shield.fill"
            ) {
                if isEditing {
                    VStack(spacing: 12) {
                        ProfileEditField(
                            title: NSLocalizedString("Name", comment: "Field label"),
                            text: $editedEmergencyName,
                            icon: "person.2"
                        )
                        .accessibilityHint(NSLocalizedString("Enter emergency contact name", comment: "Field accessibility hint"))
                        
                        ProfileEditField(
                            title: NSLocalizedString("Relationship", comment: "Field label"),
                            text: $editedEmergencyRelationship,
                            icon: "person.2.circle"
                        )
                        .accessibilityHint(NSLocalizedString("Enter relationship with emergency contact", comment: "Field accessibility hint"))
                        
                        ProfileEditField(
                            title: NSLocalizedString("Phone", comment: "Field label"),
                            text: $editedEmergencyPhone,
                            icon: "phone.circle"
                        )
                        .accessibilityHint(NSLocalizedString("Enter emergency contact phone number", comment: "Field accessibility hint"))
                    }
                } else {
                    VStack(spacing: 12) {
                        ProfileInfoRow(
                            icon: "person.2",
                            title: NSLocalizedString("Name", comment: "Field label"),
                            value: patient?.emergencyContact.name ?? ""
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(NSLocalizedString("Emergency contact name: \(patient?.emergencyContact.name ?? "")", comment: "Field accessibility label"))
                        
                        ProfileInfoRow(
                            icon: "person.2.circle",
                            title: NSLocalizedString("Relationship", comment: "Field label"),
                            value: patient?.emergencyContact.relationship ?? ""
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(NSLocalizedString("Emergency contact relationship: \(patient?.emergencyContact.relationship ?? "")", comment: "Field accessibility label"))
                        
                        ProfileInfoRow(
                            icon: "phone.circle",
                            title: NSLocalizedString("Phone", comment: "Field label"),
                            value: patient?.emergencyContact.phoneNumber ?? ""
                        )
                        .accessibilityElement(children: .combine)
                        .accessibilityLabel(NSLocalizedString("Emergency contact phone: \(patient?.emergencyContact.phoneNumber ?? "")", comment: "Field accessibility label"))
                    }
                }
            }
        }
    }
    
    // MARK: - Preferences Section
    private var preferencesSection: some View {
        VStack(spacing: 16) {
            // Communication Preferences card
            ProfileSectionCard(
                title: NSLocalizedString("Communication Preferences", comment: "Section title"),
                icon: "bell.fill"
            ) {
                VStack(spacing: 8) {
                    ProfileToggleRow(
                        title: NSLocalizedString("Appointment Reminders", comment: "Preference toggle"),
                        isOn: .constant(patient?.preferences.appointmentReminders ?? true),
                        icon: "calendar.badge.clock"
                    )
                    .accessibilityHint(NSLocalizedString("Toggle to receive appointment reminders", comment: "Toggle accessibility hint"))
                    
                    Divider()
                    
                    ProfileToggleRow(
                        title: NSLocalizedString("Email Notifications", comment: "Preference toggle"),
                        isOn: .constant(patient?.preferences.emailNotifications ?? true),
                        icon: "envelope"
                    )
                    .accessibilityHint(NSLocalizedString("Toggle to receive email notifications", comment: "Toggle accessibility hint"))
                    
                    Divider()
                    
                    ProfileToggleRow(
                        title: NSLocalizedString("SMS Notifications", comment: "Preference toggle"),
                        isOn: .constant(patient?.preferences.smsNotifications ?? true),
                        icon: "message"
                    )
                    .accessibilityHint(NSLocalizedString("Toggle to receive SMS notifications", comment: "Toggle accessibility hint"))
                }
            }
            
            // Appointment Preferences card
            ProfileSectionCard(
                title: NSLocalizedString("Appointment Preferences", comment: "Section title"),
                icon: "clock.fill"
            ) {
                ProfileInfoRow(
                    icon: "clock",
                    title: NSLocalizedString("Preferred Time", comment: "Field label"),
                    value: patient?.preferences.preferredAppointmentTime.rawValue ?? ""
                )
                .accessibilityElement(children: .combine)
                .accessibilityLabel(NSLocalizedString("Preferred appointment time: \(patient?.preferences.preferredAppointmentTime.rawValue ?? "")", comment: "Field accessibility label"))
            }
        }
    }
    
    // MARK: - Edit Controls
    private var editControls: some View {
        HStack(spacing: 16) {
            Button(action: cancelEdit) {
                HStack {
                    Image(systemName: "xmark.circle")
                    Text(NSLocalizedString("Cancel", comment: "Button label"))
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
            .accessibilityLabel(NSLocalizedString("Cancel editing", comment: "Button accessibility label"))
            .accessibilityHint(NSLocalizedString("Tap to discard your changes", comment: "Button accessibility hint"))
            
            Button(action: saveChanges) {
                HStack {
                    Image(systemName: "checkmark.circle")
                    Text(NSLocalizedString("Save", comment: "Button label"))
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
            .accessibilityLabel(NSLocalizedString("Save changes", comment: "Button accessibility label"))
            .accessibilityHint(NSLocalizedString("Tap to save your profile changes", comment: "Button accessibility hint"))
        }
        .padding(.top, 20)
    }
    
    // MARK: - Helper Functions
    private func startEditing() {
        guard let patient = patient else { return }
        
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
        // Future enhancement: Add validation before saving
        showingAlert = true
        alertMessage = NSLocalizedString("Profile information updated successfully", comment: "Success message")
        isEditing = false
    }
    
    private func formatDate(_ date: Date) -> String {
        DateFormatter.mediumDate.string(from: date)
    }
}

#Preview {
    ProfileView()
} 