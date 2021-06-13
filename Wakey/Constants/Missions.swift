//
//  Missions.swift
//  Wakey
//
//  Created by Student on 13.06.21.
//

import Foundation

class Missions {
   static var mission: [Mission] = [
    Mission(description: "Answer trivia questions to disable the alarm", type: MissionType.quiz),
    Mission(description: "Type some textual excerpts down to disable the alarm", type: MissionType.typing)
   ]
}
