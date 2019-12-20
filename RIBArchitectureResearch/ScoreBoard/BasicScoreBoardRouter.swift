//
//  BasicScoreBoardRouter.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/20/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

protocol BasicScoreBoardInteractable: Interactable {
    var router: BasicScoreBoardRouting? { get set }
    var listener: BasicScoreBoardListener? { get set }
}

protocol BasicScoreBoardViewControllable: ViewControllable {
    // TODO: Declare methods the router invokes to manipulate the view hierarchy.
}

final class BasicScoreBoardRouter: ViewableRouter<BasicScoreBoardInteractable, BasicScoreBoardViewControllable>, BasicScoreBoardRouting {

    // TODO: Constructor inject child builder protocols to allow building children.
    override init(interactor: BasicScoreBoardInteractable, viewController: BasicScoreBoardViewControllable) {
        super.init(interactor: interactor, viewController: viewController)
        interactor.router = self
    }
}
