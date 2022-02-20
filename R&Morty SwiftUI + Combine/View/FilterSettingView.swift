//
//  FilterSettingView.swift
//  R&Morty SwiftUI + Combine
//
//  Created by Anna Delova on 2/20/22.
//

import SwiftUI

struct FilterSettingView: View {

    @ObservedObject var filter: Filter
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack(alignment: .center, spacing: 5) {
                List {
                    ForEach(Tag.allCases) { tag in
                        Button {
                            self.changeTagState(tag)
                        } label: {
                            HStack {
                                if self.filter.tags.contains(tag) {
                                    Image(systemName: "checkmark.circle.fill")
                                }
                                Text(tag.rawValue.capitalized)
                            }
                        }
                    }
                }
                Button("Done") {
                    self.presentationMode.wrappedValue.dismiss()

                }
                .padding( 50)
            }
        }
    }

    private func changeTagState(_ tag: Tag) {
         filter.tags.contains(tag)
             ? filter.tags.removeAll(where: { $0 == tag })
             : filter.tags.append(tag)
     }
}
