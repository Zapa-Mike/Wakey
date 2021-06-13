//
//  MissionSelectionView.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//

import SwiftUI

struct MissionSelectionView: View {
    @EnvironmentObject var viewModel : AlarmViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        VStack{
            List {
                ForEach(Missions.mission, id: \.type) {mission in
                    HStack {
                        SubtitleView(title: mission.type.rawValue, subtitle: mission.description)
                        Button(action: {
                            viewModel.alarm.mission = mission.type
                            self.presentationMode.wrappedValue.dismiss()
                        }) {
                            
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Select a Mission")
    }
}

struct MissionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        MissionSelectionView()
    }
}
