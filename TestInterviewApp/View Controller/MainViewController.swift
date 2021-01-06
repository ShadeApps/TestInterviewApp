//
//  MainViewController.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 22.12.2020.
//

import UIKit

final class MainViewController: UIViewController {
    
    internal enum Constants {
        static let scrollOfsset = CGFloat(150)
    }
    
    internal var centralLoader = UIActivityIndicatorView(style: .large)
    internal var keyboardObserver = KeyboardObserver()
    internal var isLoadingData: Bool = false
    internal var dataProvider: Providable
    internal var viewModel: MainVCViewModel
    
    internal let tableView = UITableView()
    internal let searchView = SearchInputView()
    
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
        setupKeyboard()
        loadData(animated: true, appending: false)
        
        searchView.delegate = self
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
        
        searchView.addTo(parentView: view, useSafeAreaTop: true, height: SearchInputView.height)
        tableView.addTo(parentView: view, below: searchView)
        
        centralLoader.centerIn(view)
        
    }
    
    private func setupTableView() {
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.keyboardDismissMode = .interactive
        
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


extension MainViewController: Keyboardable {

    func setupKeyboard() {
        
        let scrollView = tableView
        var edgeInsets = UIEdgeInsets(top: scrollView.contentInset.top, left: scrollView.contentInset.left, bottom: scrollView.contentInset.bottom, right: scrollView.contentInset.right)

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

