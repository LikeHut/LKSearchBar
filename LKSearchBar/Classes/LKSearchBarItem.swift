//
//  LKSearchBarButton.swift
//  LKSearchBar
//
//  Created by WalkingBoy on 2022/12/1.
//

import Foundation

open class LKSearchBarItem: NSObject {

    // customView: 默认为 nil，如果有值，则其他属性失效
    open var customView: UIView? = nil
    
    // title: 默认为 nil
    open var title: String? = nil
    
    open var titleNormalColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
    open var titleHighlightedColor: UIColor = UIColor(red: 1, green: 1, blue: 1, alpha: 1)
    
    open var titleFont: UIFont = .systemFont(ofSize: 14)
    
    open var backgroundColor: UIColor = .clear
    
    open var cornerRadius: CGFloat = .zero
    
    open var normalImage: UIImage? = nil
    
    open var highlightedImage: UIImage? = nil
    
    open var target: Any? = nil
    
    open var action: Selector? = nil
}
