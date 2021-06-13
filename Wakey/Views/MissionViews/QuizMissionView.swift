//
//  QuizMissionView.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//

import SwiftUI
import AVFoundation

struct QuizMissionView: View {
   @EnvironmentObject var viewModel : QuizViewModel
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
   @State var player: AVAudioPlayer?
    
   func playSound() {
        guard let url = Bundle.main.url(forResource: "harshness", withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            
            /* The following line is required for the player to work on iOS 11. Change the file type accordingly*/
            player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
            
            /* iOS 10 and earlier require the following line:
             player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileTypeMPEGLayer3) */
            
            guard let player = player else { return }
            player.numberOfLoops = -1
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    var body: some View {
        VStack(spacing: 8.0) {
            HStack {
                Text("Answer 3 Questions correctly to dismiss the alarm!").padding(20)
                Text("\(viewModel.correctAnswersCounter) / 3 ").padding(20)
            }
            Spacer()
            Text(viewModel.activeQuestion.text)
            Spacer()
            if viewModel.activeQuestion.questionType == QuestionType.TrueFalse {
                HStack{
                    Button(action: {
                        evaluateChoice(answerIndex: 0)
                    }) {
                        Text(viewModel.activeQuestion.options[0])
                    }.padding(15)
                    Spacer()
                    Button(action: {
                        evaluateChoice(answerIndex: 1)
                    }) {
                        Text(viewModel.activeQuestion.options[1])
                    }.padding(15)
                }
            }
            else {
                VStack {
                    HStack{
                        Button(action: {
                            evaluateChoice(answerIndex: 0)
                        }) {
                            Text(viewModel.activeQuestion.options[0])
                        }.padding(15)
                        Spacer()
                        Button(action: {
                            evaluateChoice(answerIndex: 1)
                        }) {
                            Text(viewModel.activeQuestion.options[1])
                        }.padding(15)
                    }
                    HStack{
                        Button(action: {
                            evaluateChoice(answerIndex: 2)
                        }) {
                            Text(viewModel.activeQuestion.options[2])
                        }.padding(15)
                        Spacer()
                        Button(action: {
                          evaluateChoice(answerIndex: 3)
                        }) {
                            Text(viewModel.activeQuestion.options[3])
                        }.padding(15)
                    }
                }
            }
        }.onAppear(perform: playSound)
        .navigationTitle("Quiz")
        .navigationBarBackButtonHidden(true)
    }
    
    func evaluateChoice(answerIndex: Int) {
        viewModel.evaluateAnswer(answerIndex: answerIndex)
        if viewModel.quizOver {
            player?.stop()
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct QuizMissionView_Previews: PreviewProvider {
    static var previews: some View {
        QuizMissionView()
    }
}
