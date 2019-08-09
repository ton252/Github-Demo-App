//
//  SummuryErrorCell.swift
//  GitHub
//
//  Created by Anton Polyakov on 08.08.2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

final class SummaryErrorCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let iconImageView = UIImageView()
    
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
        self.setup()
    }
    
    private func setup() {
        self.selectedBackgroundView = UIView()
        self.setupColors()
    }
    
    private func setupColors() {
        let scheme = ColorScheme.default
        self.selectedBackgroundView?.backgroundColor = .clear
        self.titleLabel.textColor = scheme.text
        self.descriptionLabel.textColor = scheme.text
        self.iconImageView.tintColor = scheme.secondary
    }
    
    private func addSubviews() {
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.descriptionLabel)
        self.contentView.addSubview(self.iconImageView)
        
        self.titleLabel.numberOfLines = 1
        self.descriptionLabel.numberOfLines = 0
    }
    
    private func setupConstraints() {
        self.setupIconImageViewConstraints()
        self.setupConstraintsTitleLabel()
        self.setupDescriptionLabel()
    }
    
    func setupIconImageViewConstraints() {
        self.iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let centerY = self.iconImageView.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
        let leading = self.iconImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let height = self.iconImageView.heightAnchor.constraint(equalToConstant: 20)
        let width = self.iconImageView.widthAnchor.constraint(equalToConstant: 20)
        
        self.contentView.addConstraints([centerY, leading, height, width])
    }
    
    func setupConstraintsTitleLabel() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.titleLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        let leading = self.titleLabel.leadingAnchor.constraint(equalTo: self.iconImageView.trailingAnchor, constant: 16)
        let trailing = self.contentView.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor, constant: 16)
        
        self.contentView.addConstraints([top, leading, trailing])
    }
    
    func setupDescriptionLabel() {
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.descriptionLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 4)
        let leading = self.descriptionLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor)
        let trailing = self.descriptionLabel.trailingAnchor.constraint(equalTo: self.titleLabel.trailingAnchor)
        let bottom = self.contentView.bottomAnchor.constraint(equalTo: self.descriptionLabel.bottomAnchor, constant: 16)
        bottom.priority = .defaultHigh
        
        self.contentView.addConstraints([top, leading, trailing, bottom])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.contentView.alpha = selected ? 0.5 : 1.0
    }

    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.contentView.alpha = highlighted ? 0.5 : 1.0
    }
    
}

extension SummaryErrorCell: ViewModelConfigurable {

    func configure(viewModel: SummaryErrorViewModel) {
        self.titleLabel.text = viewModel.title
        self.descriptionLabel.text = viewModel.description
        self.iconImageView.image = UIImage(named: viewModel.image)
    }

    func configure(viewModel: ViewModel) {
        guard let viewModel = viewModel as? SummaryErrorViewModel else { return }
        self.configure(viewModel: viewModel)
    }

}
