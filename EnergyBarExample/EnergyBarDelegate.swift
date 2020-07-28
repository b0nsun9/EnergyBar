//
//  EnergyBarDelegate.swift
//  EnergyBarExample
//
//  Created by Bonsung Koo on 2020/07/28.
//  Copyright © 2020 Bonsung Koo. All rights reserved.
//

import UIKit

extension AppDelegate: EnergyBarDelegate {
    func buttonTap(eventID: String, tag: Int) {
        if let event = EnergyBarEvents(rawValue: eventID) {
            switch event {
            case .example:
                if tag == "Click🤏".hash {
                    
                    let alertController = UIAlertController(title: "Click🤏", message: nil, preferredStyle: .alert)
                    
                    let alertAction = UIAlertAction(title: "Please🙏", style: .default, handler: nil)
                    
                    alertController.addAction(alertAction)
                    
                    window?.rootViewController?.present(alertController, animated: true, completion: nil)
                    
                } else if tag == "Star⭐️".hash {
                    
                    let alertController = UIAlertController(title: "Star⭐️", message: nil, preferredStyle: .alert)
                    
                    let alertAction = UIAlertAction(title: "Please🙏", style: .default, handler: nil)
                    
                    alertController.addAction(alertAction)
                    
                    window?.rootViewController?.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
