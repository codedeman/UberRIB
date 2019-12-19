//
//  LoggedInRouter.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/18/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

protocol LoggedInInteractable: Interactable, OffGameListener, TicTacToeListener {
    var router: LoggedInRouting? { get set }
    var listener: LoggedInListener? { get set }
}

protocol LoggedInViewControllable: ViewControllable {
    func present(viewController: ViewControllable)
    func dismiss(viewController: ViewControllable)
}

final class LoggedInRouter: Router<LoggedInInteractable>, LoggedInRouting  {
  
        init(interactor: LoggedInInteractable,
         viewController: LoggedInViewControllable,
         offGameBuilder: OffGameBuildable,
         ticTacToeBuilder: TicTacToeBuildable) {
        
        self.viewController = viewController
        self.offGameBuilder = offGameBuilder
        self.ticTacToeBuilder = ticTacToeBuilder
        super.init(interactor: interactor)
        interactor.router = self
    }
    
    override func didLoad() {
        super.didLoad()
        attachOffGame()
    }
  
    
        func routeToTicTacToe() {
            detachCurrentChild()
            let ticTacToe = ticTacToeBuilder.build(withListener: interactor)
            currentChild = ticTacToe
            attachChild(ticTacToe)
            viewController.present(viewController: ticTacToe.viewControllable)
        }
        
        
        func cleanupViews() {
            if let currentChild = currentChild {
                viewController.dismiss(viewController: currentChild.viewControllable)
            }
            
        }
        
        func routeToOffGame() {
            
            detachCurrentChild()
            attachOffGame()
        }
    
   
    
    // MARK: - Private

    private let viewController: LoggedInViewControllable
    private let offGameBuilder: OffGameBuildable
    private var ticTacToeBuilder:TicTacToeBuildable
    private var currentChild: ViewableRouting?

    
   
    private func attachOffGame(){
        
        let offGame = offGameBuilder.build(withListener: interactor)
        self.currentChild = offGame
        attachChild(offGame)
        viewController.present(viewController:offGame.viewControllable)
    }
    
    private func detachCurrentChild() {
           if let currentChild = currentChild {
               detachChild(currentChild)
               viewController.dismiss(viewController: currentChild.viewControllable)
           }
       }
       


}
