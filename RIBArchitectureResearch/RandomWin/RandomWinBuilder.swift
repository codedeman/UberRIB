//
//  RandomWinBuilder.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/19/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

protocol RandomWinDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class RandomWinComponent: Component<RandomWinDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
        let viewController = RandomWinViewController()
        let interactor = RandomWinInteractor(presenter: viewController)
        interactor.listener = listener
        return RandomWinRouter(interactor: interactor, viewController: viewController)
    }
}
