//
//  ScoreViewController.swift
//  RasingGame
//
//  Created by admin on 26/10/2022.
//

import UIKit

class ScoreViewController: UIViewController {

    private var isFirstLoad = true
    
    private lazy var firstScore = 100500
    private lazy var secondScore = 1337
    private lazy var thirdScore = 228
    
    @IBOutlet weak var firstScoreLabel: UILabel!
    @IBOutlet weak var secondScoreLabel: UILabel!
    @IBOutlet weak var thirdScoreLabel: UILabel!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if isFirstLoad {
            initView()
            isFirstLoad = false
        }
    }
    
    private func initView() {
        updateScores()
    }
    
    private func updateScores() {
        firstScoreLabel.text = firstScore.makeScore()
        secondScoreLabel.text = secondScore.makeScore()
        thirdScoreLabel.text = thirdScore.makeScore()
    }
    
    
}
