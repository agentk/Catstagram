import UIKit

class DetailItemCell: UITableViewCell {

    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!

    var aspectRatio: CGFloat = 1.0 {
        didSet {
            if imageHeightConstraint != nil && imageHeightConstraint.active {
                NSLayoutConstraint.deactivateConstraints([imageHeightConstraint])
            }

            if let constraint = flexibleAspectConstraint {
                NSLayoutConstraint.deactivateConstraints([constraint])
            }

            flexibleAspectConstraint = NSLayoutConstraint(
                item: photoView,
                attribute: .Width,
                relatedBy: .Equal,
                toItem: photoView,
                attribute: .Height,
                multiplier: aspectRatio,
                constant: 0)
            flexibleAspectConstraint?.priority = 751

            if let constraint = flexibleAspectConstraint {
                NSLayoutConstraint.activateConstraints([constraint])
            }

            setNeedsLayout()
        }
    }

    var flexibleAspectConstraint: NSLayoutConstraint?

}
