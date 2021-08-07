// ImageLoader.swift
// Copyright © Roadmap. All rights reserved.

import UIKit

final class ImageLoader {
    private var imagesDictionary: [URL: UIImage] = [:]

    func getImage(url: URL) -> UIImage? {
        imagesDictionary[url]
    }

    func setImage(url: URL, image: UIImage?) {
        imagesDictionary[url] = image
    }
}
