# Component Structure Update Guide

This guide explains the new component organization structure that has been implemented. The components have been reorganized for better maintainability and clarity.

## New Structure

Components are now organized into the following categories:

- `Components/Common/` - General-purpose components used throughout the app
- `Components/Layout/` - Layout and structural components
- `Components/Profile/` - Profile-specific components
- `Components/Appointments/` - Appointment-specific components

## What Changed

1. Components previously located in `Views/Components/` have been moved to their appropriate categories in the `Components/` directory
2. SharedComponents.swift has been split into smaller, more focused component files
3. The old `Views/Components/` directory has been removed

## Import Structure

Since the components remain in the same app target, no import changes are necessary in your view files. Swift will automatically find the components in their new locations.

If you're creating new views, you can continue to import just SwiftUI:

```swift
import SwiftUI

struct MyNewView: View {
    var body: some View {
        // Use components as before
        EmptyStateView(
            icon: "doc.text.magnifyingglass",
            title: "No data",
            message: "There is no data to display",
            iconColor: ColorTheme.secondary
        )
    }
}
```

## Future Considerations

If you want more modularity in the future, you could:

1. Create a Swift Package for your components
2. Define modules for each category (Common, Layout, etc.)
3. Update imports to use the new modules

```swift
import SwiftUI
import AppDentistaComponents.Common
import AppDentistaComponents.Layout

struct AppointmentHistoryView: View {
    // View implementation...
}
```

## Component Documentation

See the `Components/README.md` file for full documentation on all available components and their purpose. 