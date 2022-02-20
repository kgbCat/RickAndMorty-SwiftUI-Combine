//
//  CharacterView.swift
//  R&Morty SwiftUI + Combine
//
//  Created by Anna Delova on 2/20/22.
//

import SwiftUI
import Kingfisher

struct CharacterView: View {

    var character: Character
    
    var body: some View {
        VStack {
            KFImage(
                URL(string: character.image))
                .resizable()
            Text(character.name)
            Text(character.gender)
            Text(character.status)
            Spacer()
        }
    }
}

