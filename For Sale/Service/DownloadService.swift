//
//  DownloadService.swift
//  For Sale
//
//  Created by Duminica Octavian on 28/05/2018.
//  Copyright © 2018 Duminica Octavian. All rights reserved.
//

import Foundation

class DownloadService {
    private init() {}
    static let shared = DownloadService()
    
    func getImage(with urlString: String, completion: @escaping (URL) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, _, _) in
            let fileManager = FileManager.default
            
            guard let data = data,
                let documentsUrl = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
                else { return }
            
            let fileUrl = documentsUrl.appendingPathComponent("image.jpg")
            
            do {
                try data.write(to: fileUrl)
                DispatchQueue.main.async {
                    completion(url)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
