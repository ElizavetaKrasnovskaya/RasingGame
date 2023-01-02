import UIKit
import MessageUI

class SettingViewController: UIViewController {
    
    @IBOutlet private weak var corneredView: UIView!
    @IBOutlet weak var musicSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        corneredView.layer.cornerRadius = 25
        musicSwitch.isOn = StorageService.shared.isMusicOn
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
    
    @IBAction func onMusicClick(_ sender: UISwitch) {
        musicSwitch.isOn = (sender as UISwitch).isOn
        StorageService.shared.isMusicOn = musicSwitch.isOn
    }
}
