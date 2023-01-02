import Foundation

extension Score {
    func makeScore() -> String {
        "\(NSLocalizedString("score", comment: "")): \(self.amount)"
    }
    func makeDate() -> String {
        "\(NSLocalizedString("date", comment: "")): \(self.date)"
    }
}
