import Foundation
import UIKit

extension UILabel {
    func changeInNeedRangeColor (fullText: String , changeText: String ) {
        let attributedString: NSString = fullText as NSString
        let range = attributedString.range(of: changeText)
        let attribute = NSMutableAttributedString(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.attributedText = attribute
        print()
        print()
    }
}
