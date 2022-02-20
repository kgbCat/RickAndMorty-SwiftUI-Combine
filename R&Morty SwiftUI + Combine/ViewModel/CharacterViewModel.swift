//
//  CharacterViewModel.swift
//  R&Morty SwiftUI + Combine
//
//  Created by Anna Delova on 2/20/22.
//

import SwiftUI
import Combine

final class CharacterViewModel: ObservableObject {

    @Published private var allCharacters: [Character] = []
    @Published var error: NetworkingError?
    @Published var lastUpdaeTme: TimeInterval = Date().timeIntervalSince1970

    private var apiClient = ApiClient()
    private var currentPage: Int = 0
    private var subscriptions = Set<AnyCancellable>()

    @ObservedObject var filter: Filter
    init( filter: Filter) {
        self.filter = filter
    }

    var characters: [Character] {
        guard !filter.tags.isEmpty else { return allCharacters }

        return allCharacters
            .filter { character in
                filter.tags.reduce(false) { ( isMatch, tag ) -> Bool in
                    self.checkMatching(character: character, for: tag)
                }
            }
    }

    private func checkMatching(character: Character, for tag: Tag) -> Bool {
        switch tag {
        case.alive, .dead:
            return character.status.lowercased() == tag.rawValue.lowercased()
        case .female, .male, .genderless:
            return character.gender.lowercased() == tag.rawValue.lowercased()
        }
    }
    func fetchCharacters() {
        apiClient.page(num: currentPage + 1)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self  = self else { return }
                if case let .failure(error) = completion {
                    self.error = error
                }
            } receiveValue: { [weak self] page in
                guard let self  = self else { return }
                self.lastUpdaeTme = Date().timeIntervalSince1970
                self.error = nil
                self.currentPage += 1
                self.allCharacters.append(contentsOf: page.results)
            }
            .store(in: &subscriptions)
    }
}
