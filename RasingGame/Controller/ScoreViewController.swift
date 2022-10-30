import UIKit

final class ScoreViewController: UIViewController {

    private var isFirstLoad = true
    
    private var firstScore: Int = 0
    private var secondScore: Int = 0
    private var thirdScore: Int = 0
    
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
        let scores = ScoreService.shared.getScores()
        
        firstScore = scores[0]
        secondScore = scores[1]
        thirdScore = scores[2]

        firstScoreLabel.text = firstScore.makeScore()
        secondScoreLabel.text = secondScore.makeScore()
        thirdScoreLabel.text = thirdScore.makeScore()
    }
}
