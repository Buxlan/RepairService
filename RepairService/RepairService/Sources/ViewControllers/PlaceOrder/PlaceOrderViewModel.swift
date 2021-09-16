//
//  PlaceOrderViewModel.swift
//  RepairService
//
//  Created by  Buxlan on 9/16/21.
//

import UIKit

struct PlaceOrderViewModel: Codable {
    
    // MARK: - Properties
    var address: String?
    var companyName: String?
    var phoneNumber: String?
    var email: String?
    var isCompany: Bool = false
    
    var device: String?
    var brokeDescription: String?
    
    // MARK: - Init
    init() {
        
    }
    
    // MARK: - Helper functions
    func save() {
        let encoder = JSONEncoder()
        guard let data = try? encoder.encode(self),
              let url = try? FileManager.default.url(for: .documentDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil, create: true) else {
            print("Issues with saving file with order data")
            return
        }
        let fullUrl = url.appendingPathComponent("orderData.json")
        do {
            try data.write(to: fullUrl)
        } catch {
            print("Error while writing data into file: \(error.localizedDescription)")
        }
    }
    
    mutating func restore() {
        guard let url = try? FileManager.default.url(for: .documentDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil, create: true)
                .appendingPathComponent("orderData.json"),
              let data = try? Data(contentsOf: url),
              let model = try? JSONDecoder().decode(PlaceOrderViewModel.self, from: data) else {
            print("Issues with restoring file with order data")
            return
        }
        self = model
    }
    
    func getMailBody() -> String {
        let body = """
                    Phone: \(phoneNumber ?? "")
                    Company name: \(companyName ?? "")
                    Address: \(address ?? "")
                    E-mail: \(email ?? "")
                    Is company: \(isCompany)
                    Device model: \(device ?? "")
                    Broke description: \(brokeDescription ?? "")
                    """
        return body
    }
}
