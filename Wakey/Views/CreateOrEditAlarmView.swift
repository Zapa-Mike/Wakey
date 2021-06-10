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
                TextField("Title:", text: $viewModel.alarm.title)
                DatePicker("harsh", selection: $viewModel.alarm.scheduledTime).padding()
                Button(action: {
                    viewModel.scheduleAlarm()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Schedule alarm")
                }
            }
            .navigationBarTitle("Create Alarm")
    }
    
}

struct CreateOrEditAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrEditAlarmView()
    }
}
