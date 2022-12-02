//
//  LKSearchBar.swift
//  LKSearchBar
//
//  Created by WalkingBoy on 2022/12/1.
//

import UIKit

internal protocol LKSearchBarDelegate: NSObjectProtocol {
    
    func searchBarShouldBeginEditing(_ searchBar: LKSearchBar) -> Bool // return NO to not become first responder

    func searchBarTextDidBeginEditing(_ searchBar: LKSearchBar) // called when text starts editing

    func searchBarShouldEndEditing(_ searchBar: LKSearchBar) -> Bool // return NO to not resign first responder

    func searchBarTextDidEndEditing(_ searchBar: LKSearchBar) // called when text ends editing

    func searchBar(_ searchBar: LKSearchBar, textDidChange searchText: String) // called when text changes (including clear)

    func searchBar(_ searchBar: LKSearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool // called before text changes
    
    func searchBarSearchButtonClicked(_ searchBar: LKSearchBar) // called when keyboard search button pressed

    func searchBarBookmarkButtonClicked(_ searchBar: LKSearchBar) // called when bookmark button pressed

    func searchBarCancelButtonClicked(_ searchBar: LKSearchBar) // called when cancel button pressed

    func searchBarResultsListButtonClicked(_ searchBar: LKSearchBar) // called when search results button pressed

    func searchBar(_ searchBar: LKSearchBar, selectedScopeButtonIndexDidChange selectedScope: Int)
}

open class LKSearchBar: UIView, UITextFieldDelegate {
    
    // MARK: - 初始化搜索栏
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(searchTextField)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 处理搜索栏交互
    weak var delegate: LKSearchBarDelegate?
    
    // MARK: - 搜索文本相关
    open var placeholder: String? {
        didSet {
            searchTextField.placeholder = placeholder
        }
    }
    
    open var placeholderColor: UIColor? {
        didSet {
            setupPlaceholder()
        }
    }
    
    open var placeholderFont: UIFont? = .systemFont(ofSize: 14.0) {
        didSet {
            setupPlaceholder()
        }
    }
    
    open var text: String? {
        didSet {
            searchTextField.text = text
        }
    }
    
    open var textColor: UIColor? {
        didSet {
            searchTextField.textColor = textColor
        }
    }
    
    open var textFont: UIFont? {
        didSet {
            searchTextField.font = textFont
        }
    }
    
    lazy open var searchTextField: UITextField = {
        let searchTextField = UITextField.init(frame: CGRect.zero)
        searchTextField.backgroundColor = .clear
        searchTextField.delegate = self
        return searchTextField
    }()
    
    
    // MARK: - 配置搜索栏
    open var borderColor: UIColor? {
        didSet {
            searchTextField.layer.borderColor = borderColor?.cgColor
        }
    }
    
    open var borderWidth: CGFloat = .zero {
        didSet {
            searchTextField.layer.borderWidth = borderWidth
        }
    }
    
    open var cornerRadius: CGFloat = .zero {
        didSet {
            searchTextField.layer.cornerRadius = cornerRadius
        }
    }
    
    open var backgroundImage: UIImage? {
        didSet {
            searchTextField.background = backgroundImage
        }
    }
    
    open var leftImage: UIImage? {
        didSet {
            setupLeftImage()
        }
    }
    
    open var leftImageOffset: UIOffset = UIOffset.zero {
        didSet {
            setupLeftImage()
        }
    }
    
    // MARK: - 配置搜索界面
    open var leftItem: LKSearchBarItem? {
        didSet {
            self.setupLeftItem()
        }
    }
        
    open var rightItem: LKSearchBarItem? {
        didSet {
            self.setupRightItem()
        }
    }
    
    open var alwaysShowLeftItem: Bool = false {
        didSet {
            
        }
    }
    
    open var alwaysShowRightItem: Bool = false {
        didSet {
            
        }
    }

    
    // MARK: - 共有方法
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        // 在这里设置各个状态下子控件的 frame
        
        if searchTextField.isEditing {
            // searchTextField 处于焦点状态
            if let _ = leftButton.superview {
//                leftButton.frame =
            }
            
            if let _ = rightButton.superview {
//                rightButton.frame =
            }
            
//            searchTextField.frame =
        } else {
            // searchTextField 失去焦点状态
            if let _ = leftButton.superview {
//                leftButton.frame =
            }
            
            if let _ = rightButton.superview {
//                rightButton.frame =
            }
            
//            searchTextField.frame =
        }
    }
    
