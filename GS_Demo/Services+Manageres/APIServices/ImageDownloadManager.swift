//
//  ImageManager.swift
//  GS_Demo
//
//  Created by Nikunj Joshi on 20/07/22.
//

import Foundation
import UIKit

// MARK: - ImageLoader

final class ImageManager {

    static let shared = ImageManager()

    private var imagesDownloadTasks: [String: URLSessionDataTask]
    
    let serialQueueForImages = DispatchQueue(label: "images.queue", attributes: .concurrent)
    let serialQueueForDataTasks = DispatchQueue(label: "dataTasks.queue", attributes: .concurrent)

    // MARK: Private init
    private init() {
        imagesDownloadTasks = [:]
    }

     /**
    Downloads and returns images through the completion closure to the caller
     - Parameter imageUrlString: The remote URL to download images from
     - Parameter completionHandler: A completion handler which returns two parameters. First one is an image which may or may
     not be cached and second one is a bool to indicate whether we returned the cached version or not
     - Parameter placeholderImage: Placeholder image to display as we're downloading them from the server
     */
    func downloadImage(with imageUrlString: String?,
                       completionHandler: @escaping (UIImage?, Bool) -> Void,
                       placeholderImage: UIImage?) {
        
        guard let imageUrlString = imageUrlString,
              let url = URL(string: imageUrlString) else {
                  completionHandler(placeholderImage, true)
                  return
              }
        
        let urlRequest = URLRequest(url: url)
        
        self.serialQueueForImages.sync(flags: .barrier) {
            if let image = try? self.getImageFromFileStorage(for: urlRequest) {
                completionHandler(image, true)
                return
            }
        }
        
        if getExistingDownloadTask(urlString: imageUrlString) != nil {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                return
            }
            
            if let _ = error {
                DispatchQueue.main.async {
                    completionHandler(placeholderImage, true)
                }
                return
            }
            
            let image = UIImage(data: data)
            
            DispatchQueue.main.async {
                completionHandler(image, false)
            }
            
            self.serialQueueForImages.sync(flags: .barrier) {
                self.saveImage(image: image, urlRequest: urlRequest) { _ in }
            }
            
            _ = self.serialQueueForDataTasks.sync(flags: .barrier) {
                self.imagesDownloadTasks.removeValue(forKey: imageUrlString)
            }

        }
        
        self.serialQueueForDataTasks.sync(flags: .barrier) {
            imagesDownloadTasks[imageUrlString] = task
        }
        
        task.resume()
    }

    private func getExistingDownloadTask(urlString: String) -> URLSessionTask? {
        serialQueueForDataTasks.sync {
            return imagesDownloadTasks[urlString]
        }
    }
    
    private func fileName(for urlRequest: URLRequest) -> URL? {
        guard let fileName = urlRequest.url?.lastPathComponent.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
                  return nil
              }
        let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        return documents.appendingPathComponent(fileName)
    }

    private func getImageFromFileStorage(for urlRequest: URLRequest) throws -> UIImage? {
        guard let url = fileName(for: urlRequest) else {
            assertionFailure("Unable to generate a local path for \(urlRequest)")
            return nil
        }
        
        let image = UIImage(contentsOfFile: url.path)
        return image
    }
    
    private func saveImage(image: UIImage?, urlRequest: URLRequest, completion: @escaping ((String?) -> Void)) {
        
        guard let url = fileName(for: urlRequest) else {
            completion(nil)
            return
        }

            if let data = image?.pngData() {
                do {
                    try data.write(to: url)
                    completion(url.absoluteString)
                } catch {
                    completion(nil)
                }
            }
    }
}
