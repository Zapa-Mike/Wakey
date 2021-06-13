//
//  RingtoneSelectionView.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//

import SwiftUI

struct RingtoneSelectionView: View {
    @EnvironmentObject var viewModel : AlarmViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            List {
                ForEach(Ringtones.ringtone, id: \.title) {ringtone in
                    HStack {
                        Text(ringtone.title).font(.system(size: 25))
                        Spacer()
                        Button(action: {
                            viewModel.alarm.ringtone = ringtone.title
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            Text("")
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Select a Ringtone")
    }
}

struct RingtoneSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RingtoneSelectionView()
            RingtoneSelectionView()
        }
    }
}
