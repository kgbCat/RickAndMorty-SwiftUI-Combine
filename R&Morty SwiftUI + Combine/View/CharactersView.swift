//
//  CharactersView.swift
//  R&Morty SwiftUI + Combine
//
//  Created by Anna Delova on 2/20/22.
//

import SwiftUI

struct CharactersView: View {

    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var filterSettingsIsPresented: Bool = false
    @State var currentDate = Date()

    @ObservedObject var viewModel: CharacterViewModel
    init(viewModel: CharacterViewModel) {
        self.viewModel = viewModel
    }

    private var filterName: String {
        guard !viewModel.filter.tags.isEmpty else { return "All characters" }

        return "Filtered characters"
    }

    private let timer = Timer.publish(every: 10, on: .main, in: .common)
       .autoconnect()
       .eraseToAnyPublisher()

    var body: some View {
        NavigationView {
            List {
                Section(header: SectionHeaderView(header: filterName, lastUpdateTime: viewModel.lastUpdaeTme, currentDate: self.currentDate)) {
                    ForEach(self.viewModel.characters) { character in
                        CharacterView(character: character)
                    }
                    //timer
                    .onReceive(timer) {
                        self.currentDate = $0
                    }
                }
                .padding(2)
            }
            .onAppear(perform: {
                viewModel.fetchCharacters()

            })
            // filter menu
            .sheet(isPresented: self.$filterSettingsIsPresented, content: {
                FilterSettingView(filter: viewModel.filter)
            })
            // error alert
            .alert(item: self.$viewModel.error) { error in
               Alert(title: Text("Network error"),
                     message: Text(error.localizedDescription),
                     dismissButton: .cancel())
            }

            .navigationBarTitle(Text("Characters"))
            .navigationBarItems(trailing:
                                    Button("Filter") {
                self.filterSettingsIsPresented.toggle()
            }
            .foregroundColor(self.colorScheme == .light ? .blue : .orange)
            )
        }
    }
}
