import UIKit

protocol ShadowView where Self:UIView {
    func makeShadow(color: UIColor, shadowOpacity: Float, shadowOffset: CGSize, shadowRadius: CGFloat)
}

extension ShadowView {
    func makeShadow(
        color: UIColor = .black,
        shadowOpacity: Float = 1,
        shadowOffset: CGSize = .zero,
        shadowRadius: CGFloat = 10
    ) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = shadowOpacity
        layer.shadowOffset = shadowOffset
        layer.shadowRadius = shadowRadius
    }
}
