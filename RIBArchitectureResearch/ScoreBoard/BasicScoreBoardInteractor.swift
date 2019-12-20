//
//  BasicScoreBoardInteractor.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/20/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift

protocol BasicScoreBoardRouting: ViewableRouting {
    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol BasicScoreBoardPresentable: Presentable {
    var listener: BasicScoreBoardPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol BasicScoreBoardListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class BasicScoreBoardInteractor: PresentableInteractor<BasicScoreBoardPresentable>, BasicScoreBoardInteractable, BasicScoreBoardPresentableListener {

    weak var router: BasicScoreBoardRouting?
    weak var listener: BasicScoreBoardListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: BasicScoreBoardPresentable) {
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
}
