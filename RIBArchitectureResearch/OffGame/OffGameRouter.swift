//
//  OffGameRouter.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/18/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

protocol OffGameInteractable: Interactable, BasicScoreBoardListener {
    
    var router: OffGameRouting? { get set }
    var listener: OffGameListener? { get set }
    
    
}

protocol OffGameViewControllable: ViewControllable {
    func show(scoreBoardView: ViewControllable)

}

final class OffGameRouter: ViewableRouter<OffGameInteractable, OffGameViewControllable>, OffGameRouting {
    
    private var scoreBoardBuilder: BasicScoreBoardBuildable

        init(interactor: OffGameInteractable,
             viewController: OffGameViewControllable,
             scoreBoardBuilder: BasicScoreBoardBuildable) {
            self.scoreBoardBuilder = scoreBoardBuilder
            super.init(interactor: interactor, viewController: viewController)
            interactor.router = self
        }
    
        override func didLoad() {
            super.didLoad()
            attachScoreBoard()
            
        }
    
        private func attachScoreBoard() {
            let scoreBoard = scoreBoardBuilder.build(withListener: interactor)
            attachChild(scoreBoard)
            viewController.show(scoreBoardView: scoreBoard.viewControllable)
//            viewController
        }

  
}
