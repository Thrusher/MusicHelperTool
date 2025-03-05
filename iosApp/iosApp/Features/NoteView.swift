import SwiftUI
import Shared

struct Note {
    let natural: String
    let flatEquivalent: String?
    
    init(natural: String, flatEquivalent: String? = nil) {
        self.natural = natural
        self.flatEquivalent = flatEquivalent
    }

    var allNames: [String] {
        [natural, flatEquivalent].compactMap { $0 }
    }
}

class NoteViewModelSwift: ObservableObject {

    
    private let notes: [Note] = [
        Note(natural: "A"),
        Note(natural: "A#", flatEquivalent: "bB"),
        Note(natural: "B"),
        Note(natural: "C"),
        Note(natural: "C#", flatEquivalent: "bD"),
        Note(natural: "D"),
        Note(natural: "D#", flatEquivalent: "bE"),
        Note(natural: "E"),
        Note(natural: "F"),
        Note(natural: "F#", flatEquivalent: "bG"),
        Note(natural: "G"),
        Note(natural: "G#", flatEquivalent: "bA")
    ]
    
    enum NoteAnnotationStyle: Int, CaseIterable {
        case all = 0
        case hash
        case bemol
        
        var description: String {
            switch self {
            case .hash:
                return "#"
            case .bemol:
                return "b"
            case .all:
                return "# / b"
            }
        }
    }
    
    @Published var selectedAnnotationStyle: NoteAnnotationStyle = .all
    @Published var selectedNoteName: String?
    
    func randomiseNote() {
        switch selectedAnnotationStyle {
        case .all:
            selectedNoteName = notes.flatMap { $0.allNames }.randomElement()
        case .hash:
            selectedNoteName = notes.randomElement()?.natural
        case .bemol:
            let randomNote = notes.randomElement()
            selectedNoteName = randomNote?.flatEquivalent ?? randomNote?.natural
        }
    }
}

struct NoteView: View {
        
    @StateObject var viewModel = NoteViewModelSwift()

    var body: some View {
        VStack(spacing: 30) {
            Text(viewModel.selectedNoteName ?? "")
                .fontWeight(.bold)
                .font(.system(size: 72, weight: .bold, design: .default))
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            
            VStack {
                Picker("", selection: $viewModel.selectedAnnotationStyle) {
                    ForEach(NoteViewModelSwift.NoteAnnotationStyle.allCases, id: \.self.rawValue) {
                        Text($0.description).tag($0)
                    }
                }
                .pickerStyle(.segmented)
                
                Button("Randomize Note") {
                    viewModel.randomiseNote()
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .tint(.white)
                .padding(10)
                .background(.blue)
                .cornerRadius(12)
            }
        }
        .padding(8)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView()
    }
}
