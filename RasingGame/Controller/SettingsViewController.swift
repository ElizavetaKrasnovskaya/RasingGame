import UIKit

final class SettingsViewController: UIViewController {

    @IBOutlet weak var corneredView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        corneredView.layer.cornerRadius = 25
    }
    
    @IBAction func emailButton(_ sender: UIButton) {
        
    }
}
