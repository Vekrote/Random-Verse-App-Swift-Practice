import SwiftUI

struct SettingsView: View {
    @AppStorage("selectedTranslation") private var selectedTranslation = "asv"
    
    let translations = ["asv", "bbe", "kjv", "web", "ylt", "dra"]
    
    var body: some View {
        Form {
            Section(header: Text("Translation")) {
                Picker("Translation", selection: $selectedTranslation) {
                    ForEach(translations, id: \.self) { translation in
                        Text(translation.uppercased()).tag(translation)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}

