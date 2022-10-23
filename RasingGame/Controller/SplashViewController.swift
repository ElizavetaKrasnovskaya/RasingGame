import UIKit

class SplashViewController: UIViewController {
    
    private var isFirstLoad = true
    private let carHeight: CGFloat = 100
    private let carWidth: CGFloat = 150
    
    @IBOutlet weak var lblRasing: UILabel!
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if isFirstLoad {
            initView()
            isFirstLoad = false
        }
    }
    
    private func initView() {
        let gifImage = UIImage.gifImageWithName("carGif")
        let gifImageView = UIImageView(image: gifImage)
        gifImageView.frame = CGRect(x: -carWidth, y: self.view.frame.height / 2 - 60, width: carWidth, height: carHeight)
        view.addSubview(gifImageView)
        
        UIView.animate(withDuration: 4, delay: 0, options: .curveLinear, animations: {
            gifImageView.frame.origin.x += self.view.frame.width + self.carWidth
        })

        UIView.animate(withDuration: 2, delay: 0, animations: {
            self.lblRasing.alpha = 1
        })
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + .seconds(4)) {
            self.navigateToMainScreen()
        }
    }
    
    private func navigateToMainScreen() {
        let menuViewController = UIViewController(nibName: "MenuViewController", bundle: nil)
        view.window?.rootViewController = menuViewController
        view.window?.makeKeyAndVisible()
    }
}

