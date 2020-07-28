//
//  ViewController.swift
//  EnergyBarExample
//
//  Created by Bonsung Koo on 2020/07/28.
//  Copyright © 2020 Bonsung Koo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let showEnergyBarButton = UIButton()
        showEnergyBarButton.translatesAutoresizingMaskIntoConstraints = false
        
        let showEnergyBarButtonConsts = [NSLayoutConstraint(item: showEnergyBarButton, attribute: .centerX, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: 0),
                                         NSLayoutConstraint(item: showEnergyBarButton, attribute: .centerY, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerY, multiplier: 1, constant: 0),
                                         NSLayoutConstraint(item: showEnergyBarButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: 100),
                                         NSLayoutConstraint(item: showEnergyBarButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 40)]
        
        showEnergyBarButton.setTitle("Show EnergyBar!", for: .normal)
        if #available(iOS 13.0, *) {
            showEnergyBarButton.setTitleColor(.label, for: .normal)
        } else {
            showEnergyBarButton.setTitleColor(.black, for: .normal)
        }
        
        showEnergyBarButton.setTitleColor(.gray, for: .highlighted)
        showEnergyBarButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        showEnergyBarButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        showEnergyBarButton.addTarget(self, action: #selector(_buttonTap), for: .touchUpInside)
        
        view.addSubview(showEnergyBarButton)
        view.addConstraints(showEnergyBarButtonConsts)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        _makeEnergyBar()
    }
    
    @objc private func _buttonTap(sender: UIButton) {
        _makeEnergyBar()
    }
    
    private func _makeEnergyBar() {
        let label = UILabel()
        label.text = "I'm your Energy!🍻"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)

        let clickButton = UIButton()
        let clickTitleString = "Click🤏"
        clickButton.setTitle(clickTitleString, for: .normal)
        if #available(iOS 13.0, *) {
            clickButton.setTitleColor(.label, for: .normal)
        } else {
            clickButton.setTitleColor(.black, for: .normal)
        }
        
        clickButton.setTitleColor(.gray, for: .highlighted)
        clickButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        clickButton.titleLabel?.textAlignment = .center
        clickButton.tag = clickTitleString.hash // 중요!
        
        let starButton = UIButton()
        let starTitleString = "Star⭐️"
        starButton.setTitle(starTitleString, for: .normal)
        
        if #available(iOS 13.0, *) {
            starButton.setTitleColor(.label, for: .normal)
        } else {
            starButton.setTitleColor(.black, for: .normal)
        }
        
        starButton.setTitleColor(.gray, for: .highlighted)
        starButton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .semibold)
        starButton.titleLabel?.textAlignment = .center
        starButton.tag = starTitleString.hash // 중요!
        
        let size = CGSize(width: view.bounds.width * 0.9, height: 48)
        
        do {
            
            try App.energyBar.show(eventID: EnergyBarEvents.example.rawValue, messageLabel: label, buttons: [starButton, clickButton], size: size)
            
        } catch {
            
            let alertController = UIAlertController(title: "Got you!😎", message: error.localizedDescription, preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Check✅", style: .default, handler: nil)
            
            alertController.addAction(alertAction)
            
            present(alertController, animated: true, completion: nil)
        }
    }
}
