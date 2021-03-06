//
//  LoaderCell.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 06.01.2021.
//

import UIKit

final class LoaderCell: UITableViewCell {
    
    private var loader: UIActivityIndicatorView!
    
    private enum Constants {
        static let height = CGFloat(70)
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addViews()
        styleViews()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        loader.startAnimating()
        
    }
}

extension LoaderCell: UICellLayoutable {
    // MARK: - View set up
    internal func addViews() {
        
        let parentView = UIView()
        parentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(parentView)
        
        NSLayoutConstraint.activate([
            parentView.heightAnchor.constraint(equalToConstant: Constants.height),
            parentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            parentView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            parentView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            parentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        loader = UIActivityIndicatorView(style: .large)
        loader.centerIn(parentView)
        loader.startAnimating()
        
    }
    
    internal func styleViews() {
        
        selectionStyle = .none
        
    }
    
}
