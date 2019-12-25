//
//  RandomWinBuilder.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/19/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

protocol RandomWinDependency: Dependency {
    
    var player1Name: String { get }
    var player2Name: String { get }
    var mutableScoreStream: MutableScoreStream { get }

}

final class RandomWinComponent: Component<RandomWinDependency> {
    
    fileprivate var player1Name: String {
        return dependency.player1Name
    }

    fileprivate var player2Name: String {
        return dependency.player2Name
    }

    fileprivate var mutableScoreStream: MutableScoreStream {
        return dependency.mutableScoreStream
    }

}

// MARK: - Builder

protocol RandomWinBuildable: Buildable {
    func build(withListener listener: RandomWinListener) -> RandomWinRouting
}

final class RandomWinBuilder: Builder<RandomWinDependency>, RandomWinBuildable {

    override init(dependency: RandomWinDependency) {
        super.init(dependency: dependency)
    }

    func build(withListener listener: RandomWinListener) -> RandomWinRouting {
        let component = RandomWinComponent(dependency: dependency)
        let viewController = RandomWinViewController(player1Name: component.player1Name, player2Name: component.player2Name)
        let interactor = RandomWinInteractor(presenter: viewController, mutableScoreStream: component.mutableScoreStream)
        interactor.listener = listener
        return RandomWinRouter(interactor: interactor, viewController: viewController)
    }
}
