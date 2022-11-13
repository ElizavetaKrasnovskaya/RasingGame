import Foundation

final class ScoreService {
    
    static var shared = ScoreService()
    
    func getScores() -> [Score] {
        Array((Set(StorageService.shared.scores).sorted(by: { $0.amount > $1.amount })))
    }
    
    func saveScore(score: Score) {
        var scores = StorageService.shared.scores
        scores.append(score)
        StorageService.shared.scores = scores
    }
}
