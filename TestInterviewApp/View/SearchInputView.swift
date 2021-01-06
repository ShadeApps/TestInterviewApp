//
//  SearchInputView.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 06.01.2021.
//

import UIKit

protocol SearchInputViewDelegate: class {
    
    func searchInputDidChange(sender: SearchInputView, text: String)
    
}

final class SearchInputView: UIView {
    
    static let height = CGFloat(50)
    
    weak var delegate: SearchInputViewDelegate?
    
    private var searchBar = UISearchBar()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        backgroundColor = .white
        placeViews()
    }
    
    required init?(coder: NSCoder) {
        
        fatalError("init(coder:) has not been implemented")
        
    }
    
    private func placeViews() {
        
        searchBar.fill(parentView: self)
        searchBar.placeholder = Localized.search.capitalized
        searchBar.delegate = self
        
    }
    
}

extension SearchInputView: UISearchBarDelegate {
    
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        guard !searchText.isEmpty, searchText.count > 2 else {
            return
        }
        
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        
        doAfter(0.5) { [weak self] in
            guard let self = self else { return }
            
            let searchTrimText = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
            if searchTrimText == text {
                self.delegate?.searchInputDidChange(sender: self, text: text)
            }
        }

    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        
        searchBar.setShowsCancelButton(true, animated: true)
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
        
    }
    
}
