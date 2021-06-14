//
//  AlarmListView.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//


import SwiftUI
struct AlarmListView: View {
    @EnvironmentObject var navigateToQuiz : NavigateToQuiz
    @EnvironmentObject var viewModel : AlarmViewModel
    @EnvironmentObject var quizViewModel : QuizViewModel
    @State var sss : Bool = true
    
    init() {
        self.askForPermission()
    }
    
    var body: some View {
        NavigationView {
            VStack{
                if(viewModel.alarmData.count < 1) {
                    Text("You have no alarms").padding()
                }
                NavigationLink(destination: QuizMissionView(), isActive: $navigateToQuiz.navigateToQuiz, label: {EmptyView()})
                NavigationLink(destination: TypingMissionView(), isActive: $navigateToQuiz.navigateToTyping, label: {EmptyView()})
                List {
                    ForEach(viewModel.alarmData) {alarm in
                        HStack {
                            VStack {
                                Text(alarm.scheduledTime!, style: .time).font(.system(size: 25)).padding(5)
                                Text(alarm.scheduledTime!, style: .date).font(.system(size: 10))
                            }
                            Spacer()
                            if alarm.mission! == MissionType.quiz.rawValue {
                                Image("Square")
                            }
                            else {
                                Image("Keyboard")
                            }
                           // Toggle("", isOn: $sss).font(.system(size: 23))
                            NavigationLink(
                                destination:
                                    CreateOrEditAlarmView(alarmId: alarm.id!)) {
                                EmptyView()
                            }.hidden().frame(width: 0)
                        }
                    }
                    .onDelete(perform: viewModel.deleteAlarm)
            }
            }.onAppear {
                quizViewModel.reset()
            }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Alarm List")
                .navigationBarItems(
                    leading:
                        EditButton()
                    ,
                    trailing:
                        NavigationLink(
                            destination: CreateOrEditAlarmView()) {
                            Image(systemName: "plus")
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