    // MARK: - 私有属性
    internal var leftButton: UIButton {
        let leftButton = UIButton(type: .custom)
        leftButton.clipsToBounds = true
        return leftButton
    }
    
    internal var rightButton: UIButton {
        let rightButton = UIButton(type: .custom)
        rightButton.clipsToBounds = true
        return rightButton
    }
    
    
    // MARK: - 私有方法
    
    // 设置搜索栏左侧图标，默认为放大镜
    internal func setupLeftImage() {
        guard let _ = leftImage else {
            return
        }
        
        let imageView: UIImageView = UIImageView(image: leftImage)
        searchTextField.leftView = imageView
    }
    
    // 设置 placeholder 的 Font 和 Color
    internal func setupPlaceholder() {
        
    }
    
    // 设置左侧 button
    internal func setupLeftItem() {
        guard let _ = leftItem else {
            return
        }
        
        leftButton.titleLabel?.text = leftItem?.title
        leftButton.setTitleColor(leftItem?.titleNormalColor, for: .normal)
        leftButton.setTitleColor(leftItem?.titleHighlightedColor, for: .highlighted)
        leftButton.titleLabel?.font = leftItem?.titleFont
        leftButton.backgroundColor = leftItem?.backgroundColor
        leftButton.layer.cornerRadius = leftItem!.cornerRadius
        leftButton.setImage(leftItem?.normalImage, for: .normal)
        leftButton.setImage(leftItem?.highlightedImage, for: .highlighted)
        
        if let target = leftItem?.target, let action = leftItem?.action {
            self.leftButton.addTarget(target, action: action, for: .touchUpInside)
        }
        
        
    }
    
    // 设置右侧 button
    internal func setupRightItem() {
        guard let _ = rightItem else {
            return
        }
        
        rightButton.titleLabel?.text = rightItem?.title
        rightButton.setTitleColor(rightItem?.titleNormalColor, for: .normal)
        rightButton.setTitleColor(rightItem?.titleHighlightedColor, for: .highlighted)
        rightButton.titleLabel?.font = rightItem?.titleFont
        rightButton.backgroundColor = rightItem?.backgroundColor
        rightButton.layer.cornerRadius = rightItem!.cornerRadius
        rightButton.setImage(rightItem?.normalImage, for: .normal)
        rightButton.setImage(rightItem?.highlightedImage, for: .highlighted)
        
        if let target = rightItem?.target, let action = rightItem?.action {
            self.rightButton.addTarget(target, action: action, for: .touchUpInside)
        }
    }
    
    // 重新加载视图
    internal func reload() {
        self.removeAll()
        
        self.updateDisplay()
    }
    
    internal func removeAll() {
        if let _ = leftButton.superview {
            leftButton.removeFromSuperview()
        }
        if let _ = leftButton.superview {
            leftButton.removeFromSuperview()
        }
        if let _ = searchTextField.superview {
            searchTextField.removeFromSuperview()
        }
    }
    
    
    
    internal func updateDisplay() {
        if leftItem != nil {
            self.addSubview(leftButton)
        }
        
        if rightItem != nil {
            self.addSubview(rightButton)
        }
        
        self.addSubview(searchTextField)
        
        self.setNeedsLayout()
    }
    
    // searchTextField 切换状态时，添加切换动画
    internal func searchTextFieldChangeEditingState(editing: Bool) {
        if editing {    // 从默认状态切换为焦点状态
            // 添加 切换动画
            if let _ = leftButton.superview, let _ = rightButton.superview {
                
            } else if let _ = leftButton.superview {
                
            } else if let _ = rightButton.superview {
                
            }
        } else {        // 从焦点状态切换回默认状态
            // 添加 切换动画
            if let _ = leftButton.superview, let _ = rightButton.superview {
                
            } else if let _ = leftButton.superview {
                
            } else if let _ = rightButton.superview {
                
            }
        }
    }
    
    
    // MARK: - UITextField -> LKSearchBarDelegate
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        self.searchTextFieldChangeEditingState(editing: true)
        
        return delegate?.searchBarShouldBeginEditing(self) ?? true
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.searchBarTextDidBeginEditing(self)
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
       
        return  delegate?.searchBarShouldEndEditing(self) ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField) {
        self.searchTextFieldChangeEditingState(editing: false)
        
        delegate?.searchBarTextDidEndEditing(self)
    }
}
