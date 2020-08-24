//
//  ViewController.swift
//  Example
//
//  Created by Mohamed on 8/19/20.
//  Copyright © 2020 InternetPlus. All rights reserved.
//

import UIKit
import CowPay

class ViewController: UIViewController {

    let cawPaySdk = CowPaySDK()
    let apiMerchantCode = "GHIu9nk25D5e"
    let apiMerchantHashKey = "$2y$10$IcVQiqt7dm4LEAWaNYfo4uYpv8H9qzjnnCfv9VUDO8QkGkej1KmLa"
    let billingData = ["customer_mobile":"01234567891",
                       "customer_email":"example@gmail.com",
                       "customer_merchant_profile_id":"15",
                       "merchant_reference_id":"14",
                       "amount":"780"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func creditCard(_ sender: Any) {
        cawPaySdk.presentPay(viewController: self, apiMerchantCode: apiMerchantCode, apiMerchantHashKey: apiMerchantHashKey, billingData: billingData, paymentMethods: [.visa])
    }
    
    @IBAction func fawry(_ sender: Any) {
        cawPaySdk.presentPay(viewController: self, apiMerchantCode: apiMerchantCode, apiMerchantHashKey: apiMerchantHashKey, billingData: billingData, paymentMethods: [.fawry])
    }
    
    @IBAction func CreditCardAndFawry(_ sender: Any) {
        cawPaySdk.presentPay(viewController: self, apiMerchantCode: apiMerchantCode, apiMerchantHashKey: apiMerchantHashKey, billingData: billingData, paymentMethods: [.visa, .fawry])
    }
    
    @IBAction func saveCard(_ sender: Any) {
        let userId = "2"
        cawPaySdk.presentSave(viewController: self, apiMerchantCode: apiMerchantCode, customerMerchantProfileId: userId)
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
