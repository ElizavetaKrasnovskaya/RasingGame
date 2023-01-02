import UIKit
import MessageUI

class SettingViewController: UIViewController {
    
    @IBOutlet private weak var corneredView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        corneredView.layer.cornerRadius = 25
    }
    
    @IBAction func onEmailClick(_ sender: UIButton) {
        let developerName = "e_krasnovskaya"
        guard let url = URL.init(string: "tg://resolve?domain=\(developerName)"),
              let webUrl = URL.init(string: "https://t.me/\(developerName)")
        else { return }
        
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            }
            else {
                UIApplication.shared.openURL(url)
            }
        } else {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(webUrl)
            }
            else {
                UIApplication.shared.openURL(webUrl)
            }
        }
    }
}
