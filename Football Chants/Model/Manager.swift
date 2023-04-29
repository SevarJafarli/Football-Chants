//
//  Manager.swift
//  Football Chants
//
//  Created by Sevar Jafarli on 28.04.23.
//

import Foundation

enum JobType: String {
    case manager = "Manager"
    case headCoach = "Head coach"
}

struct Manager {
    let name: String
    let job: JobType
}
