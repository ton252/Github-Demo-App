//
//  TagsCollectionCell.swift
//  GitHub
//
//  Created by Anton Polyakov on 09.08.2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

final class TagsCollectionCell: UITableViewCell {
    
    private let flowLayout = UICollectionViewFlowLayout()
    
    private lazy var collectionView: UICollectionView = {
        return UICollectionView(frame: .zero, collectionViewLayout: self.flowLayout)
    }()
    
    private var tags: [String] = [] {
        didSet { self.reloadData() }
    }
    
    private static let reuseId = "cell"

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
        self.contentView.addSubview(self.collectionView)
    }
    
    private func setup() {
        self.setupColors()

        self.flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        self.flowLayout.scrollDirection = .horizontal
        
        self.collectionView.dataSource = self
        self.collectionView.showsHorizontalScrollIndicator = false
        self.collectionView.delaysContentTouches = true
        self.collectionView.canCancelContentTouches = true
        
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        self.collectionView.register(TagsCell.self, forCellWithReuseIdentifier: TagsCollectionCell.reuseId)
    }
    
    private func setupColors() {
        let scheme = ColorScheme.default
        self.backgroundColor = scheme.background
        self.collectionView.backgroundColor = scheme.background
    }
    
    private func setupConstraints() {
        self.setupConstraintsCollectionView()
    }
    
    private func setupConstraintsCollectionView() {
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.collectionView.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leading = self.collectionView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailing = self.contentView.trailingAnchor.constraint(equalTo: self.collectionView.trailingAnchor)
        let bottom = self.contentView.bottomAnchor.constraint(equalTo: self.collectionView.bottomAnchor)
        let height = self.collectionView.heightAnchor.constraint(equalToConstant: 60)
        bottom.priority = .defaultHigh

        self.contentView.addConstraints([top, leading, trailing, bottom, height])
    }
    
    func reloadData() {
        self.collectionView.reloadData()
    }
    
}

extension TagsCollectionCell: ViewModelConfigurable {
    
    func configure(viewModel: SummaryLanguagesViewModel) {
        self.tags = viewModel.languages
    }
    
    func configure(viewModel: ViewModel) {
        guard let viewModel = viewModel as? SummaryLanguagesViewModel else { return }
        self.configure(viewModel: viewModel)
    }
    
}

extension TagsCollectionCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagsCollectionCell.reuseId, for: indexPath) as! TagsCell
        
        let tag = self.tags[indexPath.row]
        cell.button.setTitle(tag, for: .normal)
        cell.button.sizeToFit()

        return cell
    }

}


fileprivate final class TagsCell: UICollectionViewCell {
    
    /// UIButton use to handle user actions in future.
    let button = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    private func commonInit() {
        self.setup()
        self.contentView.addSubview(self.button)
        self.setupConstraints()
    }
    
    private func setup() {
        self.setupColors()
        self.button.isUserInteractionEnabled = false
        self.button.clipsToBounds = true
        self.button.layer.cornerRadius = 8
        self.button.contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    func setupColors() {
        let scheme = ColorScheme.default
        self.button.setTitleColor(scheme.background, for: .normal)
        self.button.setBackgroundImage(UIImage(color: scheme.secondary), for: .normal)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.button.setTitle(nil, for: .normal)
    }
    
    private func setupConstraints() {
        self.setupConstraintsButton()
    }
    
    private func setupConstraintsButton() {
        self.button.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.button.topAnchor.constraint(equalTo: self.contentView.topAnchor)
        let leading = self.button.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        let trailing = self.contentView.trailingAnchor.constraint(equalTo: self.button.trailingAnchor)
        let bottom = self.contentView.bottomAnchor.constraint(equalTo: self.button.bottomAnchor)
        bottom.priority = .defaultHigh
        
        self.contentView.addConstraints([top, leading, trailing, bottom])
    }
    
}
