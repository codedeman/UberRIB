//
//  LoggedInBuilder.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/18/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

protocol LoggedInDependency: Dependency {
    var loggedInViewController:LoggedInViewControllable {get}
}

final class LoggedInComponent: Component<LoggedInDependency> {
    
    fileprivate var loggedInViewController:LoggedInViewControllable{
        return dependency.loggedInViewController
    }
    
    var mutableScoreStream: MutableScoreStream {
           return shared { ScoreStreamImpl() }
    }
    fileprivate var games: [Game] {
        return shared {
            
            return [RandomWinAdapter(dependency: self), TicTacToeAdapter(dependency: self)]
        }
    }

    
    var player1Name: String = ""
    var player2Name: String = ""
    
    
    init(dependency: LoggedInDependency, player1Name: String, player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(dependency: dependency)
    }

}



// MARK: - Builder

protocol LoggedInBuildable: Buildable {
    func build(withListener listener: LoggedInListener, player1Name: String, player2Name: String) -> (router: LoggedInRouting, actionableItem: LoggedInActionableItem)
}

final class LoggedInBuilder: Builder<LoggedInDependency>, LoggedInBuildable {
    
    func build(withListener listener: LoggedInListener, player1Name: String, player2Name: String) -> (router: LoggedInRouting, actionableItem: LoggedInActionableItem) {
        let component = LoggedInComponent(dependency: dependency,
                                          player1Name: player1Name,
                                          player2Name: player2Name)
//        let interactor = LoggedInInteractor(games: component.games)

//        let interactor = LoggedInInteractor(games: component.games)
        let interactor = LoggedInInteractor(games: component.games)
        interactor.listener = listener
        
        let offGameBuilder = OffGameBuilder(dependency: component)
         let router = LoggedInRouter(interactor: interactor,
                                           viewController: component.loggedInViewController,
                                           offGameBuilder: offGameBuilder)
        return (router, interactor)
    }
    
  
    

    override init(dependency: LoggedInDependency) {
        super.init(dependency: dependency)
    }

//    func build(withListener listener: LoggedInListener, player1Name:String,player2Name:String) -> LoggedInRouting {
//
//        let component = LoggedInComponent(dependency: dependency, player1Name: player1Name, player2Name: player2Name)
//        let interactor = LoggedInInteractor(mutableScoreStream: component.mutableScoreStream)
//        interactor.listener  = listener
//
//        let offGameBuilder = OffGameBuilder(dependency: component)
//        let ticTacToeBuilder = TicTacToeBuilder(dependency: component)
//
//        return LoggedInRouter(interactor: interactor,
//                              viewController: component.loggedInViewController,
//                              offGameBuilder: offGameBuilder,
//                              ticTacToeBuilder: ticTacToeBuilder)
//    }
}
