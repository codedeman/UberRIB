//
//  OffGameViewController.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/18/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol OffGamePresentableListener: class {
    func start(_ game: Game)
}

final class OffGameViewController: UIViewController, OffGamePresentable, OffGameViewControllable {
    
    private let games: [Game]

    private var score: Score?
    weak var listener: OffGamePresentableListener?
    private let disposeBag = DisposeBag()


    func show(scoreBoardView: ViewControllable) {
        addChild(scoreBoardView.uiviewController)
        view.addSubview(scoreBoardView.uiviewController.view)
        
        scoreBoardView.uiviewController.view.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(70)
            maker.leading.trailing.equalTo(self.view).inset(20)
            maker.height.equalTo(120)
        }
        
    }
    

    var uiviewController: UIViewController{
        
        return self
    }

    
    init(games: [Game]) {
        self.games = games
        super.init(nibName: nil, bundle: nil)
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.yellow
        buildStartButtons()

    }
    
    func set(score: Score) {
        self.score = score
           
       }
    
    // MARK: - Private

    
    
    private func buildStartButtons() {
        var previousButton: UIView?
        for game in games {
            previousButton = buildStartButton(with: game, previousButton: previousButton)
        }
    }
    
    
     private func buildStartButton(with game: Game, previousButton: UIView?) -> UIButton {
           let startButton = UIButton()
           view.addSubview(startButton)
           startButton.accessibilityIdentifier = game.name
           startButton.snp.makeConstraints { (maker: ConstraintMaker) in
               if let previousButton = previousButton {
                   maker.bottom.equalTo(previousButton.snp.top).offset(-20)
               } else {
                   maker.bottom.equalTo(self.view.snp.bottom).inset(30)
               }
               maker.leading.trailing.equalTo(self.view).inset(40)
               maker.height.equalTo(50)
           }
           startButton.setTitle(game.name, for: .normal)
           startButton.setTitleColor(UIColor.white, for: .normal)
           startButton.backgroundColor = UIColor.black
           startButton.rx.tap
               .subscribe(onNext: { [weak self] in
                   self?.listener?.start(game)
               })
               .disposed(by: disposeBag)

           return startButton
       }
    
 
    
   
    
    
    
}

extension PlayerType {

//    var color: UIColor {
//        switch self {
//        case .player1:
//            return UIColor.red
//        case .player2:
//            return UIColor.blue
//        }
//    }
}

