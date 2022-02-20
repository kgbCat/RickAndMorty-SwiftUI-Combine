//
//  Filter.swift
//  R&Morty SwiftUI + Combine
//
//  Created by Anna Delova on 2/20/22.
//

import Foundation

enum Tag: String, CaseIterable, Identifiable {
    case alive, dead, male, female, genderless

    var id: String {
        return self.rawValue
    }
}

final class Filter: ObservableObject {

    @Published var tags: [Tag] = []

}
