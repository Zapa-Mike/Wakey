//
//  QuizViewModel.swift
//  Wakey
//
//  Created by Student on 13.06.21.
//

import Foundation

final class QuizViewModel: ObservableObject {
    @Published var correctAnswersCounter = 0
    
    @Published var quizOver = false
    
    @Published var typedText = ""
    
    @Published var activeSentence = Sentences.sentence[0]
    
    @Published var activeQuestion = QuizQuestions.question[0]
    
    @Published var index = 0 {
        didSet {
            activeQuestion = QuizQuestions.question[index]
            activeSentence = Sentences.sentence[index]
        }
    }
    
    func reset() {
        correctAnswersCounter = 0
        quizOver = false
        activeQuestion = QuizQuestions.question[0]
        activeSentence = Sentences.sentence[0]
        index = 0
        
        print("index: ", index)
        print("correctAnsCounter:", correctAnswersCounter)
        print("active Question: ", activeQuestion.text)
    }
    
    func evaluateAnswer(answerIndex: Int) {
        if answerIndex == activeQuestion.trueOptionIndex {
            correctAnswersCounter = correctAnswersCounter + 1
        }
        
        if correctAnswersCounter > 2 {
            quizOver = true //ends the mission and pops to the alarm list
        }
        else {
            nextQuestion()
        }
        
        print("index: ", index)
        print("correctAnsCounter:", correctAnswersCounter)
        print("active Question: ", activeQuestion.text)
    }
    
    func nextQuestion() {
        index = (index + 1) % QuizQuestions.question.count
    }
    
    func evaluateTypedText() {
        if typedText == activeSentence {
            nextExcerpt()
            typedText = ""
            correctAnswersCounter = correctAnswersCounter + 1
            if correctAnswersCounter > 2 {
                quizOver = true
            }
        }
    }
    
    func nextExcerpt() {
        index = (index + 1) % Sentences.sentence.count
    }
}
