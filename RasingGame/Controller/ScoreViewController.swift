import UIKit
import Foundation

final class ScoreViewController: UIViewController {
    
    private let CELL_IDENTIFIER = "SCORE_CELL"
    
    private lazy var scores = ScoreService.shared.getScores()
    private var selectedIndex: Int = -1

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        setupTable()
    }
    
    private func setupTable() {
        tableView.delegate = self
        tableView.dataSource = self
        let cellNib = UINib(nibName: "ScoreCell", bundle: Bundle.main)
        tableView.register(cellNib, forCellReuseIdentifier: CELL_IDENTIFIER)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? ScoreDetailsViewController,
              selectedIndex >= 0 , selectedIndex < scores.count
        else { return }
        destination.setup(with: scores[selectedIndex], onPlace: selectedIndex + 1)
        selectedIndex = -1
    }
}

extension ScoreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        scores.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let index = indexPath.row
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath) as? ScoreCell,
              index >= 0,
              index < scores.count
        else {
            return UITableViewCell()
        }
        cell.setup(with: scores[index], place: index)
        switch index {
        case 0:
            cell.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        case 1:
            cell.backgroundColor = #colorLiteral(red: 0.7529412508, green: 0.7529412508, blue: 0.7529412508, alpha: 1)
        case 2:
            cell.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.4980392157, blue: 0.1960784314, alpha: 1)
        default: cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let index = indexPath.row
        
        guard index >= 0, index < scores.count else { return }
        
        selectedIndex = index
        tableView.deselectRow(at: indexPath, animated: true)
        
        performSegue(withIdentifier: "openScore", sender: self)
    }
}
