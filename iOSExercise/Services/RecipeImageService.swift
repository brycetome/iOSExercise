//
//  RecipeImageService.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//

import Foundation

public func clearCache(){
    let cacheURL =  FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!
    let fileManager = FileManager.default
    do {
        let directoryContents = try FileManager.default.contentsOfDirectory( at: cacheURL, includingPropertiesForKeys: nil, options: [])
        for file in directoryContents {
            do {
                try fileManager.removeItem(at: file)
            }
            catch let error as NSError {
                debugPrint("Something went wrong: \(error)")
            }

        }
    } catch let error as NSError {
        print(error.localizedDescription)
    }
}

public func getImage(imageName: String, urlString: String?) async -> Data? {
    var imageData: Data?
    
    guard let fileManager = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false) else { // might need to make last parameter true
        if let urlString = urlString {
            imageData = await retrieveImage(urlString: urlString)
        }
        return imageData
    }
        
    let path: URL = fileManager.appendingPathComponent("\(imageName).jpg")
        
    if let cachedImageData = try? Data(contentsOf: path) {
        imageData = cachedImageData
    } else if let urlString: String = urlString,
              let retImageData = await retrieveImage(urlString: urlString) {
        imageData = retImageData
        cacheImage(urlPath: path, imageData: retImageData)

    }
    
    return imageData
}

public func retrieveImage(urlString: String) async -> Data? {
    if let url = URL(string:  urlString),
       let (data, _) = try? await URLSession.shared.data(from: url) {
        return data
    }
    return nil
}

public func cacheImage(urlPath: URL, imageData: Data) {
    try? imageData.write(to: urlPath, options: .atomicWrite)
}
