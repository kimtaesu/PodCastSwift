import SnapKit
import UIKit

extension UIViewController {
    var safeAreaLeading: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.leading
        } else {
            return self.view.snp.leading
        }
    }
    var safeAreaTrailing: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.trailing
        } else {
            return self.view.snp.trailing
        }
    }
    var safeAreaBottom: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.bottom
        } else {
            return self.view.snp.bottom
        }
    }
    var safeAreaTop: ConstraintItem {
        if #available(iOS 11, *) {
            return self.view.safeAreaLayoutGuide.snp.top
        } else {
            return self.view.snp.top
        }
    }
}
