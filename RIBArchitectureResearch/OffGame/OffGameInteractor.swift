//
//  OffGameInteractor.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/18/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift

protocol OffGameRouting: ViewableRouting {
}

protocol OffGamePresentable: Presentable {
    var listener: OffGamePresentableListener? { get set }

}

protocol OffGameListener: class {
    func startGame(with gameBuilder: GameBuildable)
}

final class OffGameInteractor: PresentableInteractor<OffGamePresentable>, OffGameInteractable, OffGamePresentableListener {
    
    weak var router: OffGameRouting?

       weak var listener: OffGameListener?
    
    func start(_ game: Game) {
        listener?.startGame(with: game.builder)

    }
    
    
   override init(presenter: OffGamePresentable) {
    super.init(presenter: presenter)
        presenter.listener = self
    }


    override func didBecomeActive() {
        super.didBecomeActive()
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }

    
    func startGame(_ game:Game) {
           
           listener?.startGame(with: game.builder)
       }

    
}
