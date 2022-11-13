import UIKit
import Foundation

final class ScoreViewController: UIViewController {
    
    private var isFirstLoad = true
    
    private var scores = [Score]()
    
    @IBOutlet weak var firstScoreLabel: UILabel!
    @IBOutlet weak var secondScoreLabel: UILabel!
    @IBOutlet weak var thirdScoreLabel: UILabel!
    
    @IBOutlet weak var firstDateLabel: UILabel!
    @IBOutlet weak var secondDateLabel: UILabel!
    @IBOutlet weak var thirdDateLabel: UILabel!
    
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
        
        if (scores.count >= 1) {
            firstScoreLabel.text = scores[0].makeScore()
            firstDateLabel.text = scores[0].makeDate()
        }
        if (scores.count >= 2) {
            secondScoreLabel.text = scores[1].makeScore()
            secondDateLabel.text = scores[1].makeDate()
        }
        if (scores.count >= 3) {
            thirdScoreLabel.text = scores[2].makeScore()
            thirdDateLabel.text = scores[2].makeDate()
        }

    }
}
