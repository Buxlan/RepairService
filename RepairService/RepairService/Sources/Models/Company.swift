//
//  Company.swift
//  RepairService
//
//  Created by  Buxlan on 9/16/21.
//

import UIKit

struct Company: Codable {
    var displayName: String?
    var phoneNumber: String?
    var descriptionFileName: String?
    var emailTo: String?
}

extension Company {
    static func getCurrentCompany() -> Company {
        guard let url = Bundle.main.url(forResource: "company", withExtension: "json"),
              let data = try? Data(contentsOf: url),
              let company = try? JSONDecoder().decode(Company.self, from: data) else {
            return Company()
        }
        return company
    }
}
