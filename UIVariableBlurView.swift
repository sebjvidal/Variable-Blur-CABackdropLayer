//
//  UIVariableBlurView.swift
//
//  Created by Seb Vidal on 26/07/2023.
//

import UIKit

class UIVariableBlurView: UIView {
    // MARK: - Public Properties
    var blurRadius: CGFloat = 20 {
        didSet {
            setupVariableBlurFilter()
        }
    }
    
    var gradientMask: UIImage? = nil {
        didSet {
            setupVariableBlurFilter()
        }
    }
    
    override class var layerClass: AnyClass {
        return NSClassFromString("CABackdropLayer")!
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
        let filterClass = NSClassFromString("CAFilter") as AnyObject as! NSObjectProtocol
        let selector = Selector(("filterWithType:"))
        let variableBlur = filterClass.perform(selector, with: "variableBlur")
            .takeUnretainedValue()
        
        variableBlur.setValue(20, forKey: "inputRadius")
        variableBlur.setValue(true, forKey: "inputNormalizeEdges")
        variableBlur.setValue(gradientMask?.cgImage, forKey: "inputMaskImage")
        
        layer.filters = [variableBlur as! NSObject]
    }
}
