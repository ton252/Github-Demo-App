//
//  RepositoriesRepositoriesViewController.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

class RepositoriesViewController: BaseViewController {

    var output: RepositoriesViewOutput!
    
    let tableView = UITableView()
    let searchBar = UISearchBar()
    let zeroView = ReposiztoryZeroView()
    
    private var bottomKeyboard: NSLayoutConstraint!
    
    override var bindBottomToKeyboardFrame: NSLayoutConstraint? {
        return self.bottomKeyboard
    }

    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.tableView)
        self.view.addSubview(self.zeroView)
        self.view.addSubview(self.searchBar)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bindToKeyboardNotifications()
        self.setupConstraints()
        
        self.setupColors()
        self.setupSearchBar()
        self.setupTableView()
        self.setupZeroView()
        
        self.output.viewDidLoad()
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.keyboardDismissMode = .interactive

        self.tableView.register(cellType: RepositoryCell.self)
    }
    
    private func setupSearchBar() {
        self.searchBar.delegate = self
    }
    
    private func setupZeroView() {
        self.zeroView.isHidden = true
        self.zeroView.actionHandler = { [weak self] in self?.output.retry() }
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapAction))
        self.zeroView.addGestureRecognizer(tap)
    }
    
    private func setupColors() {
        let scheme = ColorScheme.default
        self.view.backgroundColor = scheme.background
        
        self.searchBar.isTranslucent = false
        self.searchBar.barTintColor = scheme.primary
    }
    
    @objc private func tapAction() {
        self.searchBar.endEditing(true)
    }
    
    deinit {
        self.unbindFromKeyboardNotifications()
    }
    
}

// MARK: - Layout

extension RepositoriesViewController {
    
    func setupConstraints() {
        self.setupSearchBarViewConstraints()
        self.setupTableViewConstraints()
        self.setupZeroViewConstraints()
    }
    
    func setupSearchBarViewConstraints() {
        self.searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.searchBar.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leading = self.searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailing = self.view.trailingAnchor.constraint(equalTo: self.searchBar.trailingAnchor)
        
        self.view.addConstraints([top, leading, trailing])
    }
    
    func setupTableViewConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.tableView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor)
        let leading = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailing = self.view.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor)
        let bottom = self.view.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor)
        
        self.view.addConstraints([top, leading, trailing, bottom])
    }
    
    func setupZeroViewConstraints() {
        self.zeroView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.zeroView.topAnchor.constraint(equalTo: self.searchBar.bottomAnchor)
        let leading = self.zeroView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailing = self.view.trailingAnchor.constraint(equalTo: self.zeroView.trailingAnchor)
        let bottom = self.view.bottomAnchor.constraint(equalTo: self.zeroView.bottomAnchor)
        
        self.bottomKeyboard = bottom
        
        self.view.addConstraints([top, leading, trailing, bottom])
    }
    
}

// MARK: - RepositoriesViewInput 

extension RepositoriesViewController: RepositoriesViewInput {
    
    func reloadData() {
        self.zeroView.isHidden = true
        self.tableView.reloadData()
    }
    
    func reloadZero(viewModel: ReposiztoryZeroViewModel) {
        self.zeroView.isHidden = false
        self.zeroView.configure(viewModel: viewModel)
        self.tableView.reloadData()
    }
    
    func set(title: String) {
        self.title = title
    }
    
}

extension RepositoriesViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.output.search(text: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)  {
        self.view.endEditing(true)
    }
    
}

extension RepositoriesViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.output.viewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(cellType: RepositoryCell.self, for: indexPath)
        
        if let cell = cell as? ViewModelConfigurable {
            cell.configure(viewModel: self.output.viewModels[indexPath.row])
        }
        
        return cell
    }

}

extension RepositoriesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.output.didSelectRowAt(indexPath)
    }
    
}
