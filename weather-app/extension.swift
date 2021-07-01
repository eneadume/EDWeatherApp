//
//  extension.swift
//  weather-app
//
//  Created by Enea Dume on 28.6.21.
//

import UIKit

extension String {
    func getObject<T : Decodable>() throws -> T {
        let jsonData = Data(self.utf8)
        return try JSONDecoder().decode(T.self, from: jsonData)
    }
}

extension UIColor {
    convenience init?(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension UIView {
    
    func applyDropShadow() {
        self.layer.shadowRadius = 6
        self.layer.shadowOffset = CGSize(width: 0, height: 6)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.1
    }
    
    func applyLightDropShadow() {
        self.layer.shadowRadius = 6
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.1
    }
    
    
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    @discardableResult
    func fillSuperview(padding: UIEdgeInsets = .zero) -> AnchoredConstraints {
        translatesAutoresizingMaskIntoConstraints = false
        var constraints: AnchoredConstraints = AnchoredConstraints()
        if let superviewTopAnchor = superview?.topAnchor {
            constraints.top = topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top)
            constraints.top?.isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            constraints.bottom = bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom)
            constraints.bottom?.isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            constraints.leading = leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left)
            constraints.leading?.isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            constraints.trailing = trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right)
            constraints.trailing?.isActive = true
        }
        return constraints
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    func centerXInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    func centerYInSuperview() {
        translatesAutoresizingMaskIntoConstraints = false
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
    }
    
    @discardableResult
    func constrainWidth(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: NSLayoutConstraint
        constraint = widthAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    @discardableResult
    func constrainHeight(constant: CGFloat) -> NSLayoutConstraint {
        translatesAutoresizingMaskIntoConstraints = false
        let constraint: NSLayoutConstraint
        constraint = heightAnchor.constraint(equalToConstant: constant)
        constraint.isActive = true
        return constraint
    }
    
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topAnchor
        }
    }
    
    var safeLeftAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.leftAnchor
        }else {
            return self.leftAnchor
        }
    }
    
    var safeRightAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11.0, *){
            return self.safeAreaLayoutGuide.rightAnchor
        }else {
            return self.rightAnchor
        }
    }
    
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomAnchor
        }
    }
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
    
    func activate() {
        top?.isActive = true
        leading?.isActive = true
        trailing?.isActive = true
        width?.isActive = true
        height?.isActive = true
        bottom?.isActive = true
    }
}

protocol CodableHelper {
    associatedtype Keys: CodingKey
    static func getStringValue(_ container: KeyedDecodingContainer<Keys>, key: Keys) -> String
    static func getIntValue(_ container: KeyedDecodingContainer<Keys>, key: Keys) -> Int
    static func getBoolValue(_ container: KeyedDecodingContainer<Keys>, key: Keys) -> Bool
}

extension CodableHelper {

    static func getStringValue(_ container: KeyedDecodingContainer<Keys>, key: Keys) -> String {
        var str: String = ""
        if let obj = try? container.decodeIfPresent(String.self, forKey: key) {//decode(String.self, forKey: key) {
            str = obj
        }
        else if let obj = try? container.decodeIfPresent(Int.self, forKey: key){
            str = obj.description//String(obj)
        }else if let obj = try? container.decodeIfPresent(Float.self, forKey: key) {
            str = obj.description
        }
        return str
    }

    static func getIntValue(_ container: KeyedDecodingContainer<Keys>, key: Keys) -> Int {
        var val: Int = 0
        if let obj = try? container.decodeIfPresent(String.self, forKey: key),
            let intVal = Int(obj){
            val = intVal
        }
        else if let obj = try? container.decodeIfPresent(Int.self, forKey: key){
            val = obj
        }else if let obj = try? container.decodeIfPresent(Float.self, forKey: key) {
            val = Int(obj)
        }
        return val
    }

    static func getBoolValue(_ container: KeyedDecodingContainer<Keys>, key: Keys) -> Bool {
        var val: Bool = false

        if let obj = try? container.decode(String.self, forKey: key),
            let intVal = Int(obj){

            (intVal != 0) ? (val = true) : (val = false)
        }
        else if let obj = try? container.decode(Int.self, forKey: key){
            (obj != 0) ? (val = true) : (val = false)
        }
        else if let obj = try? container.decode(Bool.self, forKey: key){
            val = obj
        }
        return val
    }
}


extension Date {
    static func today()-> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter.string(from: date)
    }
}
