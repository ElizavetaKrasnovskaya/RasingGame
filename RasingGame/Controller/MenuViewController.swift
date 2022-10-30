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
        setupCarShopView()
    }
    
    private func setupNewGameView() {
        let startNewGame = MenuItemView()
        startNewGame.frame = CGRect(x: -width, y: view.frame.height / 2 - 2 * height - height, width: width, height: height)
        
        let labelStart = UILabel()
        labelStart.frame = CGRect(x: padding, y: 0, width: width, height: height)
        labelStart.textAlignment = .left
        labelStart.isUserInteractionEnabled = true
        setupFont(label: labelStart, text: "Start game")
        
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
        setupFont(label: labelScore, text: "Score list")
        
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
    
    private func setupCarShopView() {
        let carShopView = MenuItemView()
        carShopView.frame = CGRect(x: -width, y: view.frame.height / 2 + 2 * height - height, width: width, height: height)
        
        let labelCarShop = UILabel()
        labelCarShop.frame = CGRect(x: padding, y: 0, width: width, height: height)
        labelCarShop.textAlignment = .left
        setupFont(label: labelCarShop, text: "Car shop")
        
        view.addSubview(carShopView)
        carShopView.addSubview(labelCarShop)

        UIView.animate(withDuration: 1, delay: 2, animations: {
            carShopView.frame.origin.x += self.width
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
        let scoreViewController = ScoreViewController(nibName: "ScoreViewController", bundle: nil)
        
        self.navigationController?.pushViewController(scoreViewController, animated: false)
    }
}
