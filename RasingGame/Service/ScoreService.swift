import Foundation

final class ScoreService {
    
    static var shared = ScoreService()
    
    func getScores() -> [Int] {
        Array((Set(StorageService.shared.scores).sorted(by: >)))
    }
    
    func saveScore(score: Int) {
        var scores = StorageService.shared.scores
        scores.append(score)
        StorageService.shared.scores = scores
    }
}
