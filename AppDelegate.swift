import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        overrideKeyboardConstraints() // ✅ Fix UIKit Constraint Issues
        return true
    }

    /// ✅ Global override of UIKit Auto Layout conflicts
    private func overrideKeyboardConstraints() {
        DispatchQueue.main.async {
            guard let window = UIApplication.shared.windows.first else { return }

            let systemViews = ["UIRemoteKeyboardPlaceholderView", "InputAssistantView", "InputAccessoryView"]

            // ✅ Remove any lingering system views
            for view in window.subviews {
                if systemViews.contains(where: { view.description.contains($0) }) {
                    view.removeFromSuperview()
                }
            }

            // ✅ Remove broken constraints
            for constraint in window.constraints {
                if let firstItem = constraint.firstItem, let secondItem = constraint.secondItem {
                    let firstName = String(describing: firstItem)
                    let secondName = String(describing: secondItem)

                    if systemViews.contains(where: { firstName.contains($0) }) ||
                        systemViews.contains(where: { secondName.contains($0) }) {
                        window.removeConstraint(constraint)
                    }
                }
            }
        }
    }
}