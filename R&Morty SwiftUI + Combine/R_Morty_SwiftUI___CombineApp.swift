//___FILEHEADER___

import SwiftUI
import UIKit


@main
struct ___PACKAGENAME: App {

    var body: some Scene {
        WindowGroup {
            CharactersView(viewModel: CharacterViewModel(filter: Filter()))
        }
    }
}
