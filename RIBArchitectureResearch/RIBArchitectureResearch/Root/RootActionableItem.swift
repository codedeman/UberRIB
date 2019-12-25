//
//  RootActionableItem.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/19/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RxSwift

public protocol RootActionableItem: class {
    func waitForLogin() -> Observable<(LoggedInActionableItem,())>
}
