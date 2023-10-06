//
//  ImageCacheSingleton.swift
//  MarvelApp
//
//  Created by Juan david Lopera lopez on 6/10/23.
//

import Foundation
import UIKit

final class ImageCacheSingleton {
    
    // MARK: - Shared instance
    static let shared: ImageCacheSingleton = ImageCacheSingleton()
    
    // MARK: - Private Properties
    private let cacheImage: NSCache<NSString, UIImage> = NSCache<NSString, UIImage>()
    
    // MARK: - Private Init
    private init() {}
    
    
    // MARK: - Internal Functions
    func setImage(_ image: UIImage, for key: String) {
        cacheImage.setObject(image, forKey: key as NSString)
    }
    
    func getImage(for key: String) -> UIImage? {
        return cacheImage.object(forKey: key as NSString)
    }
}
