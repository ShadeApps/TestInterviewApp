//
//  BookTableCell.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 03.01.2021.
//

import UIKit

final class BookTableCell: UITableViewCell {
    
    private var title: UILabel!
    private var subtitle: UILabel!
    private var bottomSubtitle: UILabel!
    private var cover: UIImageView!
    
    private var imageProvider: ImageProvider?
    private var imageAnimator: UIViewPropertyAnimator?
    
    private enum Constants {
        static let spacing = CGFloat(10)
        static let defaultSpearatorHeight = CGFloat(1)
        static let imageSize = CGFloat(80)
        static let titleFont = UIFont.boldSystemFont(ofSize: 18)
        static let subtitleFont = UIFont.systemFont(ofSize: 14)
    }
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        imageProvider = ImageProvider()
        addViews()
        styleViews()
        
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    override func prepareForReuse() {
        
        super.prepareForReuse()
        
        cover.image = nil
        cover.alpha = 0.0
        imageAnimator?.stopAnimation(true)
        imageProvider?.cancel()
        
    }
    
    func layoutWith(_ viewModel: BookCellViewModel) {
        
        title.text = viewModel.title
        subtitle.text = viewModel.byAuthors
        bottomSubtitle.text = viewModel.withNarrators
        
        imageProvider?.loadImage(withURL: viewModel.coverURL) { [weak self] image in
            
            guard let self = self else { return }
            self.showImage(image: image)
            
        }
        
    }
}

extension BookTableCell: UICellLayoutable {
    // MARK: - View set up
    internal func addViews() {
        
        let separator = SeparatorView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(separator)
        
        NSLayoutConstraint.activate([
            separator.heightAnchor.constraint(equalToConstant: Constants.defaultSpearatorHeight),
            separator.leftAnchor.constraint(equalTo: separator.superview!.leftAnchor, constant: Constants.spacing),
            separator.rightAnchor.constraint(equalTo: separator.superview!.rightAnchor),
            separator.bottomAnchor.constraint(equalTo: separator.superview!.bottomAnchor)
        ])
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = Constants.spacing
        stackView.alignment = .leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.spacing),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.spacing),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.spacing),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constants.spacing)
        ])
        
        cover = UIImageView()
        cover.contentMode = .scaleAspectFit
        stackView.addArrangedSubview(cover)
        
        NSLayoutConstraint.activate([
            cover.widthAnchor.constraint(equalToConstant: Constants.imageSize),
            cover.heightAnchor.constraint(equalToConstant: Constants.imageSize)
        ])
        
        title = UILabel()
        title.font = Constants.titleFont
        
        subtitle = UILabel()
        subtitle.font = Constants.subtitleFont
        
        bottomSubtitle = UILabel()
        bottomSubtitle.font = Constants.subtitleFont
        
        let textStackView = UIStackView()
        textStackView.axis = .vertical
        textStackView.distribution = .equalSpacing
        textStackView.alignment = .leading
        textStackView.spacing = Constants.spacing
        textStackView.addArrangedSubview(title)
        textStackView.addArrangedSubview(subtitle)
        textStackView.addArrangedSubview(bottomSubtitle)
        stackView.addArrangedSubview(textStackView)
        
    }
    
    internal func styleViews() {
        
        selectionStyle = .none
        
    }
    
}

extension BookTableCell {
    // MARK: - Image loading and caching
    private func showImage(image: UIImage?) {
        
        cover.alpha = 0.0
        imageAnimator?.stopAnimation(false)
        
        cover.image = image
        imageAnimator = UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.cover.alpha = 1.0
        })
        
    }
    
}
