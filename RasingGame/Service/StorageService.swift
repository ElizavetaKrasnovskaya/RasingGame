import Foundation

final class StorageService {
    
    static var shared = StorageService()
    
    private var storage = UserDefaults.standard
    
    var scores: [Int] {
        get {
            storage.array(forKey: Constants.scoreKey) as? [Int] ?? []
        }
        set {
            storage.set(newValue, forKey: Constants.scoreKey)
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
