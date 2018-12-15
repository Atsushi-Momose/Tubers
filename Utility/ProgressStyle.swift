//
//  ProgressStyle.swift
//  Tubers
//
//  Created by mmsc on 2018/11/24.
//  Copyright © 2018年 mmsc. All rights reserved.
//

import GradientCircularProgress
import Foundation

struct ProgressStyle: StyleProperty {
    
    // Progress Size
    public var progressSize: CGFloat = 50
    
    // Gradient Circular
    public var arcLineWidth: CGFloat = 4.0
    public var startArcColor: UIColor = UIColor.blue
    public var endArcColor: UIColor = UIColor.green
    
    // Base Circular
    public var baseLineWidth: CGFloat? = 4.0
    public var baseArcColor: UIColor? = UIColor.darkGray
    
    // Ratio
    public var ratioLabelFont: UIFont? = UIFont(name: "Verdana-Bold", size: 16.0)
    public var ratioLabelFontColor: UIColor? = UIColor.white
    
    // Message
    public var messageLabelFont: UIFont? = UIFont.systemFont(ofSize: 16.0)
    public var messageLabelFontColor: UIColor? = UIColor.white
    
    // Background
    public var backgroundStyle: BackgroundStyles = .light
    
    // Dismiss
    public var dismissTimeInterval: Double? = 0.0 // 'nil' for default setting.
    
    /*** style properties **********************************************************************************/
    
    public init() {}
}
