//
//  Game.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/19/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

public protocol GameListener: class {
    func gameDidEnd(with winner: PlayerType?)
}

public protocol GameBuildable: Buildable {
    func build(withListener listener: GameListener) -> ViewableRouting
}

public protocol Game {
    var id: String { get }
    var name: String { get }
    var builder: GameBuildable { get }
}
