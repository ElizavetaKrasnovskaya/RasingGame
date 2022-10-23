import UIKit

class MenuItemView: UIView {
    
    var direction = BackgroundDirection.right
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = UIColor.clear
    }
    
    override func draw(_ rect: CGRect) {
        let size = self.bounds.size
        var w = size.width * 0.8
        
        var p1 = self.bounds.origin
        var p2 = CGPoint(x: p1.x + w, y: p1.y)
        var p3 = CGPoint(x: size.width, y: size.height)
        var p4 = CGPoint(x: p1.x, y: size.height)

        if direction == .left {
            w = size.width * 0.2
            p1 = CGPoint(x: p1.x + w, y: p1.y)
            p2 = CGPoint(x: size.width, y: p1.y)
            p3 = CGPoint(x: size.width, y: size.height)
            p4 = CGPoint(x: p1.x - w, y: size.height)
        }
        
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.addLine(to: p4)
        path.close()
        
        UIColor.yellow.set()
        path.fill()
    }
}
