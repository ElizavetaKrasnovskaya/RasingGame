import UIKit
import AVFoundation

final class GameViewController: UIViewController {
    
    // MARK: - Private properties
    private let carView = UIImageView(image: UIImage(named: "car"))
    private let carWidth: CGFloat = 50
    private let carHeight: CGFloat = 100
    private let lineWidth: CGFloat = 2
    private let lineHeight: CGFloat = 30
    private let barrierSize: CGFloat = 100
    private let coinSize: CGFloat = 50
    private let uiImage = UIImage(named: "barrier")
    
    private var defaultSpacing: CGFloat = 0
    private var isFirstLoad = true
    private var timerCount: Int = 0
    private var timer = Timer()
    private var roads = [CAShapeLayer]()
    private var barriers = [UIImageView]()
    private var coins = [UIImageView]()
    private var score: Int = 0
    private var carLocation: Location = .center {
        willSet (newLocation) {
            layoutCar(at: newLocation)
        }
    }
    
    private var player: AVAudioPlayer?
    
    // MARK: - @IBOutlets
    @IBOutlet private weak var timerLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var coinImageView: UIImageView!
    // MARK: - Override methods
    override func viewWillLayoutSubviews() {
        if isFirstLoad {
            initView()
            isFirstLoad = false
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        turnOfMusic()
    }
    
    // MARK: - Private methods
    private func initView() {
        setupTimer()
        setupCar()
        setupTrack()
        view.addSubview(carView)
        layoutCar(at: .center)
        setupMusic()
    }
    
    private func setupTimer() {
        timerCount = 3
        timerLabel.alpha = 1
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimerLabel), userInfo: nil, repeats: true)
    }
    
    private func setupCar() {
        defaultSpacing = (view.frame.width - carWidth * 3) / 4
        
        carView.frame = CGRect(
            x: getOriginX(for: .center),
            y: view.frame.size.height - carHeight * 2,
            width: carWidth,
            height: carHeight
        )
        
        addSwipeGesture(to: view, direction: .left)
        addSwipeGesture(to: view, direction: .right)
    }
    
    private func setupTrack() {
        let firstSeparator = UIView()
        firstSeparator.frame = CGRect(
            x: view.frame.width / 3,
            y: 0,
            width: 2,
            height: view.frame.size.height
        )
        firstSeparator.backgroundColor = .gray
        
        let secondSeparator = UIView()
        secondSeparator.frame = CGRect(
            x: view.frame.width * 2 / 3,
            y: 0,
            width: 2,
            height: view.frame.size.height
        )
        secondSeparator.backgroundColor = .gray
        
        view.addSubview(firstSeparator)
        view.addSubview(secondSeparator)
        drawDottedLine(start: CGPoint(x: view.frame.width / 6, y: lineHeight),
                       end: CGPoint(x: view.frame.width / 6, y: view.frame.height
                                   ), view: view)
        
        drawDottedLine(start: CGPoint(x: view.frame.width / 2, y: lineHeight),
                       end: CGPoint(x: view.frame.width / 2, y: view.frame.height
                                   ), view: view)
        
        drawDottedLine(start: CGPoint(x: view.frame.width * 5 / 6, y: lineHeight),
                       end: CGPoint(x: view.frame.width * 5 / 6, y: view.frame.height
                                   ), view: view)
    }
    
    func drawDottedLine(start p0: CGPoint, end p1: CGPoint, view: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.lineDashPattern = [30, 30]
        
        let path = CGMutablePath()
        path.addLines(between: [p0, p1])
        shapeLayer.path = path
        view.layer.addSublayer(shapeLayer)
        roads.append(shapeLayer)
    }
    
    private func animateRoad(view: CAShapeLayer) {
        let animation = CABasicAnimation(keyPath: "position.y")
        
        animation.fromValue = view.position.y
        animation.toValue = 60
        animation.duration = 0.4
        animation.autoreverses = false
        animation.repeatCount = .infinity
        view.add(animation, forKey: "position.y")
    }
    
    private func createBarrier(xCoordinate: CGFloat, delay: Double) {
        let imageView = UIImageView(image: uiImage)
        view.addSubview(imageView)
        imageView.frame = CGRect(x: xCoordinate, y: -100, width: barrierSize, height: barrierSize)
        
        let imageViewSecond = UIImageView(image: uiImage)
        view.addSubview(imageViewSecond)
        imageViewSecond.frame = CGRect(x: xCoordinate, y: -100, width: barrierSize, height: barrierSize)
        
        let spacing = Double(view.frame.height)
        let v = 150.0
        
        let s1 = spacing + 800
        let s2 = spacing + 1000
        
        let t1 = s1/v
        let t2 = s2/v
        
        UIView.animate(withDuration: t1, delay: delay, options: [ .curveLinear, .repeat], animations: {
            imageView.frame.origin.y += s1
        })
        
        UIView.animate(withDuration: t2, delay: delay / 2, options: [ .curveLinear, .repeat], animations: {
            imageViewSecond.frame.origin.y += s2
        })
        barriers.append(imageView)
        barriers.append(imageViewSecond)
        intersectsBarrier(imageView, imageViewSecond)
    }
    
    private func createCoin(xCoordinate: CGFloat, delay: Double) {
        let imageView = UIImageView(image: UIImage(named: "coin"))
        view.addSubview(imageView)
        imageView.frame = CGRect(x: xCoordinate, y: -100, width: coinSize, height: coinSize)
        
        let spacing = Double(view.frame.height)
        let v = 150.0
        
        let s1 = spacing + 2000
        
        let t1 = s1/v
        
        UIView.animate(withDuration: t1, delay: delay, options: [ .curveLinear, .repeat], animations: {
            imageView.frame.origin.y += s1
        })
        
        coins.append(imageView)
        intersectsCoin(imageView)
    }
    
    private func setupMusic() {
        if StorageService.shared.isMusicOn && player == nil {
            turnOnMusic()
        }
    }
    
    private func turnOnMusic() {
        let urlString = Bundle.main.path(forResource: "music", ofType: "mp3")
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString
            else { return }
            
            player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: urlString))
            
            guard let player = player
            else { return }
            
            player.play()
        } catch {
            print("Something went wrong")
        }
    }
    
    private func turnOfMusic() {
        if let player = player, player.isPlaying {
            player.stop()
        }
    }
    
    private func intersectsCoin(_ coinView: UIImageView) {
        if checkIntersect(carView, coinView) {
            let xPosition: CGFloat = coinView.layer.presentation()?.frame.origin.x ?? 0
            let yPosition: CGFloat = coinView.layer.presentation()?.frame.origin.y ?? 0
            coinView.frame = CGRect(x: xPosition, y: yPosition, width: coinSize, height: coinSize)
            coinView.layer.removeAllAnimations()
            UIView.animate(withDuration: 2, animations: {
                coinView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                
                coinView.frame.origin.x = self.coinImageView.frame.origin.x
                coinView.frame.origin.y = self.coinImageView.frame.origin.y
            }, completion: { finished in
                coinView.removeFromSuperview()
                self.createCoin(xCoordinate: xPosition, delay: 12)
            })
            score += 1
            scoreLabel.text = "\(score)"
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            self.intersectsCoin(coinView)
        }
    }
    
    private func intersectsBarrier(
        _ firstBarrier: UIImageView,
        _ secondBarrier: UIImageView
    ) {
        if checkIntersect(carView, firstBarrier) ||
            checkIntersect(carView, secondBarrier) {
            
            removeAnimation()
            
            ScoreService.shared.saveScore(score: Score(amount: score, date: getCurrentDate()))
            
            showAlert(
                title: "Game is over",
                message: "You can start a new game",
                actions: [
                    UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { _ in
                        self.initView()
                        self.score = 0
                        self.scoreLabel.text = "0"
                    }), UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { _ in
                        self.navigateBack()
                    })
                ]
            )
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.intersectsBarrier(firstBarrier, secondBarrier)
        }
    }
    
    private func removeAnimation() {
        for barrier in barriers {
            barrier.layer.removeAllAnimations()
        }
        for road in roads {
            road.removeAllAnimations()
        }
        for coin in coins {
            coin.layer.removeAllAnimations()
        }
    }
    
    private func checkIntersect(_ first: UIView, _ second: UIView) -> Bool {
        guard let firstFrame = first.layer.presentation()?.frame,
              let secondFrame = second.layer.presentation()?.frame else { return false }
        
        return firstFrame.intersects(secondFrame)
    }
    
    private func layoutCar(at location: Location) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
            self.carView.frame.origin.x = self.getOriginX(for: location)
        }
    }
    
    private func getOriginX(for location: Location) -> CGFloat {
        switch location {
        case .left:
            return defaultSpacing - carWidth / 2
        case .center:
            return defaultSpacing * 2 + carWidth
        case .right:
            return defaultSpacing * 3 + carWidth * 2.5
        }
    }
    
    private func addSwipeGesture(to view: UIView, direction: UISwipeGestureRecognizer.Direction) {
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(moveCar))
        swipeGesture.direction = direction
        view.addGestureRecognizer(swipeGesture)
    }
    
    @objc private func moveCar(_ gestureRecognizer: UISwipeGestureRecognizer) {
        switch gestureRecognizer.direction {
        case .left:
            if carLocation == .center { carLocation = .left }
            if carLocation == .right { carLocation = .center }
        case .right:
            if carLocation == .center { carLocation = .right }
            if carLocation == .left { carLocation = .center }
        default:
            return
        }
    }
    
    private func navigateBack() {
        navigationController?.popViewController(animated: false)
    }
    
    private func getCurrentDate() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm, d MMM y"
        return formatter.string(from: currentDate)
    }
    
    @objc private func updateTimerLabel() {
        if timerCount > 0 {
            timerCount -= 1
            timerLabel.text = String(timerCount)
        } else {
            timer.invalidate()
            for el in roads {
                animateRoad(view: el)
            }
            timerLabel.alpha = 0
            createBarrier(xCoordinate: view.frame.width / 6 - barrierSize / 2, delay: 2)
            createBarrier(xCoordinate: view.frame.width / 2 - barrierSize / 2, delay: 10)
            createBarrier(xCoordinate: view.frame.width * 5 / 6 - barrierSize / 2, delay: 7)
            
            createCoin(xCoordinate: view.frame.width / 6 - coinSize / 2, delay: 4)
            createCoin(xCoordinate: view.frame.width / 2 - coinSize / 2, delay: 15)
            createCoin(xCoordinate: view.frame.width * 5 / 6 - coinSize / 2, delay: 20)
        }
    }
}
