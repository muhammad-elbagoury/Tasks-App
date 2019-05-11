//
//  DateExtension.swift
//  My Tasks App tr
//
//  Created by Muhammad Elbagoury on 1/23/19.
//  Copyright © 2019 Developers2Be. All rights reserved.
//

import Foundation

extension Date {
    
    func convertDateToString(format: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format       //"yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter.string(from: self)
    }
}
