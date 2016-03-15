import UIKit

class StateHistoryCollectionViewCell: UICollectionViewCell {

    var label: UILabel!
    var text: String = "" {
        didSet {
            label.text = text
            label.sizeToFit()
            label.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        label = UILabel()
        label.font = label.font.fontWithSize(18)
        addSubview(label)

        backgroundColor = UIColor.redColor()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
