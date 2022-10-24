import UIKit

final class SplashViewController: UIViewController {
    
    // MARK: - Private properties
    private var isFirstLoad = true
    private let carHeight: CGFloat = 100
    private let carWidth: CGFloat = 150
    
    // MARK: - IBOutlets
    @IBOutlet private weak var lblRasing: LogoLabelView!
    
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
        setupGif()
        setupLogoLabel()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(4)) {
            self.navigateToMainScreen()
        }
    }
    
    private func setupGif() {
        let gifImage = UIImage.gifImageWithName("carGif")
        let gifImageView = UIImageView(image: gifImage)
        gifImageView.frame = CGRect(x: -carWidth, y: self.view.frame.height / 2 - 60, width: carWidth, height: carHeight)
        view.addSubview(gifImageView)
        
        UIView.animate(withDuration: 4, delay: 0, options: .curveLinear, animations: {
            gifImageView.frame.origin.x += self.view.frame.width + self.carWidth
        })
    }
    
    private func setupLogoLabel() {
        UIView.animate(withDuration: 2, delay: 0, animations: {
            self.lblRasing.alpha = 1
            self.lblRasing.makeShadow(shadowOpacity: 0.8, shadowOffset: CGSize(width: 5, height: 5), shadowRadius: 2)
        })
    }
    
    private func navigateToMainScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let menuViewController = storyboard.instantiateViewController(identifier: "MenuViewController") as? MenuViewController
        else { return }
        
        view.window?.rootViewController = menuViewController
        view.window?.makeKeyAndVisible()
        
        //        let menuViewController = UIViewController(nibName: "CheckViewController", bundle: nil)
        //        self.navigationController?.pushViewController(menuViewController, animated: true)
        //
        //
        //        view.window?.rootViewController = menuViewController
        //        view.window?.makeKeyAndVisible()
    }
}

