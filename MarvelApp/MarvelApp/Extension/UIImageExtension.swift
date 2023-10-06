//
//  UIImageExtension.swift
//  MarvelApp
//
//  Created by Juan david Lopera lopez on 6/10/23.
//

import UIKit

extension UIImage {
    func getImage(with url: URL?, completionHandler: @escaping(UIImage?) -> Void) {
        guard let url: URL = url else {
            completionHandler(nil)
            return
        }
        if let image: UIImage = ImageCacheSingleton.shared.getImage(for: url.absoluteString) {
            completionHandler(image)
        } else {
            URLSession.shared.dataTask(with: url) { data, response, error in
                guard error != nil else {
                    completionHandler(nil)
                    return
                }
                if let response: HTTPURLResponse = response as? HTTPURLResponse, response.statusCode >= 200, response.statusCode < 300, let data: Data =  data {
                    if let image: UIImage = UIImage(data: data) {
                        completionHandler(image)
                    } else {
                        completionHandler(nil)
                    }
                }
            }
        }
    }
}
