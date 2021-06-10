//
//  AlarmListView.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//

import SwiftUI
struct AlarmListView: View {
    @EnvironmentObject var navigateToQuiz : NavigateToQuiz
    @State var sss : Bool = true
    
    init() {
        self.askForPermission()
    }
    var body: some View {
        NavigationView {
            VStack{
                NavigationLink(destination: QuizMissionView(), isActive: $navigateToQuiz.navigate, label: {EmptyView()})
                List {
                    HStack {
                        Text("8:30").font(.system(size: 23)).padding(10)
                        Toggle("", isOn: $sss).font(.system(size: 23))
                        NavigationLink(destination: CreateOrEditAlarmView()) {
                            EmptyView()
                        }.hidden().frame(width: 0)
                    }
                    HStack {
                        Text("8:30").font(.system(size: 23)).padding(10)
                        Toggle("", isOn: $sss).font(.system(size: 23))
                        NavigationLink(destination: CreateOrEditAlarmView()) {
                            EmptyView()
                        }.hidden().frame(width: 0)
                    }
                    HStack {
                        Text("8:30").font(.system(size: 23)).padding(10)
                        Toggle("", isOn: $sss).font(.system(size: 23))
                        NavigationLink(destination: CreateOrEditAlarmView()) {
                            EmptyView()
                        }.hidden().frame(width: 0)
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
