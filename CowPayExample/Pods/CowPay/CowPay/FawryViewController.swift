//
//  FawryViewController.swift
//  CowPayExampleCode
//
//  Created by Mohamed on 12/6/20.
//

import UIKit
import CommonCrypto

class FawryViewController: UIViewController {

    let btnDismiss = UIButton()
    let imageViewFawry = UIImageView()
    let imageViewPowerdBy = UIImageView()
    let viewLoading = UIView()
    let viewSuccess = UIView()
    let labelPrice = UILabel()
    let labelNumber = UILabel()
    let viewError = UIView()
    let labelError = UILabel()
    
    var billingData = [String: String]()
    var dismissNav = false
    var baseUrl = ""
    let bundle = Bundle(for: FawryViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    func initViews() {
        view.backgroundColor = .SDKFawryColor
        initBackBtn()
        initPowerdBy()
        initFawryImage()
        initViewLoading()
        initViewSuccess()
        initViewError()
        callApi()
    }
    
    func callApi() {
        viewLoading.isHidden = false
        viewSuccess.isHidden = true
        viewError.isHidden = true
        
        var params = [String:String]()
        params.updateValue(billingData["merchant_code"]!, forKey: "merchant_code")
        params.updateValue(billingData["merchant_reference_id"]!, forKey: "merchant_reference_id")
        params.updateValue(billingData["customer_merchant_profile_id"]!, forKey: "customer_merchant_profile_id")
        params.updateValue(billingData["customer_name"]!, forKey: "customer_name")
        params.updateValue(billingData["customer_mobile"]!, forKey: "customer_mobile")
        params.updateValue(billingData["customer_email"]!, forKey: "customer_email")
        params.updateValue("PAYATFAWRY", forKey: "payment_method")
        params.updateValue(String(format:"%.2f", Double(billingData["amount"]!) ?? 0.0), forKey: "amount")
        params.updateValue(billingData["currency_code"]!, forKey: "currency_code")
        params.updateValue(billingData["description"]!, forKey: "description")
        params.updateValue(billingData["charge_items"]!, forKey: "charge_items")
        params.updateValue(getSigniture(), forKey: "signature")
        
        var request = URLRequest(url: URL(string: "\(baseUrl)charge/fawry")!)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(billingData["token"]!)", forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
            if data != nil {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                    if json["status_code"] as? Int ?? 0 == 200 {
                        DispatchQueue.main.async {
                            self.viewSuccess.isHidden = false
                            self.viewLoading.isHidden = true
                            self.labelNumber.text = json["payment_gateway_reference_id"] as? String ?? "invalid fawry number from sdk"
                            self.btnDismiss.isHidden = true
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.viewLoading.isHidden = true
                            self.viewError.isHidden = false
                        }
                    }
                } catch {
                    print("error")
                }
            } else {
                DispatchQueue.main.async {
                    self.viewLoading.isHidden = true
                    self.viewError.isHidden = false
                }
            }
        })
        
        task.resume()
    }
//       secure_hash (provided in the merchant's dashboard at Cowpay)
    func getSigniture() -> String {
        let signiture = billingData["merchant_code"]! + billingData["merchant_reference_id"]! + billingData["customer_merchant_profile_id"]! + String(format:"%.2f", Double(billingData["amount"]!) ?? 0.0) + billingData["secure_hash"]!
        let SignitureData = sha256(data: signiture.data(using: .utf8)!)
        let signitureString = SignitureData.map { String(format: "%02hhx", $0) }.joined()
        return signitureString
    }
    
    func sha256(data : Data) -> Data {
        var hash = [UInt8](repeating: 0,  count: Int(CC_SHA256_DIGEST_LENGTH))
        data.withUnsafeBytes {
            _ = CC_SHA256($0.baseAddress, CC_LONG(data.count), &hash)
        }
        return Data(hash)
    }
}
