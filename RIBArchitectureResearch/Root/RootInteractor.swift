//
//  RootInteractor.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/17/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift

protocol RootRouting: ViewableRouting {
    func routeToLoggedIn(withPlayer1Name player1Name: String, player2Name: String)
    

    // TODO: Declare methods the interactor can invoke to manage sub-tree via the router.
}

protocol RootPresentable: Presentable {
    var listener: RootPresentableListener? { get set }
    // TODO: Declare methods the interactor can invoke the presenter to present data.
}

protocol RootListener: class {
    // TODO: Declare methods the interactor can invoke to communicate with other RIBs.
}

final class RootInteractor: PresentableInteractor<RootPresentable>, RootInteractable, RootPresentableListener,RootActionableItem,UrlHandler{
    
    
    func waitForLogin() -> Observable<(LoggedInActionableItem, ())> {
        
        return loggedInActionableItemSubject.map { (loggedInItem:LoggedInActionableItem) -> (LoggedInActionableItem, ()) in
            (loggedInItem, ())
        }
        
    }
    
    
    
    func handle(_ url: URL) {
        let launchGameWorkflow = LaunchGameWorkflow(url: url)
        launchGameWorkflow.subscribe(self).disposeOnDeactivate(interactor: self)
    }
    
    
    func didLogin(withPlayer1Name player1Name: String, player2Name: String) {
            
        router?.routeToLoggedIn(withPlayer1Name: player1Name, player2Name: player2Name)
    }
    

    weak var router: RootRouting?
    weak var listener: RootListener?

    // TODO: Add additional dependencies to constructor. Do not perform any logic
    // in constructor.
    override init(presenter: RootPresentable) {
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
    
    private let loggedInActionableItemSubject = ReplaySubject<LoggedInActionableItem>.create(bufferSize: 1)

}
