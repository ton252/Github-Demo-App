//
//  SummuryShimmeringCell.swift
//  GitHub
//
//  Created by Anton Polyakov on 08.08.2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

final class SummaryShimmeringCell: UITableViewCell {
    
    let firstLineView = UIView()
    let secondLineView = UIView()
    
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
        self.contentView.addSubview(self.firstLineView)
        self.contentView.addSubview(self.secondLineView)
    }
    
    private func setup() {
        self.selectionStyle = .none
        
        self.firstLineView.clipsToBounds = true
        self.secondLineView.clipsToBounds = true
        
        self.firstLineView.layer.cornerRadius = 8.0
        self.secondLineView.layer.cornerRadius = 8.0
        
        self.setupColors()
    }
    
    private func setupColors() {
        let scheme = ColorScheme.default
        self.firstLineView.backgroundColor = scheme.separator
        self.secondLineView.backgroundColor = scheme.separator
    }
    
    private func setupConstraints() {
        self.setupConstraintsFirstLineView()
        self.setupConstraintsSecondLineView()
    }
    
    func setupConstraintsFirstLineView() {
        self.firstLineView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.firstLineView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 14)
        let leading = self.firstLineView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailing = self.contentView.trailingAnchor.constraint(equalTo: self.firstLineView.trailingAnchor, constant: 16)
        let height = self.firstLineView.heightAnchor.constraint(equalToConstant: 20.0)
        
        self.contentView.addConstraints([top, leading, trailing, height])
    }
    
    func setupConstraintsSecondLineView() {
        self.secondLineView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.secondLineView.topAnchor.constraint(equalTo: self.firstLineView.bottomAnchor, constant: 12)
        let leading = self.secondLineView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16)
        let trailing = self.contentView.trailingAnchor.constraint(equalTo: self.secondLineView.trailingAnchor, constant: 16)
        let bottom = self.contentView.bottomAnchor.constraint(equalTo: self.secondLineView.bottomAnchor, constant: 14)
        let height = self.secondLineView.heightAnchor.constraint(equalToConstant: 20.0)
        bottom.priority = .defaultHigh
        
        self.contentView.addConstraints([top, leading, trailing, bottom, height])
    }
    
}

extension SummaryShimmeringCell: ViewModelConfigurable {
    
    func configure(viewModel: ViewModel) {
    }
    
}
