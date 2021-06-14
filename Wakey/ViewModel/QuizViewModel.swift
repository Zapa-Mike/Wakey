//
//  QuizViewModel.swift
//  Wakey
//
//  Created by Student on 13.06.21.
//

import Foundation

final class QuizViewModel: ObservableObject {
    let context = AppDelegate().persistentContainer.viewContext

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
    
    @Published var alarmData: [AlarmEntity] = []
    
    init() {
        self.loadCoreData()
    }
    
    func loadCoreData() {
        do {
            alarmData = try context.fetch(AlarmEntity.fetchRequest())
        }
        catch {
            fatalError("could not load data")
        }
    }
    
    func reset() {
        correctAnswersCounter = 0
        quizOver = false
        activeQuestion = QuizQuestions.question[0]
        index = 0
    }
    
    func evaluateAnswer(answerIndex: Int) {
        if answerIndex == activeQuestion.trueOptionIndex {
            correctAnswersCounter += 1
            if correctAnswersCounter > 2 {
                quizOver = true
            }
        }
        if index == QuizQuestions.question.count - 1 {
            index = 0
        }
        else {
            index += 1
        }
    }
    
    func evaluateTypedText() {
        if typedText == activeSentence {
            index += 1
            typedText = ""
            correctAnswersCounter += 1
            if correctAnswersCounter > 2 {
                quizOver = true
            }
        }
        if index == Sentences.sentence.count - 1 {
            index = 0
        }
    }
}
