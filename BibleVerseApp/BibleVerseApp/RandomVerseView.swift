import SwiftUI

struct RandomVerseView: View {
    @State private var verse: String = "Fetching a verse..."
    @State private var translation: String = "asv" // Default translation
    @AppStorage("selectedTranslation") private var selectedTranslation = "asv"
    
    var body: some View {
        VStack {
            Text(verse)
                .font(.title)
                .padding()
                .foregroundColor(.white)
            
            Button(action: {
                fetchRandomVerse()
            }) {
                Text("Get Another Verse")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            
            Button(action: {
                saveVerse()
            }) {
                Text("Save Verse")
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .onAppear(perform: fetchRandomVerse)
        .background(Color.black)
        .navigationTitle("Random Verse")
    }
    
    func fetchRandomVerse() {
        let urlString = "https://bible-api.com/?random=verse&translation=\(selectedTranslation)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, let verseData = try? JSONDecoder().decode(VerseData.self, from: data) {
                DispatchQueue.main.async {
                    self.verse = "\(verseData.text) - \(verseData.reference)"
                }
            }
        }.resume()
    }
    
    func saveVerse() {
        var savedVerses = UserDefaults.standard.stringArray(forKey: "savedVerses") ?? []
        savedVerses.append(verse)
        UserDefaults.standard.set(savedVerses, forKey: "savedVerses")
    }
}

struct VerseData: Codable {
    let text: String
    let reference: String
}

struct RandomVerseView_Previews: PreviewProvider {
    static var previews: some View {
        RandomVerseView()
    }
}

