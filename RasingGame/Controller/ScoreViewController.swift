import UIKit
import Foundation

final class ScoreViewController: UIViewController {
    
    private var isFirstLoad = true
    
    private var firstScore: Int = 0
    private var secondScore: Int = 0
    private var thirdScore: Int = 0
    
    private var scores = [Int]()
    
    @IBOutlet private weak var firstScoreLabel: UILabel!
    @IBOutlet private weak var secondScoreLabel: UILabel!
    @IBOutlet private weak var thirdScoreLabel: UILabel!
    
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
        scores = ScoreService.shared.getScores()
        
        firstScore = scores[0]
        secondScore = scores[1]
        thirdScore = scores[2]
        
        firstScoreLabel.text = firstScore.makeScore()
        secondScoreLabel.text = secondScore.makeScore()
        thirdScoreLabel.text = thirdScore.makeScore()
    }
}
