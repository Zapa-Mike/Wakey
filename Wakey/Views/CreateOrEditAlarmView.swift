//
//  CreateOrEditAlarmView.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//

import SwiftUI

struct CreateOrEditAlarmView: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        Button(action: {
            self.scheduleAlarm()
        }) {
            Text("Schedule alarm")
        }
    }
    
    func scheduleAlarm() {
        AlarmHandler.scheduleAlarm()
    }
}

struct CreateOrEditAlarmView_Previews: PreviewProvider {
    static var previews: some View {
        CreateOrEditAlarmView()
    }
}
