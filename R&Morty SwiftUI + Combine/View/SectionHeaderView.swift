//
//  SectionHeaderView.swift
//  R&Morty SwiftUI + Combine
//
//  Created by Anna Delova on 2/20/22.
//

import SwiftUI

struct SectionHeaderView: View {

     let header: String
     let lastUpdateTime: TimeInterval
     let currentDate: Date

    private var relativeTimeString: String {
        RelativeDateTimeFormatter().localizedString(fromTimeInterval: lastUpdateTime - currentDate.timeIntervalSince1970)
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(header)
            Text("Last update \(relativeTimeString)")
                .font(.subheadline)
        }
    }
}

//struct SectionHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        SectionHeaderView()
//    }
//}
