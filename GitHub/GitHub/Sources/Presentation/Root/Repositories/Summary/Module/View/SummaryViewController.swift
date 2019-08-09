//
//  SummarySummaryViewController.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

typealias CellMaper = (ViewModel) -> UITableViewCell.Type

class SummaryViewController: BaseViewController {

    var output: SummaryViewOutput!
    
    let tableView = UITableView(frame: .zero, style: .grouped)

    // MARK: - Life cycle
    
    override func loadView() {
        super.loadView()
        self.view.addSubview(self.tableView)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupConstraints()
        self.setupColors()
        self.registerCells()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    
        self.output.viewDidLoad()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        //self.tableView.frame = CGRect(origin: .zero, size: self.view.frame.size)
    }
    
    private func registerCells() {
        self.tableView.register(cellType: SummaryCell.self)
        self.tableView.register(cellType: SummaryShimmeringCell.self)
        self.tableView.register(cellType: SummaryErrorCell.self)
        self.tableView.register(cellType: TagsCollectionCell.self)
    }
    
    private func setupColors() {
        let scheme = ColorScheme.default
        self.view.backgroundColor = scheme.background
    }
    
    func setupConstraints() {
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor)
        let leading = self.tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        let trailing = self.view.trailingAnchor.constraint(equalTo: self.tableView.trailingAnchor)
        let bottom = self.view.bottomAnchor.constraint(equalTo: self.tableView.bottomAnchor)
        
        self.view.addConstraints([top, leading, trailing, bottom])
    }

}

// MARK: - SummaryViewInput 

extension SummaryViewController: SummaryViewInput {
    
    func intializeData() {
        self.title = self.output.summary.name
        self.tableView.reloadData()
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    func reloadRows(at indexPath: IndexPath) {
        self.tableView.reloadRows(at: [indexPath], with: .automatic)
    }

}

// MARK: - UITableViewDataSource

extension SummaryViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.output.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.output.sections[section].viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = self.output.sections[indexPath.section].viewModels[indexPath.row]
        let cellType = self.map(viewModel: viewModel)
        
        let cell = self.tableView.dequeueReusableCell(cellType: cellType, for: indexPath)
        
        if let cell = cell as? ViewModelConfigurable {
            cell.configure(viewModel: viewModel)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.output.sections[section].title
    }
    
    fileprivate func map(viewModel: ViewModel) -> UITableViewCell.Type {
        switch viewModel {
        case is SummaryContentViewModel:
            return SummaryCell.self
        case is SummaryShimmeringViewModel:
            return SummaryShimmeringCell.self
        case is SummaryErrorViewModel:
            return SummaryErrorCell.self
        case is SummaryLanguagesViewModel:
            return TagsCollectionCell.self
        default:
            fatalError("Type not defined!")
        }
    }
    
}

extension SummaryViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        self.output.didSelectRow(at: indexPath)
    }
    
}
