import Foundation
import UIKit

extension Data {
    
    var attributedString: NSAttributedString? {
        do {
           return try NSAttributedString(data: self, options:[.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            
        } catch {
            print(error)
        }
        return nil
    }
}

