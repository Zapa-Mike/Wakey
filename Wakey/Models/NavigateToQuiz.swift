//
//  NavigateToQuiz.swift
//  Wakey
//
//  Created by Student on 10.06.21.
//

import Foundation

final class NavigateToQuiz : ObservableObject {
    @Published var navigateToQuiz = false
    @Published var navigateToTyping = false
    @Published var wakeUpWisdom = false
    @Published var ringtone = "harshness.mp3"
    @Published var navigateToMotivation = false
}
