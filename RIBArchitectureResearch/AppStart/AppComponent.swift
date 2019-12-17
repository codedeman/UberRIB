//
//  AppComponent.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/16/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs

class AppComponent: Component<EmptyDependency>, RootDependency {

    init() {
        super.init(dependency: EmptyComponent())
    }
}
