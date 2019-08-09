//
//  SummaryCell.swift
//  GitHub
//
//  Created by Anton Polyakov on 08/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

final class SummaryCell: UITableViewCell {
    
    let contentLabel = UILabel()

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

    private func addSubviews() {
        self.contentView.addSubview(self.contentLabel)
    }
    
    private func setup() {
        self.setupColors()
        
        self.contentLabel.font = .systemFont(ofSize: 16)
        self.contentLabel.numberOfLines = 0
        self.selectionStyle = .none
    }
    
    private func setupColors() {
        let scheme = ColorScheme.default
        self.contentLabel.textColor = scheme.text
        self.backgroundColor = scheme.background
    }

    private func setupConstraints() {
        self.setupConstraintsContentLabel()
    }

    func setupConstraintsContentLabel() {
        self.contentLabel.translatesAutoresizingMaskIntoConstraints = false

        let top = self.contentLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16)
        let leading = self.contentLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailing = self.contentView.trailingAnchor.constraint(equalTo: self.contentLabel.trailingAnchor, constant: 16)
        let bottom = self.contentView.bottomAnchor.constraint(equalTo: self.contentLabel.bottomAnchor, constant: 16)
        bottom.priority = .defaultHigh

        self.contentView.addConstraints([top, leading, trailing, bottom])
    }
    
}

extension SummaryCell: ViewModelConfigurable {

    func configure(viewModel: SummaryContentViewModel) {
        self.contentLabel.text = viewModel.text
    }

    func configure(viewModel: ViewModel) {
        guard let viewModel = viewModel as? SummaryContentViewModel else { return }
        self.configure(viewModel: viewModel)
    }

}
