import UIKit

class ScoreCell: UITableViewCell {

    @IBOutlet weak var placeLbl: UILabel!
    @IBOutlet weak var scoreLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        placeLbl.text = ""
        scoreLbl.text = ""
    }
    
    public func setup(with score: Score, place: Int) {
        placeLbl.text = "\(place + 1)"
        scoreLbl.text = score.makeScore()
    }
}
