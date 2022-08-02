//
//  UIImageView+Extension.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import UIKit

extension UIImageView {
    
    public func imageFromServerURL(urlString: String, placeholderImage:UIImage) {
        
        if self.image == nil {
            self.image = placeholderImage
        }
        
        Network().getData(urlString: urlString) { res in
            switch res {
            case .success(let data):
                DispatchQueue.main.async(execute: { () -> Void in
                    let image = UIImage(data: data)
                    self.image = image
                })
                break
            case .failure(_):
                break
            }
        }
    }}
