//
//  LoggedOutViewController.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/16/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit
import RxCocoa


protocol LoggedOutPresentableListener: class {
    func login(withPlayer1Name player1Name: String?, player2Name: String?)
}

final class LoggedOutViewController: UIViewController, LoggedOutPresentable, LoggedOutViewControllable {

    weak var listener: LoggedOutPresentableListener?
    

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("Method is not supported")
    }
    
    deinit {
        print("cancel")
    }
       
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        let playerFields = buildPlayerFields()
        buildLoginButton(withPlayer1Field: playerFields.player1Field, player2Field: playerFields.player2Field)
                
    }
    
    private func buildPlayerFields() -> (player1Field: UITextField, player2Field: UITextField) {
        let player1Field = UITextField()
        player1Field.borderStyle = UITextField.BorderStyle.line
        view.addSubview(player1Field)
        player1Field.placeholder = "Player 1 name"
        player1Field.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(self.view).offset(100)
            maker.leading.trailing.equalTo(self.view).inset(40)
            maker.height.equalTo(40)
        }
        
        let player2Field = UITextField()
        player2Field.borderStyle = UITextField.BorderStyle.line
        view.addSubview(player2Field)
        player2Field.placeholder = "Player 2 name"
        player2Field.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player1Field.snp.bottom).offset(20)
            maker.left.right.height.equalTo(player1Field)
        }
        
        return (player1Field, player2Field)
    }
    
    private func buildLoginButton(withPlayer1Field player1Field: UITextField, player2Field: UITextField) {
          let loginButton = UIButton()
          view.addSubview(loginButton)
          loginButton.snp.makeConstraints { (maker: ConstraintMaker) in
              maker.top.equalTo(player2Field.snp.bottom).offset(20)
              maker.left.right.height.equalTo(player1Field)
          }
          loginButton.setTitle("Login", for: .normal)
          loginButton.setTitleColor(UIColor.white, for: .normal)
          loginButton.backgroundColor = UIColor.black
        
            loginButton.rx.tap
                .subscribe(onNext: { [weak self] in
                    self?.listener?.login(withPlayer1Name: player1Field.text, player2Name: player2Field.text)
                })
                .disposed(by: disposeBag)
        
        

      }
    
    private let disposeBag = DisposeBag()


      
}
