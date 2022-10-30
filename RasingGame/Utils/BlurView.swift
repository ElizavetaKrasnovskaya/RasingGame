import UIKit

protocol BlurView where Self:UIView {
    func blur()
    func deleteBlur()
}

extension BlurView {
    
    func blur() {
        
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.alpha = 0
        addSubview(blurEffectView)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
            blurEffectView.alpha = 0.16
        }, completion: nil)
    }
    
    func deleteBlur() {
        subviews.forEach { bluredView in
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut, animations: {
                bluredView.alpha = 0
            }, completion: { _ in
                bluredView.removeFromSuperview()
            })
        }
    }
}
