//
//  AlarmListView.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//

import SwiftUI

struct AlarmListView: View {
    init() {
        self.askForPermission()
    }
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: CreateOrEditAlarmView()) {
                    Text("8:30")
                }
                NavigationLink(destination: CreateOrEditAlarmView()) {
                    Text("8:30")
                }
                NavigationLink(destination: CreateOrEditAlarmView()) {
                    Text("9:30")
                }
                NavigationLink(destination: CreateOrEditAlarmView()) {
                    Text("10:30")
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("Alarm List")
            .navigationBarItems(
                leading:
                        NavigationLink(
                            destination: SettingsView()) {
                                        Text("Settings")
                                    }
                ,
                trailing:
                        NavigationLink(
                            destination: CreateOrEditAlarmView()) {
                                        Text("Create")
                                    }
            )
            
        }
    }
    func askForPermission() {
        AlarmHandler.registerPermission()
    }
}

struct AlarmListView_Previews: PreviewProvider {
    static var previews: some View {
        AlarmListView()
    }
}
