import SwiftUI

// MARK: - Section Components
struct SectionHeader: View {
    let title: String
    var showDivider: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if showDivider {
                Divider()
            }
        }
    }
} 