import Foundation

final class StorageService {
    
    static var shared = StorageService()
    
    private var storage = UserDefaults.standard
    
    var scores: [Score] {
        get {
            if let data = storage.value(forKey: Constants.scoreKey) as? Data,
               let scores = try? JSONDecoder().decode([Score].self, from: data) {
                    return scores
            } else {
                print("Failure decoding scores while load from UserDefaults")
                return [Score(amount: 0, date: "")]
            }
        }
        set {
            if let data = try? JSONEncoder().encode(newValue) {
                storage.set(data, forKey: Constants.scoreKey)
            } else {
                print("Failure encoding scores while save to UserDefaults")
                return
            }
        }
    }
    
    var isFirstLaunch: Bool {
        get {
            !storage.bool(forKey: Constants.firstLaunchKey)
        }
        set {
            storage.set(!newValue, forKey: Constants.firstLaunchKey)
        }
    }
}
