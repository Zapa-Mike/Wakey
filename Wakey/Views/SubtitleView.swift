//
//  SubtitleView.swift
//  Wakey
//
//  Created by Student on 13.06.21.
//

import SwiftUI

struct SubtitleView: View {
    var title: String
    var subtitle: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title).font(.system(size: 25))
            Text(subtitle).font(.system(size: 10))

        }
    }
}

struct SubtitleView_Previews: PreviewProvider {
    static var previews: some View {
        SubtitleView(title: "sad", subtitle: "harsh")
    }
}
