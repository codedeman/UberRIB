//
//  LoggedInInteractor.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/18/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

public enum PlayerType: Int {
    case player1 = 1
    case player2

    var color: UIColor {
        
        switch self {
        case .player1:
            return UIColor.red
        case .player2:
            return UIColor.blue
        }
    }
}


protocol LoggedInRouting: Routing {
    func cleanupViews()
    func routeToOffGame(with games: [Game])
    func routeToGame(with gameBuilder: GameBuildable)
    
}
protocol LoggedInListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class LoggedInInteractor: Interactor,LoggedInInteractable,LoggedInActionableItem{
    
    func startGame(with gameBuilder: GameBuildable) {
        router?.routeToGame(with: gameBuilder)

    }
    
    func gameDidEnd(with winner: PlayerType?) {
        router?.routeToOffGame(with: games)

    }
    
  
    
   
    
    
    
    weak var router: LoggedInRouting?
    weak var listener: LoggedInListener?
    
    
//    init(mutableScoreStream: MutableScoreStream) {
//           self.mutableScoreStream = mutableScoreStream
//    }
    init(games: [Game]) {
          self.games = games
          super.init()
      }


    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    
    
    
    override func didBecomeActive() {
        super.didBecomeActive()
        router?.routeToOffGame(with: games)

    }

    override func willResignActive() {
        super.willResignActive()
        router?.cleanupViews()
    }
    
//    func startTicTacToe() {
//        router?.routeToTicTacToe()
//    }
    
    
    
   
    
    func launchGame(with id: String?) -> Observable<(LoggedInActionableItem, ())> {
        
        let game: Game? = games.first { game in
            return game.id.lowercased() == id?.lowercased()
        }
        
        if let game = game {
            router?.routeToGame(with: game.builder)
        }
        
        return Observable.just((self, ()))
    }
    
    private var games = [Game]()


    
}
