//
//  LoggedOutBuilder.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/16/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

protocol LoggedOutDependency: Dependency {
    // TODO: Declare the set of dependencies required by this RIB, but cannot be
    // created by this RIB.
}

final class LoggedOutComponent: Component<LoggedOutDependency>, LoggedOutDependency {

    // TODO: Declare 'fileprivate' dependencies that are only used by this RIB.
}

// MARK: - Builder

protocol LoggedOutBuildable: Buildable {
    func build(withListener listener: LoggedOutListener) -> LoggedOutRouting
}

final class LoggedOutBuilder: Builder<LoggedOutDependency>, LoggedOutBuildable {

    override init(dependency: LoggedOutDependency) {
        super.init(dependency: dependency)
    }

     func build(withListener listener: LoggedOutListener) -> LoggedOutRouting {
          _ = LoggedOutComponent(dependency: dependency)
          let viewController = LoggedOutViewController()
          let interactor = LoggedOutInteractor(presenter: viewController)
          interactor.listener = listener
          return LoggedOutRouter(interactor: interactor, viewController: viewController)
      }
    
    

}
