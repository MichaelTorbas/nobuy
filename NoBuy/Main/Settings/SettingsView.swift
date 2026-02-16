import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var showEditHabits = false
    @State private var showEditPledge = false
    @State private var showEditVision = false
    @State private var showEditTimes = false
    
    var body: some View {
        ZStack {
            NoBuyTheme.background.ignoresSafeArea()
            List {
                Section("Spending & goals") {
                    Button("Edit spending habits & monthly waste") {
                        showEditHabits = true
                    }
                    .foregroundColor(NoBuyTheme.textPrimary)
                    Button("Edit income (for work-hours calculator)") { }
                    .foregroundColor(NoBuyTheme.textPrimary)
                }
                Section("Motivation") {
                    Button("Edit daily pledge") { showEditPledge = true }
                    .foregroundColor(NoBuyTheme.textPrimary)
                    Button("Edit vision / motivation") { showEditVision = true }
                    .foregroundColor(NoBuyTheme.textPrimary)
                }
                Section("Reminders") {
                    Button("Check-in reminder times") { showEditTimes = true }
                    .foregroundColor(NoBuyTheme.textPrimary)
                    Toggle("Daily reminder", isOn: Binding(
                        get: { dataStore.userProfile.notificationsEnabled },
                        set: { newVal in dataStore.updateProfile { $0.notificationsEnabled = newVal } }
                    ))
                    .tint(NoBuyTheme.primary)
                    .foregroundColor(NoBuyTheme.textPrimary)
                    Toggle("Milestone alerts", isOn: .constant(true))
                        .tint(NoBuyTheme.primary)
                        .foregroundColor(NoBuyTheme.textPrimary)
                    Toggle("Weekly summary", isOn: .constant(true))
                        .tint(NoBuyTheme.primary)
                        .foregroundColor(NoBuyTheme.textPrimary)
                }
                Section("Account") {
                    Button("Subscription management") { }
                    .foregroundColor(NoBuyTheme.textPrimary)
                }
                Section("Support") {
                    Link("Terms of Service", destination: URL(string: "https://example.com/terms")!)
                        .foregroundColor(NoBuyTheme.primary)
                    Link("Privacy Policy", destination: URL(string: "https://example.com/privacy")!)
                        .foregroundColor(NoBuyTheme.primary)
                    Button("Support / FAQ") { }
                    .foregroundColor(NoBuyTheme.textPrimary)
                }
                Section("App") {
                    Button("Rate the app") { }
                    .foregroundColor(NoBuyTheme.textPrimary)
                    Button("Share app with a friend") { }
                    .foregroundColor(NoBuyTheme.textPrimary)
                    Button("Delete account", role: .destructive) { }
                }
            }
            .scrollContentBackground(.hidden)
        }
        .sheet(isPresented: $showEditHabits) {
            EditHabitsSheet(profile: Binding(
                get: { dataStore.userProfile },
                set: { dataStore.setProfile($1) }
            ))
        }
        .sheet(isPresented: $showEditPledge) {
            EditPledgeSheet(pledge: Binding(
                get: { dataStore.userProfile.dailyPledge },
                set: { dataStore.updateProfile { $0.dailyPledge = $1 } }
            ))
        }
        .sheet(isPresented: $showEditVision) {
            EditVisionSheet(vision: Binding(
                get: { dataStore.userProfile.visionText },
                set: { dataStore.updateProfile { $0.visionText = $1 } }
            ))
        }
        .sheet(isPresented: $showEditTimes) {
            EditCheckInTimesSheet(profile: Binding(
                get: { dataStore.userProfile },
                set: { dataStore.setProfile($1) }
            ))
        }
    }
}

struct EditHabitsSheet: View {
    @Binding var profile: UserProfile
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Monthly waste estimate") {
                    Slider(value: Binding(
                        get: { Double(profile.monthlyWasteEstimate) },
                        set: { val in
                            var p = profile
                            p.monthlyWasteEstimate = Int(val)
                            profile = p
                        }
                    ), in: 10...500, step: 10)
                    .tint(NoBuyTheme.primary)
                    Text("$\(profile.monthlyWasteEstimate)/month")
                        .foregroundColor(NoBuyTheme.primary)
                }
            }
            .scrollContentBackground(.hidden)
            .background(NoBuyTheme.background)
            .navigationTitle("Spending habits")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .foregroundColor(NoBuyTheme.primary)
                }
            }
        }
    }
}

struct EditPledgeSheet: View {
    @Binding var pledge: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            TextField("Daily pledge", text: $pledge, axis: .vertical)
                .lineLimit(3...6)
                .padding()
                .background(NoBuyTheme.cardBackground)
                .cornerRadius(NoBuyTheme.cardRadius)
                .foregroundColor(NoBuyTheme.textPrimary)
                .padding()
            .background(NoBuyTheme.background)
            .navigationTitle("Daily pledge")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .foregroundColor(NoBuyTheme.primary)
                }
            }
        }
    }
}

struct EditVisionSheet: View {
    @Binding var vision: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            TextField("Vision / motivation", text: $vision, axis: .vertical)
                .lineLimit(4...8)
                .padding()
                .background(NoBuyTheme.cardBackground)
                .cornerRadius(NoBuyTheme.cardRadius)
                .foregroundColor(NoBuyTheme.textPrimary)
                .padding()
            .background(NoBuyTheme.background)
            .navigationTitle("Your vision")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .foregroundColor(NoBuyTheme.primary)
                }
            }
        }
    }
}

struct EditCheckInTimesSheet: View {
    @Binding var profile: UserProfile
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Morning pledge") {
                    DatePicker("Time", selection: $profile.morningCheckInTime, displayedComponents: .hourAndMinute)
                        .tint(NoBuyTheme.primary)
                }
                Section("Evening review") {
                    DatePicker("Time", selection: $profile.eveningCheckInTime, displayedComponents: .hourAndMinute)
                        .tint(NoBuyTheme.primary)
                }
            }
            .scrollContentBackground(.hidden)
            .background(NoBuyTheme.background)
            .navigationTitle("Check-in times")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                        .foregroundColor(NoBuyTheme.primary)
                }
            }
        }
    }
}
