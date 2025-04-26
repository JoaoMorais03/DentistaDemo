# AppDentista Component Structure

This directory contains all reusable UI components organized by functionality.

## Directory Structure

### 1. Common
Components that are used across multiple areas of the app:
- CardStyle - Card styling utilities
- DateComponents - Date and time display components
- DetailRow - Generic row for displaying detail information
- EmptyStateView - Generic empty state component
- PrimaryButton - Primary action button
- DentalTipCard - Card for displaying dental tips

### 2. Layout
Components related to layout and structure:
- ViewContainerStyle - Main container component for views
- SectionHeader - Header for content sections

### 3. Profile
Profile-specific components:
- ProfileHeaderView - Header component for profile information
- ProfileInfoRow - Row component for profile information
- ProfileSectionCard - Card component for profile sections

### 4. Appointments
Appointment-specific components:
- AppointmentCard - Card for displaying upcoming appointments
- AppointmentHistoryCard - Card for displaying past appointments
- AppointmentInfoBar - Information bar for appointment details
- AppointmentDateColumn - Date column for appointment cards
- StatusIndicators - Status indicators for appointments
- AppointmentDetailView - Detail view for appointments
- AppointmentHistoryDetailView - Detail view for past appointments
- BookAppointmentView - View for booking appointments
- RescheduleAppointmentView - View for rescheduling appointments
- CancelAppointmentConfirmation - Confirmation view for canceling appointments

## Usage

Import components from their respective directories as needed:

```swift
import SwiftUI

struct MyView: View {
    var body: some View {
        VStack {
            // Example of using a component
            PrimaryButton(
                title: "Book Appointment",
                icon: "calendar.badge.plus",
                action: bookAppointment
            )
        }
    }
    
    func bookAppointment() {
        // Booking logic
    }
}
``` 