//
//  energybar.swift
//  energybar
//
//  Created by Bonsung Koo on 2020/07/24.
//  Copyright © 2020 Bonsung Koo. All rights reserved.
//

import UIKit

public protocol EnergyBarDelegate: class {
    func buttonTap(eventID: String, tag: Int)
}

public class EnergyBar {
    
    public init() { }
    
    /// Energy Bar의 초기화
    ///
    /// - Parameter delegate: `EnergyBarDelegate` protocol을 준수하는 class
    ///
    /// - Note: Energy Bar의 Delgate는 `AppDelegate`에 추가하는 것을 권장한다.
    /// 기본적으로 Energy Bar는 앱의 모든 화면에서 보이므로 어느 한 `ViewController`에 속하지 않도록 주의하자.
    ///
    
    public init(delegate: EnergyBarDelegate) {
        _delegate = delegate
    }
    
    private weak var _delegate: EnergyBarDelegate?
    private var _currentMessage: UIVisualEffectView?
    private var _eventID: String?
    private var _size: CGSize?
    private var _isShowing: Bool = false
    
    private var _currentWindow: UIWindow {
        if var topWindow = UIApplication.shared.keyWindow {
            UIApplication.shared.windows.forEach {
                if $0.isHidden == false && $0.windowLevel > topWindow.windowLevel {
                    topWindow = $0
                }
            }
            return topWindow
        } else {
            return UIWindow()
        }
    }
    
    public enum EnergyBarError: String, Error {
        case delegateIsNil = "Delegate is Nil, call `setDelegate` and set delegate."
        case buttonCountIsZero = "This call have to have at least 1 button."
        case buttonTagIsNotSet = "Each button MUST set tag"
        case energyBarAlreadyShowing = "Energy bar showing currently!"
    }
    
    @objc private func _tapButton(sender: UIButton) {
        if let eventID = _eventID {
            _delegate?.buttonTap(eventID: eventID, tag: sender.tag)
        }
        _closeEnergyBar()
    }
        
    private func _closeEnergyBar() {
        _currentMessage?.removeFromSuperview()
        _currentMessage = nil
        _eventID = nil
        _isShowing = false
    }
    
    /// Energy Bar의 Delegate를 지정
    ///
    /// - Parameter delegate: `EnergyBarDelegate` protocol을 준수하는 class
    ///
    /// - Note: Energy Bar의 Delgate는 `AppDelegate`에 추가하는 것을 권장한다.
    /// 기본적으로 Energy Bar는 앱의 모든 화면에서 보이므로 어느 한 `ViewController`에 속하지 않도록 주의하자.
    ///
    
    public func setDelegate(delegate: EnergyBarDelegate) {
        _delegate = delegate
    }
    
    /// Energy Bar를 보여준다.
    ///
    /// - Parameter eventID: `EnergyBarDelegate`를 통해 전달 받을 EvnetID
    ///
    /// - Parameter messageLabel: 이미 만들어진 `UILabel`객체
    ///
    /// - Parameter buttons: 이미 만들어진 `UIButton`객체들
    ///
    /// - Parameter size: Energy Bar의 `CGSize`크기
    ///
    /// - Note: Energy Bar의 Delgate는 `AppDelegate`에 추가하는 것을 권장한다.
    /// 기본적으로 Energy Bar는 앱의 모든 화면에서 보이므로 어느 한 `ViewController`에 속하지 않도록 주의하자.
    ///
    
