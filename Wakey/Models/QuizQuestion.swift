//
//  QuizQuestion.swift
//  Wakey
//
//  Created by Student on 13.06.21.
//

import Foundation

struct QuizQuestion {
    var text: String
    var options: [String]
    var trueOptionIndex: Int
    var questionType: QuestionType
}

enum QuestionType: String {
    case TrueFalse = "TrueFalse"
    case MCQ = "MCQ"
}
