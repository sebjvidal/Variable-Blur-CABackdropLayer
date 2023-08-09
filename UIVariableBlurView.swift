//
//  UIVariableBlurView.swift
//
//  Created by Seb Vidal on 26/07/2023.
//

import UIKit

class UIVariableBlurView: UIView {
    // MARK: - Private Properties
    private var filterClass: NSObjectProtocol {
        let encodedString = "Q0FGaWx0ZXI="
        let data = Data(base64Encoded: encodedString)!
        let string = String(data: data, encoding: .utf8)!
        
        return NSClassFromString(string) as AnyObject as! NSObjectProtocol
    }
    
    private var filterType: String {
        let encodedString = "dmFyaWFibGVCbHVy"
        let data = Data(base64Encoded: encodedString)!
        
        return String(data: data, encoding: .utf8)!
    }
    
    private var filterWithTypeSelector: Selector {
        let encodedString = "ZmlsdGVyV2l0aFR5cGU6"
        let data = Data(base64Encoded: encodedString)!
        let string = String(data: data, encoding: .utf8)!
        
        return Selector((string))
    }
    
    private var variableBlur: AnyObject!
    
    // MARK: - Public Properties
    var blurRadius: CGFloat = 20 {
        willSet {
            variableBlur.setValue(newValue, forKey: "inputRadius")
        }
    }
    
    var gradientMask: UIImage? = nil {
        willSet {
            variableBlur.setValue(newValue?.cgImage, forKey: "inputMaskImage")
        }
    }
    
    override class var layerClass: AnyClass {
        let encodedString = "Q0FCYWNrZHJvcExheWVy"
        let data = Data(base64Encoded: encodedString)!
        let string = String(data: data, encoding: .utf8)!
        
        return NSClassFromString(string)!
    }
    
    // MARK: - init(frame:)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupVariableBlurFilter()
    }
    
    // MARK: - init?(coder:)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    private func setupVariableBlurFilter() {
        variableBlur = filterClass.perform(filterWithTypeSelector, with: filterType).takeUnretainedValue()
        variableBlur.setValue(blurRadius, forKey: "inputRadius")
        variableBlur.setValue(true, forKey: "inputNormalizeEdges")
        variableBlur.setValue(gradientMask?.cgImage, forKey: "inputMaskImage")
        
        layer.filters = [variableBlur as! NSObject]
    }
}
