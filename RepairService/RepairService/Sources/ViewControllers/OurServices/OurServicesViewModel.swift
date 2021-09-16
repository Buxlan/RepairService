//
//  OurServicesViewModel.swift
//  RepairService
//
//  Created by  Buxlan on 9/16/21.
//

import UIKit

struct OurServicesViewModel {
    lazy var items: [Service] = {
        getItems()
    }()
    
    private func getItems() -> [Service] {
        guard let url = Bundle.main.url(forResource: "services", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let items = try? JSONDecoder().decode([Service].self, from: data) else {
            return [Service]()
        }
        return items
    }
    
    mutating func image(at index: Int) -> UIImage {
        let imageName = items[index].imageName
        if let image = UIImage(named: imageName) {
            return image.resizeImage(to: 40)
        }
        return UIImage()
    }
    
}
