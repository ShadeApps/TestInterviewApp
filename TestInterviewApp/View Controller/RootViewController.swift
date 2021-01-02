//
//  RootViewController.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 22.12.2020.
//

import UIKit

final class RootViewController: UIViewController {
    
    private enum Constants {
        static let rowHeight = CGFloat(100)
    }
    
    private let centralSpinner = UIActivityIndicatorView(style: .large)
    private let tableView = UITableView()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        styleView()
        placeViews()
        setupTableView()
        
    }

}

extension RootViewController {
    
    private func styleView() {
        
        view.backgroundColor = .white
        
    }
    
    private func placeViews() {
        
        tableView.fill(parentView: self.view, useSafeAreaTop: true)
        
        centralSpinner.centerIn(view)
        centralSpinner.startAnimating()
        
    }
    
    private func setupTableView() {
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.rowHeight = Constants.rowHeight
        
        tableView.registerCell(BookTableCell.self)
        
        tableView.dataSource = self
        
    }
    
}

extension RootViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withClass: BookTableCell.self, for: indexPath)
        return cell
        
    }
    
}

