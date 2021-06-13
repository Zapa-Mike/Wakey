//
//  QuizQuestions.swift
//  Wakey
//
//  Created by Student on 13.06.21.
//

import Foundation

class QuizQuestions {
    static var question: [QuizQuestion] = [
        QuizQuestion(text: "When did world war II end?", options: ["1939", "1928", "1945","1950"], trueOptionIndex: 2, questionType: QuestionType.MCQ),
        QuizQuestion(text: "It is possible for a squared circle to exist", options: ["True", "False"], trueOptionIndex: 1, questionType: QuestionType.TrueFalse),
        QuizQuestion(text: "Which of the following planets is the hottest?", options: ["Mercury", "Earth", "Jupiter", "Venus"], trueOptionIndex: 3, questionType: QuestionType.MCQ),
        QuizQuestion(text: "6 * 12", options: ["50", "72", "78", "62"], trueOptionIndex: 1, questionType: QuestionType.MCQ)
    ]
}
