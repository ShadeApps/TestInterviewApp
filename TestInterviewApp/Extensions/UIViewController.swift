//
//  UIViewController.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 06.01.2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String) {
        
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        alertController.addAction(UIAlertAction.init(title: Localized.ok, style: .cancel))
        
        present(alertController, animated: true)
        
    }
}
