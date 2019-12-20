//
//  BasicScoreBoardBuilder.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/20/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

protocol BasicScoreBoardDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class BasicScoreBoardComponent: Component<BasicScoreBoardDependency> {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
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
        let viewController = BasicScoreBoardViewController()
        let interactor = BasicScoreBoardInteractor(presenter: viewController)
        interactor.listener = listener
        return BasicScoreBoardRouter(interactor: interactor, viewController: viewController)
    }
}
