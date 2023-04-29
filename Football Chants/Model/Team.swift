//
//  Team.swift
//  Football Chants
//
//  Created by Sevar Jafarli on 28.04.23.
//

import Foundation

class Team {
    
    internal init(id: TeamType, name: String, info: String, manager: Manager, founded: String, isPlaying: Bool = false) {
        self.id = id
        self.name = name
        self.info = info
        self.manager = manager
        self.founded = founded
        self.isPlaying = isPlaying
    }
    
    let id: TeamType
    let name: String
    let info: String
    let manager: Manager
    let founded: String
    var isPlaying: Bool
    
}
