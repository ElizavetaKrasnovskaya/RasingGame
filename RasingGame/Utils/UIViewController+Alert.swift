import UIKit

extension UIViewController {
    func showAlert(
        title: String = "",
        message: String = "",
        preferredStyle: UIAlertController.Style = .alert,
        actions: [UIAlertAction] = []
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alert.addAction(action)
        }
        self.present(alert, animated: true)
    }
}
