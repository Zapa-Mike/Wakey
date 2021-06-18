//
//  TypingMissionView.swift
//  Wakey
//
//  Created by Student on 06.06.21.
//

import SwiftUI
import AVFoundation

struct TypingMissionView: View {
    @EnvironmentObject var viewModel : QuizViewModel
    @EnvironmentObject var navigateToQuiz : NavigateToQuiz

    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var player: AVAudioPlayer?
    
    func playSound() {
        if viewModel.quizOver {
            self.presentationMode.wrappedValue.dismiss()
            return
        }
        guard let url = Bundle.main.url(forResource: "harshness-full", withExtension: "mp3") else { return }
        
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
        let binding = Binding<String>(get: {
            viewModel.typedText
        }, set: {
            viewModel.typedText = $0
            evaluateText()
        })
        VStack(spacing: 8.0) {
            NavigationLink(destination: WakeupMotivationView(), isActive: $navigateToQuiz.navigateToMotivation, label: {EmptyView()})
            HStack {
                Text("Type 3 excerpts out correctly to dismiss the alarm!").padding(20)
                Text("\(viewModel.correctAnswersCounter) / 3 ").padding(20)
            }
            Spacer()
            Text(viewModel.activeSentence).animation(.easeIn)
            Spacer()
            TextField("Type the text above", text: binding).multilineTextAlignment(.center).padding(20)
        }.onAppear(perform: playSound)
         .navigationTitle("Typing")
         .navigationBarBackButtonHidden(true)
    }
    
    func evaluateText() {
        viewModel.evaluateTypedText()
        if viewModel.quizOver {
            player?.stop()
            if navigateToQuiz.wakeUpWisdom {
                navigateToQuiz.navigateToMotivation = true
            }
            else {
                self.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct TypingMissionView_Previews: PreviewProvider {
    static var previews: some View {
        TypingMissionView()
    }
}