    public func show(eventID: String, messageLabel: UILabel, buttons: [UIButton], size: CGSize) throws {
        
        guard _delegate != nil else { throw EnergyBarError.delegateIsNil }
        guard buttons.count != 0 else { throw EnergyBarError.buttonCountIsZero }
        guard !buttons.contains(where: { $0.tag == 0 }) else { throw EnergyBarError.buttonTagIsNotSet }
        guard !_isShowing else { throw EnergyBarError.energyBarAlreadyShowing }
        
        _eventID = eventID
        _size = size
        _isShowing = true
        
        let blurView = UIVisualEffectView()
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.layer.cornerRadius = 10
        blurView.clipsToBounds = true
        blurView.effect = UIBlurEffect(style: .prominent)
        
        let blurViewConsts = [NSLayoutConstraint(item: blurView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size.width),
                              NSLayoutConstraint(item: blurView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size.height),
                              NSLayoutConstraint(item: blurView, attribute: .centerX, relatedBy: .equal, toItem: self._currentWindow, attribute: .centerX, multiplier: 1, constant: 0),
                              NSLayoutConstraint(item: blurView, attribute: .bottom, relatedBy: .equal, toItem: self._currentWindow.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -56)]
        
        _currentWindow.addSubview(blurView)
        _currentWindow.addConstraints(blurViewConsts)
        
        _currentMessage = blurView
        
        var b = [UIButton]()
        
        buttons.enumerated().forEach { button in
            
            button.element.translatesAutoresizingMaskIntoConstraints = false
            
            var buttonConsts: [NSLayoutConstraint] = [NSLayoutConstraint]()
            
            var widthSize: CGFloat {
                return button.element.intrinsicContentSize.width <= 50 ? 50 : button.element.intrinsicContentSize.width + 4
            }
            
            if button.offset == 0 {
                buttonConsts = [NSLayoutConstraint(item: button.element, attribute: .trailing, relatedBy: .equal, toItem: blurView.contentView, attribute: .trailing, multiplier: 1, constant: -16),
                                NSLayoutConstraint(item: button.element, attribute: .centerY, relatedBy: .equal, toItem: blurView.contentView, attribute: .centerY, multiplier: 1, constant: 0),
                                NSLayoutConstraint(item: button.element, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: widthSize),
                                NSLayoutConstraint(item: button.element, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 48)]
            } else {
                buttonConsts = [NSLayoutConstraint(item: button.element, attribute: .trailing, relatedBy: .equal, toItem: b.last, attribute: .leading, multiplier: 1, constant: 0),
                                NSLayoutConstraint(item: button.element, attribute: .centerY, relatedBy: .equal, toItem: blurView.contentView, attribute: .centerY, multiplier: 1, constant: 0),
                                NSLayoutConstraint(item: button.element, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: widthSize),
                                NSLayoutConstraint(item: button.element, attribute: .height, relatedBy: .equal, toItem: blurView.contentView, attribute: .height, multiplier: 1, constant: 0)]
            }
            
            button.element.addTarget(self, action: #selector(_tapButton), for: .touchUpInside)

            blurView.contentView.addSubview(button.element)
            blurView.contentView.addConstraints(buttonConsts)
            
            b.append(button.element)
            
        }
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let messageLabelConsts: [NSLayoutConstraint] = [NSLayoutConstraint(item: messageLabel, attribute: .leading, relatedBy: .equal, toItem: blurView.contentView, attribute: .leading, multiplier: 1, constant: 16),
                                                        NSLayoutConstraint(item: messageLabel, attribute: .trailing, relatedBy: .equal, toItem: b.last, attribute: .leading, multiplier: 1, constant: 0),
                                                        NSLayoutConstraint(item: messageLabel, attribute: .centerY, relatedBy: .equal, toItem: blurView.contentView, attribute: .centerY, multiplier: 1, constant: 0),
                                                        NSLayoutConstraint(item: messageLabel, attribute: .height, relatedBy: .equal, toItem: blurView.contentView, attribute: .height, multiplier: 1, constant: 0)]
        
        blurView.contentView.addSubview(messageLabel)
        blurView.contentView.addConstraints(messageLabelConsts)
        
    }
    
    /// Energy Bar를 다른 Window level에서 가져온다.
    ///
    /// - Note: 현재 Window에 있는 Energy Bar를 `removeFromSuperview()`메소드로 제거한 뒤,
    /// 새로운(더 높은 Window Level) Window에 추가한다.
    /// 만약 `present()`메소드로 인해 현재 Window level이 변경되면 이 메소드를 호출한다.
    
    public func bringEnergyBarToFront() {
        
        _currentMessage?.removeFromSuperview()
        
        guard
            let currentMessage = _currentMessage,
            let size = _size else { return }
        
        let currentMessageConsts = [NSLayoutConstraint(item: currentMessage, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .width, multiplier: 1, constant: size.width),
                                    NSLayoutConstraint(item: currentMessage, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: size.height),
                                    NSLayoutConstraint(item: currentMessage, attribute: .centerX, relatedBy: .equal, toItem: self._currentWindow, attribute: .centerX, multiplier: 1, constant: 0),
                                    NSLayoutConstraint(item: currentMessage, attribute: .bottom, relatedBy: .equal, toItem: self._currentWindow.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -56)]
        
        self._currentWindow.addSubview(currentMessage)
        self._currentWindow.addConstraints(currentMessageConsts)
    }
}
