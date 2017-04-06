/*
 * Copyright © 2017 Denis Shurygin. All rights reserved.
 * Licensed under the Apache License, Version 2.0
 */

import Foundation
import UIKit

open class LocalizationExtensions {
    
    open static let notificationMissingTransalation = "LocalizationExtensions.missingTranslation";
    
    fileprivate static var bundles : [Bundle] = []
    
    open static func addBundle(_ bundle: Bundle) {
        if !bundles.contains(bundle) && bundle != Bundle.main {
            bundles.append(bundle)
        }
    }
}

extension String {
    
    public var localized: String {
        return self.localizedWithComment("")
    }
    
    public func localizedWithComment(_ comment: String) -> String {
        if let string = self.localizedWithComment(comment, bundle: Bundle.main, recursion: 1) {
            return string
        }
        
        if let string = self.localizedWithComment(comment, bundles: LocalizationExtensions.bundles) {
            return string
        }
        
        NotificationCenter.default.post(name: Notification.Name(rawValue: LocalizationExtensions.notificationMissingTransalation), object: self)
        
        return self
    }
    
    fileprivate func localizedWithComment(_ comment: String, bundles: [Bundle]) -> String? {
        for bundle in bundles {
            if bundle != Bundle.main {
                if let string = self.localizedWithComment(comment, bundle: bundle, recursion: 1) {
                    return string
                }
            }
        }
        
        return nil
    }
    
    fileprivate func localizedWithComment(_ comment: String, bundle: Bundle, recursion: Int) -> String? {
        let string = NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: comment)
        
        if self != string {
            return string
        }
        
        if recursion > 0 {
            if let urls = bundle.urls(forResourcesWithExtension: "bundle", subdirectory: nil) {
                for subURL in urls {
                    if let subBundle = Bundle(url: subURL) {
                        if let subString = self.localizedWithComment(comment, bundle: subBundle, recursion: recursion - 1) {
                            return subString
                        }
                    }
                }
                
            }
        }
        
        return nil;
    }
}

extension UILabel {
    
    public var lzText : String? {
        set {
            if newValue != nil {
                self.text = newValue?.localized
            }
            else {
                self.text = nil
            }
        }
        
        get {
            return self.text
        }
    }
}

extension UITextField {
    
    public var lzText : String? {
        set {
            if newValue != nil {
                self.text = newValue?.localized
            }
            else {
                self.text = nil
            }
        }
        
        get {
            return self.text
        }
    }
    
    public var lzPlaceholder : String? {
        set {
            if newValue != nil {
                self.placeholder = newValue?.localized
            }
            else {
                self.placeholder = nil
            }
        }
        
        get {
            return self.placeholder
        }
    }
}

extension UIButton {
    
    public var lzTitle : String? {
        set { setLocalizedTitle(newValue, state: UIControlState()) }
        get { return getTitleForState(UIControlState()) }
    }
    
    public var lzTitleHighlighted : String? {
        set { setLocalizedTitle(newValue, state: UIControlState.highlighted) }
        get { return getTitleForState(UIControlState.highlighted) }
    }
    
    public var lzTitleDisabled : String? {
        set { setLocalizedTitle(newValue, state: UIControlState.disabled) }
        get { return getTitleForState(UIControlState.disabled) }
    }
    
    public var lzTitleSelected : String? {
        set { setLocalizedTitle(newValue, state: UIControlState.selected) }
        get { return getTitleForState(UIControlState.selected) }
    }
    
    public var lzTitleFocused : String? {
        set { setLocalizedTitle(newValue, state: UIControlState.focused) }
        get { return getTitleForState(UIControlState.focused) }
    }
    
    public var lzTitleApplication : String? {
        set { setLocalizedTitle(newValue, state: UIControlState.application) }
        get { return getTitleForState(UIControlState.application) }
    }
    
    public var lzTitleReserved : String? {
        set { setLocalizedTitle(newValue, state: UIControlState.reserved) }
        get { return getTitleForState(UIControlState.reserved) }
    }
    
    fileprivate func setLocalizedTitle(_ title:String?, state: UIControlState) {
        if title != nil {
            self.setTitle(title!.localized, for: state)
        }
        else {
            self.setTitle(nil, for: state)
        }
    }
    
    fileprivate func getTitleForState(_ state: UIControlState) -> String?{
        if let title = self.titleLabel {
            return title.text
        }
        return nil
    }
}

extension UIBarItem {
    
    public var lzTitle : String? {
        set {
            if newValue != nil {
                self.title = newValue?.localized
            }
            else {
                self.title = nil
            }
        }
        
        get {
            return self.title
        }
    }
}

extension UINavigationItem {
    
    public var lzTitle : String? {
        set {
            if newValue != nil {
                self.title = newValue?.localized
            }
            else {
                self.title = nil
            }
        }
        
        get {
            return self.title
        }
    }
    
    public var lzPrompt : String? {
        set {
            if newValue != nil {
                self.prompt = newValue?.localized
            }
            else {
                self.prompt = nil
            }
        }
        
        get {
            return self.prompt
        }
    }
}

extension UIViewController {
    
    public var lzTitle : String? {
        set {
            if newValue != nil {
                self.title = newValue?.localized
            }
            else {
                self.title = nil
            }
        }
        
        get {
            return self.title
        }
    }
}

