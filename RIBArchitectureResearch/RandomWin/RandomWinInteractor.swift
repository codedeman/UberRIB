//
//  RandomWinInteractor.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/19/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift

protocol RandomWinRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RandomWinPresentable: Presentable {
    var listener: RandomWinPresentableListener? { get set }
    func announce(winner: PlayerType, withCompletionHandler handler: @escaping () -> ())

}

protocol RandomWinListener: class {
    func didRandomlyWin(with player: PlayerType)

}

final class RandomWinInteractor: PresentableInteractor<RandomWinPresentable>, RandomWinInteractable, RandomWinPresentableListener {
    
    

    weak var router: RandomWinRouting?
    weak var listener: RandomWinListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
   init(presenter: RandomWinPresentable,
         mutableScoreStream: MutableScoreStream) {
        self.mutableScoreStream = mutableScoreStream
        super.init(presenter: presenter)
        presenter.listener = self
    }

    override func didBecomeActive() {
        super.didBecomeActive()
        // TODO: Implement business logic here.
    }

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
    
    func determineWinner() {
        
        let random = arc4random_uniform(100)
        let winner = random > 50 ? PlayerType.player1 : PlayerType.player2
        presenter.announce(winner: winner) {
            self.mutableScoreStream.updateScore(with: winner)
            self.listener?.didRandomlyWin(with: winner)
        }
    }
    private let mutableScoreStream: MutableScoreStream

}
