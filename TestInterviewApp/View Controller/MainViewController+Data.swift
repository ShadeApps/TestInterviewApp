//
//  MainViewController+Data.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 06.01.2021.
//

import UIKit

extension MainViewController: Loadable {
    // MARK: - Data Loading Logic
    func loadData(animated: Bool, appending: Bool) {
        //Getting concrete implementation of SearchResultsProvider type
        guard let dataProvider = dataProvider as? SearchResultsProvider else {
            return loadTestData()
        }
        
        guard !isLoadingData else { return }
        isLoadingData = true
        
        if animated {
            showLoader(true)
        }
        
        dataProvider.loadResults(matching: viewModel.searchQuery, next: viewModel.nextPage) { [weak self] result in
            guard let self = self else { return }
            
            self.showLoader(false)
            self.isLoadingData = false
            
            switch result {
            case .success(let data):
                
                let items = (data.items ?? []).map({ BookCellViewModel(searchResult: $0) })
                
                self.viewModel.nextPage = data.nextPageToken ?? ""
                
                if appending {
                    self.viewModel.appendElements(items)
                } else {
                    self.viewModel.setElements(items)
                }
                
                self.didLoadData()
                
            case .failure(let error):
                self.displayLoadError(error)
            }
        }
        
    }
    
    func didLoadData() {
        
        tableView.reloadData()
        
    }
    
    func displayLoadError(_ error: Error) {
        
        showAlert(title: error.localizedDescription)
        
    }
    
    private func loadTestData() {
        //Method for future tests on abstract type confroming to Providable protocol
    }
    
}

extension MainViewController: Paginatable, UITableViewDelegate {
    // MARK: - Pagination Logic
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        didScroll(scrollView)

    }

    func didScroll(_ scrollView: UIScrollView) {

        let difference = scrollView.contentSize.height - scrollView.frame.size.height - Constants.scrollOfsset

        let isReachingEnd = scrollView.contentOffset.y >= 0
            && scrollView.contentOffset.y >= difference

        guard isReachingEnd, let cursor = viewModel.nextPage, !cursor.isEmpty else { return }
        loadData(animated: false, appending: true)

    }

    func resetCursor() {

        viewModel.nextPage = nil
        tableView.setContentOffset(CGPoint(x: 0, y: -tableView.contentInset.top), animated: false)

    }
    
}

extension MainViewController: SearchInputViewDelegate {
    // MARK: - Search Logic
    func searchInputDidChange(sender: SearchInputView, text: String) {
        
        resetCursor()
        viewModel.searchQuery = text
        loadData(animated: true, appending: false)
        
    }
    
}
