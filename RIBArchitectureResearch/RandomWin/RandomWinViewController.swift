//
//  RandomWinViewController.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/19/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift
import UIKit

protocol RandomWinPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RandomWinViewController: UIViewController, RandomWinPresentable, RandomWinViewControllable {

    weak var listener: RandomWinPresentableListener?
}
