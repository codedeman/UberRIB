//
//  BasicScoreBoardViewController.swift
//  RIBArchitectureResearch
//
//  Created by KIENPT6 on 12/20/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import RIBs
import RxSwift
import UIKit
import SnapKit

protocol BasicScoreBoardPresentableListener: class {
    // TODO: Declare properties and methods that the view controller can invoke to perform
    // business logic, such as signIn(). This protocol is implemented by the corresponding
    // interactor class.
}

final class BasicScoreBoardViewController: UIViewController, BasicScoreBoardPresentable, BasicScoreBoardViewControllable {
    
    
    
    
    weak var listener: BasicScoreBoardPresentableListener?
    private var player1Name: String = ""
    private var player2Name: String = ""
    private var player1Label: UILabel?
    private var player2Label: UILabel?
    private var score: Score?
    
    
    init(player1Name: String,
         player2Name: String) {
        self.player1Name = player1Name
        self.player2Name = player2Name
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.clear
        buildPlayerLabels()
    }

    private func buildPlayerLabels() {
        let labelBuilder: (UIColor) -> UILabel = { (color: UIColor) in
            let label = UILabel()
            label.font = UIFont.boldSystemFont(ofSize: 35)
            label.backgroundColor = UIColor.clear
            label.textColor = color
            label.textAlignment = .center
            return label
        }

        let player1Label = labelBuilder(PlayerType.player1.color)
        self.player1Label = player1Label
        view.addSubview(player1Label)
        player1Label.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.leading.trailing.equalTo(self.view)
            maker.height.equalTo(40)
        }

        let vsLabel = UILabel()
        vsLabel.font = UIFont.systemFont(ofSize: 25)
        vsLabel.backgroundColor = UIColor.clear
        vsLabel.textColor = UIColor.darkGray
        vsLabel.textAlignment = .center
        vsLabel.text = "vs"
        view.addSubview(vsLabel)
        vsLabel.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(player1Label.snp.bottom).offset(10)
            maker.leading.trailing.equalTo(player1Label)
            maker.height.equalTo(20)
        }

        let player2Label = labelBuilder(PlayerType.player2.color)
        self.player2Label = player2Label
        view.addSubview(player2Label)
        player2Label.snp.makeConstraints { (maker: ConstraintMaker) in
            maker.top.equalTo(vsLabel.snp.bottom).offset(10)
            maker.height.leading.trailing.equalTo(player1Label)
        }

        updatePlayerLabels()
    }
    func set(score: Score) {
        self.score = score
    }
    private func updatePlayerLabels() {
        let player1Score = score?.player1Score ?? 0
        player1Label?.text = "\(player1Name) (\(player1Score))"

        let player2Score = score?.player2Score ?? 0
        player2Label?.text = "\(player2Name) (\(player2Score))"
    }
    

}
