//
//  RepositoryCell.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

final class RepositoryCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let descriptionLabel = UILabel()
    let avatarImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.addSubviews()
        self.setupConstraints()
        self.setupViews()
    }
    
    private func addSubviews() {
        self.contentView.addSubview(self.nameLabel)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.avatarImageView)
    }
    
    private func setupViews() {
        self.setupColors()
        
        self.nameLabel.font = .systemFont(ofSize: 16)
        self.descriptionLabel.font = .systemFont(ofSize: 14)
        
        self.nameLabel.numberOfLines = 1
        self.descriptionLabel.numberOfLines = 0
        
        self.avatarImageView.clipsToBounds = true
        self.avatarImageView.layer.cornerRadius = 20
    }
    
    private func setupColors() {
        let scheme = ColorScheme.default
        
        self.backgroundColor = scheme.background
        self.nameLabel.textColor = scheme.text
        self.descriptionLabel.textColor = scheme.text
        self.avatarImageView.backgroundColor = scheme.separator
    }
    
    private func setupConstraints() {
        self.setupAvatarImageConstraintsImage()
        self.setupConstraintsNameLabel()
        self.setupDescriptionLabel()
    }
    
    private func setupAvatarImageConstraintsImage() {
        self.avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.avatarImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        let leading = self.avatarImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let height = self.avatarImageView.heightAnchor.constraint(equalToConstant: 40)
        let width = self.avatarImageView.widthAnchor.constraint(equalToConstant: 40)
        
        self.contentView.addConstraints([top, leading, height, width])
    }
    
    private func setupConstraintsNameLabel() {
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.nameLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        let leading = self.nameLabel.leadingAnchor.constraint(equalTo: self.avatarImageView.trailingAnchor, constant: 16)
        let trailing = self.contentView.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor, constant: 16)
        
        self.contentView.addConstraints([top, leading, trailing])
    }
    
    private func setupDescriptionLabel() {
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.descriptionLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 4)
        let leading = self.descriptionLabel.leadingAnchor.constraint(equalTo: self.nameLabel.leadingAnchor)
        let trailing = self.descriptionLabel.trailingAnchor.constraint(equalTo: self.nameLabel.trailingAnchor)
        let bottom = self.contentView.bottomAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16)
        
        self.contentView.addConstraints([top, leading, trailing, bottom])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        let color = self.avatarImageView.backgroundColor
        super.setSelected(selected, animated: animated)
        self.avatarImageView.backgroundColor = color
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        let color = self.avatarImageView.backgroundColor
        super.setHighlighted(highlighted, animated: animated)
        self.avatarImageView.backgroundColor = color
    }
    
    override func prepareForReuse() {
        self.avatarImageView.image = nil
    }

}

extension RepositoryCell: ViewModelConfigurable {
    
    func configure(viewModel: RepositoryViewModel) {
        let scheme = ColorScheme.default
        
        self.nameLabel.attributedText = NSAttributedString.string(
            with: viewModel.name,
            highlight: viewModel.searchText,
            font: self.nameLabel.font!,
            color: scheme.text,
            highlightColor: scheme.secondary)
        
        self.descriptionLabel.attributedText = NSAttributedString.string(
            with: viewModel.description,
            highlight: viewModel.searchText,
            font: self.descriptionLabel.font,
            color: scheme.text,
            highlightColor: scheme.secondary)

        self.avatarImageView.image(for: viewModel.imageURL)
    }
    
    func configure(viewModel: ViewModel) {
        guard let viewModel = viewModel as? RepositoryViewModel else { return }
        self.configure(viewModel: viewModel)
    }

}


