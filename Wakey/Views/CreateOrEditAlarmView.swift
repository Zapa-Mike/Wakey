//
//  CreateOrEditAlarmView.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//

import SwiftUI

struct CreateOrEditAlarmView: View {
    @EnvironmentObject var viewModel : AlarmViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack {
            DatePicker("", selection: $viewModel.alarm.scheduledTime, in: Date()...)
                .labelsHidden()
                .datePickerStyle(WheelDatePickerStyle())
            TextField("Your Alarm Name", text: $viewModel.alarm.title).multilineTextAlignment(.center).font(.system(size: 23))
            
            List {
                NavigationLink(destination: MissionSelectionView()) {
                    Text("Mission: \(viewModel.alarm.mission.rawValue)")
                }.font(.system(size: 23)).padding(10)
                NavigationLink(destination: RingtoneSelectionView()) {
                    Text("Ringtone: \(viewModel.alarm.ringtone.title)")
                }.font(.system(size: 23)).padding(10)
                Toggle("Wake up Wisdom", isOn: $viewModel.alarm.wakeUpWisdom).font(.system(size: 23)).padding(10)
            }
            .listStyle(PlainListStyle())
            
            if(viewModel.timeToRing.minute! > 0 || viewModel.timeToRing.hour! > 0 || viewModel.timeToRing.day! > 0) {
                Text("Rings in "
                        + ((viewModel.timeToRing.day! > 0) ? "\(viewModel.timeToRing.day!) day(s) ": "")
                        + ((viewModel.timeToRing.hour! > 0) ? "\(viewModel.timeToRing.hour!) hour(s) ": "")
                        + ((viewModel.timeToRing.minute! > 0) ? "\(viewModel.timeToRing.minute!) minute(s)": "")).frame(maxWidth: .infinity, alignment: .center).font(.system(size: 15))            .padding(.bottom, 10)
            }
        }
        Spacer()
        
        Button(action: {
            DispatchQueue.main.async {
                viewModel.addAlarm()
                self.presentationMode.wrappedValue.dismiss()
            }
        }) {
            Text("Schedule alarm")
        }
        
        .navigationBarTitle("Create Alarm")
    }
}

struct CreateOrEditAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrEditAlarmView()
            .environmentObject(AlarmViewModel())
        
    }
}
