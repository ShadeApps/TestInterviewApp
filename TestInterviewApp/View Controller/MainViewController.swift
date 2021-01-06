//
//  MainViewController.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 22.12.2020.
//

import UIKit

final class MainViewController: UIViewController {
    
    private enum Constants {
        static let scrollOfsset = CGFloat(150)
    }
    
    internal var centralLoader = UIActivityIndicatorView(style: .large)
    internal var keyboardObserver = KeyboardObserver()
    internal var isLoadingData: Bool = false
    internal var dataProvider: Providable
    internal var viewModel: MainVCViewModel
    
    private let tableView = UITableView()
    
    // MARK: - Init
    init(dataProvider: Providable, viewModel: MainVCViewModel) {
        
        self.dataProvider = dataProvider
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        
    }

    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleView()
        placeViews()
        setupTableView()
        loadData(animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        keyboardObserving(start: true)
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        keyboardObserving(start: false)
        
    }

}

extension MainViewController: UIVCLayoutable {
    // MARK: - View set up
    internal func styleView() {
        
        view.backgroundColor = .white
        
    }
    
    internal func placeViews() {
        
        tableView.fill(parentView: self.view, useSafeAreaTop: true)
        
        centralLoader.centerIn(view)
        
    }
    
    private func setupTableView() {
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        
        tableView.registerCell(BookTableCell.self)
        tableView.registerCell(LoaderCell.self)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}

extension MainViewController: UILoadable {
    // MARK: - Loader UI
    internal func showLoader(_ show: Bool) {
        show ? centralLoader.startAnimating() : centralLoader.stopAnimating()
    }
    
}

extension MainViewController: Loadable {
    // MARK: - Data Loading Logic
    func loadData(animated: Bool) {
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
                
                if self.viewModel.nextPage.isSome {
                    self.viewModel.appendElements(items)
                } else {
                    self.viewModel.setElements(items)
                }
                
                self.viewModel.nextPage = data.nextPageToken ?? ""
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

extension MainViewController: UITableViewDataSource {
    // MARK: - Table View Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        viewModel.numberOfElements()
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch viewModel.elementAtIndex(indexPath) {
        
        case let model as BookCellViewModel:
            let cell = tableView.dequeueReusableCell(withClass: BookTableCell.self, for: indexPath)
            cell.layoutWith(model)
            return cell
        case is LoaderCellViewModel:
            return tableView.dequeueReusableCell(withClass: LoaderCell.self, for: indexPath)
        default:
            return UITableViewCell()
        }
        
    }
    
}

extension MainViewController: Paginatable, UITableViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        didScroll(scrollView)
        
    }
    
    func didScroll(_ scrollView: UIScrollView) {
        
        let difference = scrollView.contentSize.height - scrollView.frame.size.height - Constants.scrollOfsset
        
        let isReachingEnd = scrollView.contentOffset.y >= 0
            && scrollView.contentOffset.y >= difference

        guard isReachingEnd, let cursor = viewModel.nextPage, !cursor.isEmpty else { return }
        loadData(animated: false)
        
    }
    
    func resetCursor() {
        viewModel.nextPage = nil
    }
    
}

extension MainViewController: Keyboardable {

    func setupKeyboard() {
        let scrollView = tableView
        var edgeInsets =  UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: scrollView.contentInset.bottom, right: scrollView.contentInset.right)

        keyboardObserver.on(event: .willShow) { options in
            UIView.animate(withDuration: options.animationDuration, delay: 0.0, options: [options.animationOptions, .beginFromCurrentState], animations: {
                edgeInsets.bottom = options.frame.height
                scrollView.contentInset = edgeInsets
            })
        }

        keyboardObserver.on(event: .willHide) { options in
            UIView.animate(withDuration: options.animationDuration, delay: 0.0, options: [options.animationOptions, .beginFromCurrentState], animations: {
                edgeInsets.bottom = 0
                scrollView.contentInset = edgeInsets
            })
        }

        keyboardObserver.on(event: .willChangeFrame) { options in
            UIView.animate(withDuration: options.animationDuration, delay: 0.0, options: [options.animationOptions, .beginFromCurrentState], animations: {
                edgeInsets.bottom = options.frame.height
                scrollView.contentInset = edgeInsets
            })
        }
    }

    func keyboardObserving(start: Bool) {
        
        start ? keyboardObserver.start() : keyboardObserver.stop()
        
    }

}

