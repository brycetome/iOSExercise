//
//  ImageServiceTests.swift
//  iOSExercise
//
//  Created by Bryce Tome on 4/12/25.
//

import Testing
import Foundation

@testable import iOSExercise
import UIKit

@Suite(.serialized) struct ImageServiceTests {
    let fileManager = try? FileManager.default.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let imageData: Data = UIImage(named: "smallImage")!.jpegData(compressionQuality: 1)!
    let imageWebURL: String = "https://d3jbb8n5wk0qxi.cloudfront.net/photos/8b526c42-5121-4ddf-b8f9-a0c1153b5c20/small.jpg"
    
    init() throws {
        clearCache()
    }
    
    @Test func TestRetrieveImage() async throws {
        let retrievedImageData: Data? = await retrieveImage(urlString: imageWebURL)
        let equalizeCompression: Data? = UIImage(data: retrievedImageData!)!.jpegData(compressionQuality: 1)!
        #expect(equalizeCompression != nil && equalizeCompression == imageData)
    }
    
    @Test func TestGetImageWithCache() async throws {
        let path: URL = (fileManager?.appendingPathComponent("test.jpg"))!
        
        cacheImage(urlPath: path, imageData: imageData)
        
        let getImageData = await getImage(imageName: "test", urlString: "")
        #expect(getImageData != nil && getImageData == imageData)
    }
    
    @Test func TestGetImageWithNoCache() async throws {
        let getImageData = await getImage(imageName: "not-an-image", urlString: imageWebURL)
        let retrievedImageData: Data = await retrieveImage(urlString: imageWebURL)!
        #expect(getImageData == retrievedImageData)
    }
    
    @Test func TestTheCacheAfterGetImageWithNoCache() async throws {
        _ = await getImage(imageName: "new-image", urlString: imageWebURL)
        let path = fileManager!.appendingPathComponent("new-image.jpg")
        let cachedImage = try Data(contentsOf: path)
        
        let equalizeCompression: Data? = UIImage(data: cachedImage)!.jpegData(compressionQuality: 1)!

        #expect(equalizeCompression != nil && equalizeCompression == imageData)
    }
    
    @Test func TestGetImageCacheFailure() async throws {
        // Not sure how to force FileManager to fail
        // But we would expect to retrieve the image from the web
    }
}

