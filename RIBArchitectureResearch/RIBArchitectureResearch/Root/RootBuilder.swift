//
//  RootBuilder.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/17/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

protocol RootDependency: Dependency {
    
    
}

final class RootComponent: Component<RootDependency> {
    
    let rootViewController: RootViewController

    init(dependency: RootDependency,
         rootViewController: RootViewController) {
        self.rootViewController = rootViewController
        super.init(dependency: dependency)
    }
    
}

// MARK: - Builder

protocol RootBuildable: Buildable {

    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler)
}

final class RootBuilder: Builder<RootDependency>, RootBuildable {
   
    
    
    override init(dependency: RootDependency) {
        super.init(dependency: dependency)
    }
    
    func build() -> (launchRouter: LaunchRouting, urlHandler: UrlHandler) {
        
        let viewController = RootViewController()
               let component = RootComponent(dependency: dependency,
                                             rootViewController: viewController)
               let interactor = RootInteractor(presenter: viewController)

               let loggedOutBuilder = LoggedOutBuilder(dependency: component)
               let loggedInBuilder = LoggedInBuilder(dependency: component)
               let router = RootRouter(interactor: interactor,
                                       viewController: viewController,
                                       loggedOutBuilder: loggedOutBuilder,
                                       loggedInBuilder: loggedInBuilder)

               return (router, interactor)
           
    }
    
    
//    func build() -> LaunchRouting {
//
//           let viewController = RootViewController()
//           let component = RootComponent(dependency: dependency,
//                                         rootViewController: viewController)
//           let interactor = RootInteractor(presenter: viewController)
//
//           let loggedOutBuilder = LoggedOutBuilder(dependency: component)
//            let loggedInBuilder = LoggedInBuilder(dependency: component)
//
//        return RootRouter(interactor: interactor, viewController: viewController, loggedOutBuilder: loggedOutBuilder, loggedInBuilder: loggedInBuilder)
//
//       }
    
    
    

 
}
