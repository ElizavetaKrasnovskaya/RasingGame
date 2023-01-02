import UIKit

final class ScoreDetailsViewController: UIViewController {
    
    @IBOutlet private weak var scoreLbl: UILabel!
    @IBOutlet private weak var dateLbl: UILabel!
    @IBOutlet private weak var placeLbl: UILabel!
    
    var score: Score? = nil
    var index = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scoreLbl.text = score?.makeScore()
        dateLbl.text = score?.makeDate()
        placeLbl.text = "\(index)"
    }
    
    public func setup(with score: Score, onPlace place: Int) {
        self.score = score
        index = place
    }
}
