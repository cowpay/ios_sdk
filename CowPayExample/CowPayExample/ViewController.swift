//
//  ViewController.swift
//  CowPayExampleCode
//
//  Created by Mohamed on 12/3/20.
//

import UIKit
import CowPay

class ViewController: UIViewController {

    let cowPaySdk = CowPaySDK()
    let apiMerchantCode = ""
    let apiMerchantHashKey = ""
    let billingData = ["customer_mobile":"01234567891",
                       "customer_email":"example@gmail.com",
                       "customer_merchant_profile_id":"15",
                       "merchant_reference_id":String(UUID().uuidString.split(separator: "-").first!),
                       "amount":"1"]
    
    let token = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func creditCard(_ sender: Any) {
        cowPaySdk.presentPay(viewController: self, apiMerchantCode: apiMerchantCode, apiMerchantHashKey: apiMerchantHashKey, billingData: billingData, token: token, paymentMethods: [.visa], isLive: false)
    }
    
    @IBAction func fawry(_ sender: Any) {
        cowPaySdk.presentPay(viewController: self, apiMerchantCode: apiMerchantCode, apiMerchantHashKey: apiMerchantHashKey, billingData: billingData, token: token, paymentMethods: [.fawry], isLive: false)
    }
    
    @IBAction func CreditCardAndFawry(_ sender: Any) {
        cowPaySdk.presentPay(viewController: self, apiMerchantCode: apiMerchantCode, apiMerchantHashKey: apiMerchantHashKey, billingData: billingData, token: token, paymentMethods: [.visa, .fawry], isLive: false)
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
