//
//  BasicScoreBoardInteractor.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/20/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift
import SnapKit

protocol BasicScoreBoardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol BasicScoreBoardPresentable: Presentable {
    var listener: BasicScoreBoardPresentableListener? { get set }
    func set(score: Score)

}

protocol BasicScoreBoardListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class BasicScoreBoardInteractor: PresentableInteractor<BasicScoreBoardPresentable>, BasicScoreBoardInteractable, BasicScoreBoardPresentableListener {
      
        
        private var score: Score?
        
        private var player1Label: UILabel?
        private var player2Label: UILabel?
        private let scoreStream: ScoreStream
        weak var router: BasicScoreBoardRouting?
    weak var listener: BasicScoreBoardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    
     init(presenter: BasicScoreBoardPresentable,
          scoreStream: ScoreStream) {
         self.scoreStream = scoreStream
         super.init(presenter: presenter)
         presenter.listener = self
     }
    override func didBecomeActive() {
        super.didBecomeActive()
        updateScore()
    }
    private func updateScore() {
        scoreStream.score
            .subscribe(onNext: { (score: Score) in
                self.presenter.set(score: score)
            })
            .disposeOnDeactivate(interactor: self)
    }
    
    

    override func willResignActive() {
        super.willResignActive()
        // TODO: Pause any business logic.
    }
}
