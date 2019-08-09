//
//  RepositoryZeroView.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

class ReposiztoryZeroView: UIView {
    
    let titleLabel = UILabel()
    let imageView = UIImageView()
    let button = UIButton(type: .system)
    
    private let boxView = UIView()
    
    var actionHandler: VoidClosure?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    func commonInit() {
        self.addSubViews()
        self.setupConstraints()
        self.setup()
    }
    
    private func setup() {
        self.setupColors()
        
        self.titleLabel.numberOfLines = 0
        self.titleLabel.textAlignment = .center
        
        self.button.addTarget(self, action: #selector(self.buttonTapAction), for: .touchUpInside)
    }
    
    @objc private func buttonTapAction() {
        self.actionHandler?()
    }
    
    private func setupColors() {
        let scheme = ColorScheme.default
        
        self.titleLabel.textColor = scheme.text
        self.backgroundColor = scheme.background
        self.imageView.tintColor = scheme.text
        self.button.setTitleColor(scheme.secondary, for: .normal)
    }

    
    private func addSubViews() {
        self.addSubview(self.boxView)
        self.boxView.addSubview(self.titleLabel)
        self.boxView.addSubview(self.imageView)
        self.boxView.addSubview(self.button)
    }
    
    private func setupConstraints() {
        self.setupConstraintsBoxView()
        self.setupConstraintsImageView()
        self.setupConstraintsTitleLabel()
        self.setupConstraintsButton()
    }

    private func setupConstraintsBoxView() {
        self.boxView.translatesAutoresizingMaskIntoConstraints = false

        let centerGlobalX = self.boxView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let centerGlobalY = self.boxView.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        let width = self.boxView.leadingAnchor.constraint(greaterThanOrEqualTo: self.leadingAnchor, constant: 16)
        width.priority = .defaultHigh

        self.addConstraints([centerGlobalX, centerGlobalY, width])
    }

    private func setupConstraintsImageView() {
        self.imageView.translatesAutoresizingMaskIntoConstraints = false

        let top = self.imageView.topAnchor.constraint(equalTo: self.boxView.topAnchor)
        let centerX = self.imageView.centerXAnchor.constraint(equalTo: self.boxView.centerXAnchor)
        let leading = self.imageView.leadingAnchor.constraint(greaterThanOrEqualTo: self.boxView.leadingAnchor)
        
        self.addConstraints([centerX, top, leading])
    }

    private func setupConstraintsTitleLabel() {
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false

        let top = self.titleLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 16)
        let centerX = self.titleLabel.centerXAnchor.constraint(equalTo: self.imageView.centerXAnchor)
        let leading = self.titleLabel.leadingAnchor.constraint(greaterThanOrEqualTo: self.boxView.leadingAnchor)

        self.addConstraints([centerX, top, leading])
    }

    private func setupConstraintsButton() {
        self.button.translatesAutoresizingMaskIntoConstraints = false

        let top = self.button.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 8)
        let centerX = self.imageView.centerXAnchor.constraint(equalTo: self.button.centerXAnchor)
        let leading = self.button.leadingAnchor.constraint(greaterThanOrEqualTo: self.boxView.leadingAnchor)
        let bottom = self.boxView.bottomAnchor.constraint(equalTo: self.button.bottomAnchor)

        self.addConstraints([centerX, top, leading, bottom])
    }
    
}

extension ReposiztoryZeroView: ViewModelConfigurable {
    
    func configure(viewModel: ReposiztoryZeroViewModel) {
        self.titleLabel.text = viewModel.title
        self.imageView.image = UIImage(named: viewModel.image)
        self.button.setTitle(viewModel.suplimentary, for: .normal)
        self.button.isHidden = (viewModel.suplimentary ?? "").isEmpty
    }
    
    func configure(viewModel: ViewModel) {
        guard let viewModel = viewModel as? ReposiztoryZeroViewModel else { return }
        self.configure(viewModel: viewModel)
    }
    
}
