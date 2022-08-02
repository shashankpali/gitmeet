//
//  String+Extension.swift
//  GitMeet
//
//  Created by Shashank Pali on 02/08/22.
//

import Foundation

extension String {
    
    func convertDateFormat() -> String {

         let oldFormatter = DateFormatter()
         oldFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"

         let oldDate = oldFormatter.date(from: self)

         let newFormatter = DateFormatter()
        newFormatter.dateFormat = "dd-MMM-yyyy hh:mm:ss a"

         return newFormatter.string(from: oldDate!)
    }
    
}
