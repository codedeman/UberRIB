//
//  LoggedInInteractor.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/18/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift

enum PlayerType: Int {
    case player1 = 1
    case player2
}

protocol LoggedInRouting: Routing {
    func cleanupViews()
    func routeToTicTacToe()
    func routeToOffGame()
}
protocol LoggedInListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor,LoggedInInteractable{
    
    
    func gameDidEnd(withWiner winner: PlayerType?) {
        
        if let winner = winner {
                   mutableScoreStream.updateScore(withWinner: winner)
               }
               router?.routeToOffGame()
    }
    
    
    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?
    
    
    init(mutableScoreStream: MutableScoreStream) {
           self.mutableScoreStream = mutableScoreStream
    }


    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    
    
    
    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        router?.routeToOffGame()
    }
    
    func startTicTacToe() {
        router?.routeToTicTacToe()
    }
    
    private let mutableScoreStream: MutableScoreStream

    
}
