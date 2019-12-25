//
//  TicTacToeAdapter.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/19/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

class TicTacToeAdapter: Game, GameBuildable, TicTacToeListener {
//    func gameDidEnd(withWiner winner: PlayerType?) {
//        <#code#>
//    }
    
    let id = "tictactoe"
    let name = "Tic Tac Toe"
    let ticTacToeBuilder: TicTacToeBuilder
    var builder: GameBuildable {
        return self
    }

    weak var gameListener: GameListener?

    init(dependency: TicTacToeDependency) {
        ticTacToeBuilder = TicTacToeBuilder(dependency: dependency)
    }

    func build(withListener listener: GameListener) -> ViewableRouting {
        gameListener = listener
        return ticTacToeBuilder.build(withListener: self)
    }

    func ticTacToeDidEnd(with winner: PlayerType?) {
        gameListener?.gameDidEnd(with: winner)
    }
}
