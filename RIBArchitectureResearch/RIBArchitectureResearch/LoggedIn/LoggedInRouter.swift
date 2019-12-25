//
//  LoggedInRouter.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/18/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs


protocol LoggedInInteractable: Interactable, OffGameListener, GameListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
        func replaceModal(viewController: ViewControllable?)

}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting  {
 
    func routeToGame(with gameBuilder: GameBuildable) {
        detachCurrentChild()

        let game = gameBuilder.build(withListener: interactor)
        self.currentChild = game
        attachChild(game)
        viewController.replaceModal(viewController: game.viewControllable)
    }
    
    
  
        init(interactor: LoggedInInteractable,
             viewController: LoggedInViewControllable,
             offGameBuilder: OffGameBuildable) {
            self.viewController = viewController
            self.offGameBuilder = offGameBuilder
            super.init(interactor: interactor)
            interactor.router = self
        }
    
        func cleanupViews() {
            if let currentChild = currentChild {
                viewController.replaceModal(viewController: nil)
            }
        }
        
        func routeToOffGame(with games: [Game]) {
            detachCurrentChild()
            attachOffGame(with: games)
            
        }
    
    
    
    // MARK: - Private

    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuildable
    private var currentChild: ViewableRouting?

    
   
    private func attachOffGame(with games: [Game]) {
        let offGame = offGameBuilder.build(withListener: interactor, games: games)
        self.currentChild = offGame
        attachChild(offGame)
        viewController.replaceModal(viewController: offGame.viewControllable)
    }
    
    private func detachCurrentChild() {
           if let currentChild = currentChild {
               detachChild(currentChild)
            viewController.replaceModal(viewController: nil)

           }
       }
       


}
