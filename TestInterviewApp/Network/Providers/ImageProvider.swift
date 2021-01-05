//
//  ImageProvider.swift
//  TestInterviewApp
//
//  Created by Sergey Grischyov on 05.01.2021.
//

import UIKit
import Combine

final class ImageProvider: Providable {
    
    private var cancellable: AnyCancellable?
    
    func cancel() {
        
        cancellable?.cancel()
        
    }
    
    func loadImage(withURL url: URL, completion: @escaping (UIImage?) -> Void) {
        //Combine is best enjoyed with Swift UI so we use ImageProvider
        //while also obscuring Combine inside our class to easily manage this dependency
        
        cancellable = load(for: url).sink { image in completion(image) }
        
    }
    
    private func load(for url: URL) -> AnyPublisher<UIImage?, Never> {
        
        Just(url)
            .flatMap({ poster -> AnyPublisher<UIImage?, Never> in
                ImageLoader.shared.loadImage(from: url)
            })
            .eraseToAnyPublisher()
        
    }
    
}
