//
//  CowPay.swift
//  CowPayExample
//
//  Created by Mohamed Elmaazy on 5/30/19.
//  Copyright © 2019 Internet Plus. All rights reserved.
//

import Foundation
import UIKit

let statusBarHeight = UIApplication.shared.statusBarFrame.height

public protocol CowPaySDKDelegate {
    func missingData(_ error: String)
    func userDidCancel()
    func transactionAccepted(paymentMethod: PaymentType, paymentData: String)
}

public enum PaymentType {
    case fawry
    case visa
}

let baseUrlLive = "https://cowpay.me/api/v1/"

let baseUrlStaging = "https://staging.cowpay.me/api/v1/"

   //dev Url
//let baseUrlStaging = "https://dev.cowpay.me/api/v1/"

open class CowPaySDK {
    
    static var delegateCowPayDelegate: CowPaySDKDelegate?
    
    public init() {
        
    }
    
    open func presentPay(viewController: UIViewController, apiMerchantCode: String, apiMerchantHashKey: String, billingData: [String: String], token: String, paymentMethods: [PaymentType], isLive: Bool) {
        CowPaySDK.delegateCowPayDelegate = viewController as? CowPaySDKDelegate
        var enhancedBillingData = checkBillingData(billingData)
        enhancedBillingData?.updateValue(apiMerchantCode, forKey: "merchant_code")
        enhancedBillingData?.updateValue(apiMerchantHashKey, forKey: "secure_hash")
        enhancedBillingData?.updateValue(token, forKey: "token")
        switch paymentMethods {
        case []:
            CowPaySDK.delegateCowPayDelegate?.missingData("Missing payment methods, Please add it in biiling_data and try again")
            return
        case [.fawry]:
            let vc = FawryViewController()
            vc.billingData = enhancedBillingData!
            vc.baseUrl = isLive ? baseUrlLive : baseUrlStaging
            vc.dismissNav = true
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            nav.modalPresentationStyle = .fullScreen
            viewController.present(nav, animated: true, completion: nil)
            break
        case [.visa]:
            let vc = VisaViewController()
            vc.billingData = enhancedBillingData!
            vc.baseUrl = isLive ? baseUrlLive : baseUrlStaging
            vc.dismissNav = true
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            nav.modalPresentationStyle = .fullScreen
            viewController.present(nav, animated: true, completion: nil)
            break
        case [.visa, .fawry], [.fawry, .visa]:
            let vc = SelectMethodViewController()
            vc.billingData = enhancedBillingData!
            vc.baseUrl = isLive ? baseUrlLive : baseUrlStaging
            let nav = UINavigationController(rootViewController: vc)
            nav.isNavigationBarHidden = true
            nav.modalPresentationStyle = .fullScreen
            viewController.present(nav, animated: true, completion: nil)
            break
        default:
            CowPaySDK.delegateCowPayDelegate?.missingData("Missing payment methods, Please add it in biiling_data and try again")
            return
        }
    }
    
    open func presentSave(viewController: UIViewController, apiMerchantCode: String, customerMerchantProfileId: String, isLive: Bool) {
        CowPaySDK.delegateCowPayDelegate = viewController as? CowPaySDKDelegate
        var enhancedBillingData = [String: String]()
        enhancedBillingData.updateValue(apiMerchantCode, forKey: "merchant_code")
        enhancedBillingData.updateValue(customerMerchantProfileId, forKey: "customer_merchant_profile_id")
        let vc = VisaViewController()
        vc.billingData = enhancedBillingData
        vc.baseUrl = isLive ? baseUrlLive : baseUrlStaging
        vc.dismissNav = true
        vc.screenTypeSave = true
        let nav = UINavigationController(rootViewController: vc)
        nav.isNavigationBarHidden = true
        nav.modalPresentationStyle = .fullScreen
        viewController.present(nav, animated: true, completion: nil)
    }
    
    func checkBillingData(_ billingData: [String: String]) -> [String: String]? {
        var enhancedBillingData = billingData
        if enhancedBillingData["customer_name"] == nil {
            enhancedBillingData.updateValue("test", forKey: "customer_name")
        }
        if enhancedBillingData["customer_mobile"] == nil {
            enhancedBillingData.updateValue("01000000000", forKey: "customer_mobile")
        }
        if enhancedBillingData["customer_email"] == nil {
            enhancedBillingData.updateValue("test@test.test", forKey: "customer_email")
        }
        if enhancedBillingData["customer_merchant_profile_id"] == nil {
            CowPaySDK.delegateCowPayDelegate?.missingData("Missing customer_merchant_profile_id(user id), Please add it in biiling_data and try again")
            return nil
        }
        if enhancedBillingData["merchant_reference_id"] == nil {
            CowPaySDK.delegateCowPayDelegate?.missingData("Missing merchant_reference_id(order id), Please add it in biiling_data and try again")
            return nil
        }
        if enhancedBillingData["amount"] == nil {
            CowPaySDK.delegateCowPayDelegate?.missingData("Missing amount(order price), Please add it in biiling_data and try again")
            return nil
        }
        enhancedBillingData.updateValue("EGP", forKey: "currency_code")
        enhancedBillingData.updateValue("item details", forKey: "description")
        enhancedBillingData.updateValue("[{\"itemId\": \"1\", \"description\": \"description\",\"price\": \(String(format:"%.2f", Double(billingData["amount"]!) ?? 0.0)), \"quantity\": \"1\"}]", forKey: "charge_items")
        return enhancedBillingData
    }
}
