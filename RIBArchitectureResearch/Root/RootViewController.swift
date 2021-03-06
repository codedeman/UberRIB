//
//  RootViewController.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/17/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol RootPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class RootViewController: UIViewController, RootPresentable, RootViewControllable {
    func replaceModal(viewController: ViewControllable?) {
        targetViewController = viewController

        guard !animationInProgress else {
            return
        }

        if presentedViewController != nil {
            animationInProgress = true
            dismiss(animated: true) { [weak self] in
                if self?.targetViewController != nil {
                    self?.presentTargetViewController()
                } else {
                    self?.animationInProgress = false
                }
            }
        } else {
            presentTargetViewController()
        }
    }
    
   private var targetViewController: ViewControllable?
    private var animationInProgress = false

    weak var listener: RootPresentableListener?
    private func presentTargetViewController() {
          if let targetViewController = targetViewController {
              animationInProgress = true
              present(targetViewController.uiviewController, animated: true) { [weak self] in
                  self?.animationInProgress = false
              }
          }
      }
    init() {
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }
    // MARK: -RootViewControllable
    func present(viewController:ViewControllable)  {
        viewController.uiviewController.modalPresentationStyle  = .currentContext
        present(viewController.uiviewController,animated:  true,completion:  nil)
    }
    
    func dismiss(viewController: ViewControllable) {
        
        if presentedViewController === viewController.uiviewController
        {
            dismiss(animated: false, completion: nil)
            
        }
    }
}


extension RootViewController:LoggedInViewControllable{
    
    
    
}
