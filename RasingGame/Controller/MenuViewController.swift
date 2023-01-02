import UIKit

final class MenuViewController: UIViewController {

    // MARK: - Private properties
    private let width: CGFloat = 250
    private let height: CGFloat = 70
    private let padding: CGFloat = 16
    private var isFirstLoad = true
    
    @IBOutlet weak var background: BlurImageView!
    
    // MARK: - Override methods
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if isFirstLoad {
            initView()
            isFirstLoad = false
        }
    }
    
    // MARK: - Private methods
    private func initView() {
        self.navigationItem.setHidesBackButton(true, animated: false)
        background.blur()
        setupNewGameView()
        setupScoreView()
        setupSettingsView()
    }
    
    private func setupNewGameView() {
        let startNewGame = MenuItemView()
        startNewGame.frame = CGRect(x: -width, y: view.frame.height / 2 - 2 * height - height, width: width, height: height)
        
        let labelStart = UILabel()
        labelStart.frame = CGRect(x: padding, y: 0, width: width, height: height)
        labelStart.textAlignment = .left
        labelStart.isUserInteractionEnabled = true
        let startGameText = NSLocalizedString("start_game", comment: "")
        setupFont(label: labelStart, text: startGameText)
        
        view.addSubview(startNewGame)
        startNewGame.addSubview(labelStart)

        UIView.animate(withDuration: 1, delay: 0, animations: {
            startNewGame.frame.origin.x += self.width
        }, completion: { (isFinished: Bool) in
            let gesture = UITapGestureRecognizer(
                target: self,
                action: #selector(self.navigateToGame)
            )
            labelStart.addGestureRecognizer(gesture)
        })
    }
    
    private func setupScoreView() {
        let scoreView = MenuItemView()
        scoreView.direction = BackgroundDirection.left
        scoreView.frame = CGRect(x: view.frame.width, y: view.frame.height / 2 - height, width: width, height: height)
        
        let labelScore = UILabel()
        labelScore.frame = CGRect(x: 0, y: 0, width: width - padding, height: height)
        labelScore.textAlignment = .right
        labelScore.isUserInteractionEnabled = true
        let scoreText = NSLocalizedString("score_list", comment: "")
        setupFont(label: labelScore, text: scoreText)
        
        view.addSubview(scoreView)
        scoreView.addSubview(labelScore)

        UIView.animate(withDuration: 1, delay: 1, animations: {
            scoreView.frame.origin.x -= self.width
        }, completion: { (isFinished: Bool) in
            let gesture = UITapGestureRecognizer(
                target: self,
                action: #selector(self.navigateToScoreList)
            )
            labelScore.addGestureRecognizer(gesture)
        })
    }
    
    private func setupSettingsView() {
        let settingsView = MenuItemView()
        settingsView.frame = CGRect(x: -width, y: view.frame.height / 2 + 2 * height - height, width: width, height: height)
        
        let labelSettings = UILabel()
        labelSettings.frame = CGRect(x: padding, y: 0, width: width, height: height)
        labelSettings.textAlignment = .left
        labelSettings.isUserInteractionEnabled = true
        let settingsText = NSLocalizedString("settings", comment: "")
        setupFont(label: labelSettings, text: settingsText)
        
        view.addSubview(settingsView)
        settingsView.addSubview(labelSettings)

        UIView.animate(withDuration: 1, delay: 2, animations: {
            settingsView.frame.origin.x += self.width
        }, completion: { (isFinished: Bool) in
            let gesture = UITapGestureRecognizer(
                target: self,
                action: #selector(self.navigateToSettings)
            )
            labelSettings.addGestureRecognizer(gesture)
        })
    }
    
    private func setupFont(label: UILabel, text: String) {
        
        guard let font: UIFont = UIFont(name: "Drift Wood", size: 20.0)
        else { return }
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: UIColor.black,
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        label.attributedText = attributedString
    }
    
    @objc private func navigateToGame() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let gameViewController = storyboard.instantiateViewController(identifier: "GameViewController") as? GameViewController
        else { return }
        
        self.navigationController?.pushViewController(gameViewController, animated: false)
    }
    
    @objc private func navigateToScoreList() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let scoresViewController = storyboard.instantiateViewController(identifier: "ScoreViewController") as? ScoreViewController
        else { return }
        
        self.navigationController?.pushViewController(scoresViewController, animated: false)
    }
    
    @objc private func navigateToSettings() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let scoresViewController = storyboard.instantiateViewController(identifier: "SettingViewController") as? SettingViewController
        else { return }
        
        self.navigationController?.pushViewController(scoresViewController, animated: false)
    }
}
