//
//  ViewController.swift
//  CowPayExample
//
//  Created by Mohamed Elmaazy on 5/30/19.
//  Copyright © 2019 Internet Plus. All rights reserved.
//

import UIKit
import CowPay

class ViewController: UIViewController {

    let cawPaySdk = CowPaySDK()
    let apiMerchantCode = "dev1212"
    let apiMerchantHashKey = "dev1212"
    let billingData = ["customer_mobile":"01234567891",
                       "customer_email":"example@gmail.com",
                       "customer_merchant_profile_id":"15",
                       "merchant_reference_id":String(UUID().uuidString.split(separator: "-").first!),
                       "amount":"1"]
   
   
    let token = "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImYzZTc2M2ZlMzUyZGU1ZmViYzNhMzYxZTlkZTg0ZmQzOTUxN2QzZWQzYWRjYjJjOWY4Nzg2ZTMyYTM3OWMxZTQwNDE1YjEwYTk4ZmI4ZGRkIn0.eyJhdWQiOiI1IiwianRpIjoiZjNlNzYzZmUzNTJkZTVmZWJjM2EzNjFlOWRlODRmZDM5NTE3ZDNlZDNhZGNiMmM5Zjg3ODZlMzJhMzc5YzFlNDA0MTViMTBhOThmYjhkZGQiLCJpYXQiOjE2MDAxNjM0MTAsIm5iZiI6MTYwMDE2MzQxMCwiZXhwIjoxNjMxNjk5NDEwLCJzdWIiOiIxNyIsInNjb3BlcyI6W119.F_TF0ztB58x_d0xrVvAI1Sv116X_3WeZa3nKzgEglXTea6ofnUCIa-KT-KHQkb7u0n_sqJNz-ClzDBi-dshbCQ"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func creditCard(_ sender: Any) {
        cawPaySdk.presentPay(viewController: self, apiMerchantCode: apiMerchantCode, apiMerchantHashKey: apiMerchantHashKey, billingData: billingData, token: token, paymentMethods: [.visa], isLive: true)
    }
    
    @IBAction func fawry(_ sender: Any) {
        cawPaySdk.presentPay(viewController: self, apiMerchantCode: apiMerchantCode, apiMerchantHashKey: apiMerchantHashKey, billingData: billingData, token: token, paymentMethods: [.fawry], isLive: true)
    }
    
    @IBAction func CreditCardAndFawry(_ sender: Any) {
        cawPaySdk.presentPay(viewController: self, apiMerchantCode: apiMerchantCode, apiMerchantHashKey: apiMerchantHashKey, billingData: billingData, token: token, paymentMethods: [.visa, .fawry], isLive: true)
    }
    
    @IBAction func saveCard(_ sender: Any) {
        let userId = "2"
        cawPaySdk.presentSave(viewController: self, apiMerchantCode: apiMerchantCode, customerMerchantProfileId: userId, isLive: true)
    }
}

extension ViewController: CowPaySDKDelegate {
    
    func missingData(_ error: String) {
        print(error)
    }
    
    func userDidCancel() {
        print("userCancelld")
    }
    
    func transactionAccepted(paymentMethod: PaymentType, paymentData: String) {
        print(paymentData)
    }
}
