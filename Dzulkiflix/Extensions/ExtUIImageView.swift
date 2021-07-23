//
//  ExtUIImageView.swift
//  Dzulkiflix
//
//  Created by Apple on 22/07/21.
//

import Foundation
import UIKit

extension UIImageView {
    func load(url: String) {
        let imageUrl:URL = URL(string: url)!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: imageUrl) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
