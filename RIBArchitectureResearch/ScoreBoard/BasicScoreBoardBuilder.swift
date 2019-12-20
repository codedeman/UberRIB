//
//  BasicScoreBoardBuilder.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/20/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

protocol BasicScoreBoardDependency: Dependency {
        var player1Name: String { get }
       var player2Name: String { get }
       var scoreStream: ScoreStream { get }
}

final class BasicScoreBoardComponent: Component<BasicScoreBoardDependency> {
    
    fileprivate var player1Name: String {
        return dependency.player1Name
    }

    fileprivate var player2Name: String {
        return dependency.player2Name
    }

    fileprivate var scoreStream: ScoreStream {
        return dependency.scoreStream
    }
}

// MARK: - Builder

protocol BasicScoreBoardBuildable: Buildable {
    func build(withListener listener: BasicScoreBoardListener) -> BasicScoreBoardRouting
}

final class BasicScoreBoardBuilder: Builder<BasicScoreBoardDependency>, BasicScoreBoardBuildable {

    
    override init(dependency: BasicScoreBoardDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: BasicScoreBoardListener) -> BasicScoreBoardRouting {
        let component = BasicScoreBoardComponent(dependency: dependency)
        let viewController = BasicScoreBoardViewController(player1Name: component.player1Name, player2Name: component.player2Name)
        let interactor = BasicScoreBoardInteractor(presenter: viewController, scoreStream: component.scoreStream)
        interactor.listener = listener
        return BasicScoreBoardRouter(interactor: interactor, viewController: viewController)
    }
    
    
}
