//
//  Mission.swift
//  Wakey
//
//  Created by Student on 10.06.21.
//

import Foundation

struct Mission {
    var description: String
    var type: MissionType
}

enum MissionType: String {
    case quiz = "Quiz"
    case typing = "Typing"
}

