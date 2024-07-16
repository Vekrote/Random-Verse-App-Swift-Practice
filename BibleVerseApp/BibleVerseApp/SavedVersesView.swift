import SwiftUI

struct SavedVersesView: View {
    @State private var savedVerses: [String] = UserDefaults.standard.stringArray(forKey: "savedVerses") ?? []
    
    var body: some View {
        List {
            ForEach(savedVerses, id: \.self) { verse in
                Text(verse)
                    .padding()
                    .foregroundColor(.white)
            }
            .onDelete(perform: deleteVerse)
        }
        .background(Color.black)
        .navigationTitle("Saved Verses")
        .onAppear {
            loadSavedVerses()
        }
    }
    
    func loadSavedVerses() {
        savedVerses = UserDefaults.standard.stringArray(forKey: "savedVerses") ?? []
    }
    
    func deleteVerse(at offsets: IndexSet) {
        savedVerses.remove(atOffsets: offsets)
        UserDefaults.standard.set(savedVerses, forKey: "savedVerses")
    }
}

struct SavedVersesView_Previews: PreviewProvider {
    static var previews: some View {
        SavedVersesView()
    }
}

