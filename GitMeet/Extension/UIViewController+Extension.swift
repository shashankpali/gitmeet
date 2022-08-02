//
//  UIViewController+Extension.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import UIKit

extension UIViewController {
    func showAlert(title:String = "", message msg: String = "", forActions: [AlertAction], style: UIAlertController.Style = .alert, callback:((String) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: style)
        
        for action in forActions {
            alert.addAction(UIAlertAction(title: action.title, style: action.style) { action in
                guard let block = callback else {return}
                block(action.title ?? "")
            })
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
}

class AlertAction: NSObject {
    var title: String
    var style: UIAlertAction.Style
    
    init(withTitle: String, style: UIAlertAction.Style) {
        title = withTitle
        self.style = style
    }
    
    static func forStyle(_ style: UIAlertAction.Style, title: String) -> AlertAction {
        return AlertAction.init(withTitle: title, style: style)
    }
}
