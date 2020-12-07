//
//  CreditCardViewController.swift
//  CowPayExampleCode
//
//  Created by Mohamed on 12/7/20.
//

import UIKit
import CommonCrypto

class VisaViewController: UIViewController {

    let btnDismiss = UIButton()
    let imageViewPowerdBy = UIImageView()
    let viewData = UIView()
    let textFieldCardNumber = UITextField()
    let textFieldExp = UITextField()
    let textFieldCVV = UITextField()
    let viewErrorCard = UIView()
    let labelErrorCard = UILabel()
    let labelErrorExp = UILabel()
    let viewErrorExp = UIView()
    let labelErrorCVV = UILabel()
    let viewErrorCVV = UIView()
    let btnSaveCard = UIButton()
    let viewCard = UIView()
    let viewExp = UIView()
    let viewCVV = UIView()
    let btnMakePayment = UIButton()
    let viewLoading = UIView()
    let viewSucess = UIView()
    let viewError = UIView()
    let webView = UIWebView()
    
    var billingData = [String: String]()
    var dismissNav = false
    var previousTextFieldContent: String?
    var previousSelection: UITextRange?
    var screenTypeSave = false
    var baseUrl = ""
    var saveCard = false
    let bundle = Bundle(for: VisaViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textFieldCardNumber.becomeFirstResponder()
    }
    
    func initViews() {
        view.backgroundColor = .white
        initBackBtn()
        initPowerdBy()
        initViewData()
        initViewLoading()
        initViewSuccess()
        initViewError()
        initWebView()
        
        textFieldExp.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textFieldCardNumber.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textFieldCVV.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        if screenTypeSave {
            btnSaveCard.isHidden = true
            btnMakePayment.setTitle("Save", for: .normal)
        }
    }
    
    @objc func makePayment() {
        if checkData() {
            callApi()
        }
    }
    
    func checkData() -> Bool {
        textFieldCardNumber.resignFirstResponder()
        textFieldExp.resignFirstResponder()
        textFieldCVV.resignFirstResponder()
        if textFieldCardNumber.text!.count < 19 {
          return false
        } else if textFieldExp.text!.count < 7 {
            return false
        } else if textFieldCVV.text!.count < 3 {
            return false
        }
        return true
    }
    
    func callApi() {
        viewLoading.isHidden = false
        viewSucess.isHidden = true
        viewError.isHidden = true
        viewData.isHidden = true
        
        var cardNumber = textFieldCardNumber.text!
        cardNumber = cardNumber.replacingOccurrences(of: " ", with: "", options: NSString.CompareOptions.literal, range: nil)

        let startMonth = String.Index(encodedOffset: 0)
        let endMonth = String.Index(encodedOffset: 2)
        let month = String(textFieldExp.text![startMonth..<endMonth])
        
        let startYear = String.Index(encodedOffset: 5)
        let endYear = String.Index(encodedOffset: 7)
        let year = String(textFieldExp.text![startYear..<endYear])
        
        if screenTypeSave {
            var params = [String:String]()
            params.updateValue(billingData["merchant_code"]!, forKey: "merchant_code")
            params.updateValue(billingData["customer_merchant_profile_id"]!, forKey: "customer_merchant_profile_id")
            params.updateValue(cardNumber, forKey: "card_number")
            params.updateValue(month, forKey: "expiry_month")
            params.updateValue(year, forKey: "expiry_year")
            params.updateValue(textFieldCVV.text!, forKey: "cvv")
            params.updateValue("test", forKey: "customer_name")
            params.updateValue("01000000000", forKey: "customer_mobile")
            params.updateValue("test@test.test", forKey: "customer_email")
                        
            var request = URLRequest(url: URL(string: "\(baseUrl)fawry/generate-card-token")!)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                DispatchQueue.main.async {
                    self.viewLoading.isHidden = true
                }
                if data != nil {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                        if json["status_code"] as? Int ?? 0 == 200 {
                            DispatchQueue.main.async {
                                self.viewSucess.isHidden = false
                                self.btnDismiss.isHidden = true
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.viewError.isHidden = false
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.viewError.isHidden = false
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.viewError.isHidden = false
                    }
                }
            })
            
            task.resume()
        } else {
            var params = [String:String]()
            params.updateValue(billingData["merchant_code"]!, forKey: "merchant_code")
            params.updateValue(billingData["merchant_reference_id"]!, forKey: "merchant_reference_id")
            params.updateValue(billingData["customer_merchant_profile_id"]!, forKey: "customer_merchant_profile_id")
            params.updateValue("CARD", forKey: "payment_method")
            params.updateValue(cardNumber, forKey: "card_number")
            params.updateValue(month, forKey: "expiry_month")
            params.updateValue(year, forKey: "expiry_year")
            params.updateValue(textFieldCVV.text!, forKey: "cvv")
            if saveCard {
                params.updateValue("1", forKey: "save_card")
            } else {
                params.updateValue("0", forKey: "save_card")
            }
            params.updateValue(billingData["customer_name"]!, forKey: "customer_name")
            params.updateValue(billingData["customer_mobile"]!, forKey: "customer_mobile")
            params.updateValue(billingData["customer_email"]!, forKey: "customer_email")
            
            params.updateValue(String(format:"%.2f", Double(billingData["amount"]!) ?? 0.0), forKey: "amount")
            params.updateValue(billingData["currency_code"]!, forKey: "currency_code")
            params.updateValue(billingData["description"]!, forKey: "description")
            params.updateValue(billingData["charge_items"]!, forKey: "charge_items")
            params.updateValue(getSigniture(), forKey: "signature")
            
            var request = URLRequest(url: URL(string: "\(baseUrl)charge/card")!,timeoutInterval: Double.infinity)
            request.httpMethod = "POST"
            request.httpBody = try? JSONSerialization.data(withJSONObject: params, options: [])
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("Bearer \(billingData["token"]!)", forHTTPHeaderField: "Authorization")
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: { data, response, error -> Void in
                DispatchQueue.main.async {
                    self.viewLoading.isHidden = true
                }
                if data != nil {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data!) as! Dictionary<String, AnyObject>
                        if json["status_code"] as? Int ?? 0 == 200 {
                            if json["three_d_secured"] as? Bool ?? false {
                                let url = "\(self.baseUrl)3d/sdk/load/\(json["cowpay_reference_id"] as? Int ?? 0)"
                                DispatchQueue.main.async {
                                    self.webView.isHidden = false
                                    var request = URLRequest(url: URL(string:url)!)
                                    request.httpShouldHandleCookies = true
                                    
                                    HTTPCookieStorage.shared.cookieAcceptPolicy = .always
                                    
                                    self.webView.loadRequest(request)
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.viewSucess.isHidden = false
                                    self.btnDismiss.isHidden = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                        self.backHome()
                                    }
                                }
                            }
                        } else {
                            DispatchQueue.main.async {
                                self.viewError.isHidden = false
                            }
                        }
                    } catch {
                        DispatchQueue.main.async {
                            self.viewError.isHidden = false
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        self.viewError.isHidden = false
                    }
                }
            })
            
            task.resume()
        }
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
    
    @objc func backHome() {
        CowPaySDK.delegateCowPayDelegate?.transactionAccepted(paymentMethod: .visa, paymentData: "")
        dismiss(animated: true, completion: nil)
    }
}

extension VisaViewController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == textFieldCardNumber {
            if textField.text!.count < 19 {
                labelErrorCard.isHidden = false
                viewErrorCard.isHidden = false
                viewCard.layer.borderColor = UIColor.SDKErrorColor.cgColor
            }
        } else if textField == textFieldExp {
            if textField.text!.count < 7 {
                labelErrorExp.isHidden = false
                viewErrorExp.isHidden = false
                viewExp.layer.borderColor = UIColor.SDKErrorColor.cgColor
            }
        } else if textField == textFieldCVV {
            if textField.text!.count < 3 {
                labelErrorCVV.isHidden = false
                viewErrorCVV.isHidden = false
                viewCVV.layer.borderColor = UIColor.SDKErrorColor.cgColor
            }
        }
    }

    @objc public func textFieldDidChange(_ textField: UITextField) {
        if textField == textFieldCardNumber {
            let card = validateNumber(str: textFieldCardNumber.text!)
            textFieldCardNumber.text = card
            if card.count == 19 {
                labelErrorCard.isHidden = true
                viewErrorCard.isHidden = true
                viewCard.layer.borderColor = UIColor.SDKSubTitleColor.cgColor
                textFieldExp.becomeFirstResponder()
            }
            var targetCursorPosition = 0
            if let startPosition = textField.selectedTextRange?.start {
                targetCursorPosition = textField.offset(from: textField.beginningOfDocument, to: startPosition)
            }

            var cardNumberWithoutSpaces = ""
            if let text = textField.text {
                cardNumberWithoutSpaces = self.removeNonDigits(string: text, andPreserveCursorPosition: &targetCursorPosition)
            }

            if cardNumberWithoutSpaces.count > 16 {
                textField.text = previousTextFieldContent
                textField.selectedTextRange = previousSelection
                return
            }

            let cardNumberWithSpaces = self.insertCreditCardSpaces(cardNumberWithoutSpaces, preserveCursorPosition: &targetCursorPosition)
            textField.text = cardNumberWithSpaces

            if let targetPosition = textField.position(from: textField.beginningOfDocument, offset: targetCursorPosition) {
                textField.selectedTextRange = textField.textRange(from: targetPosition, to: targetPosition)
            }
        } else if textField == textFieldExp {
            var month = validateNumber(str: textFieldExp.text!)
            textFieldExp.text = month
            if month.last == Character(" ") {
                if month.count == 1 || month.count == 2 || month.count == 6 || month.count == 7 {
                    textField.text?.removeLast()
                    month.removeLast()
                }
            }
            if month.count == 7 {
                let start = String.Index(encodedOffset: 5)
                let end = String.Index(encodedOffset: 7)
                let year = String(month[start..<end])

                if Int(year)! < 19 {
                    textField.text?.removeLast(2)
                    textField.text!.append("19")
                }
                labelErrorExp.isHidden = true
                viewErrorExp.isHidden = true
                viewExp.layer.borderColor = UIColor.SDKSubTitleColor.cgColor
                textFieldCVV.becomeFirstResponder()
            } else if month.count == 2 {
                if Int(month)! > 12 {
                    textFieldExp.text = "12"
                }
                if month == "00" {
                    textFieldExp.text = "01"
                }
            } else if month.count == 1 {
                if Int(month)! > 1 {
                    textFieldExp.text = "0\(month)"
                }
            }
        } else if textField == textFieldCVV {
            let cvv = validateNumber(str: textFieldCVV.text!)
            textFieldCVV.text = cvv
            if cvv.count > 3 {
                textFieldCVV.text!.removeLast()
            }
            if cvv.count == 3 {
                labelErrorCVV.isHidden = true
                viewErrorCVV.isHidden = true
                viewCVV.layer.borderColor = UIColor.SDKSubTitleColor.cgColor
            }
        }
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if (isBackSpace == -92) {
                if textField == textFieldExp {
                    if textField.text!.last == Character(" ") {
                        textField.text?.removeLast(3)
                    }
                    if textField.text?.count == 1 {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                            self.textFieldCardNumber.becomeFirstResponder()
                        }
                    }
                }
                if textField == textFieldCVV {
                    if textField.text?.count == 1 {
                        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.01) {
                            self.textFieldExp.becomeFirstResponder()
                        }
                    }
                }
            }
        }
        if textField == textFieldCardNumber {
            previousTextFieldContent = textField.text
            previousSelection = textField.selectedTextRange
        }
        if textField == textFieldExp {
            if range.length > 0 {
                return true
            }
            if string == "" {
                return false
            }
            if range.location > 6 {
                return false
            }
            var originalText = textField.text
            let replacementText = string.replacingOccurrences(of: " ", with: "")

            //Verify entered text is a numeric value
            if !CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: replacementText)) {
                return false
            }

            //Put / after 2 digit
            if range.location == 2 {
                originalText?.append(" / ")
                textField.text = originalText
            }
        }
        return true
    }

    func removeNonDigits(string: String, andPreserveCursorPosition cursorPosition: inout Int) -> String {
        var digitsOnlyString = ""
        let originalCursorPosition = cursorPosition

        for i in Swift.stride(from: 0, to: string.count, by: 1) {
            let characterToAdd = string[string.index(string.startIndex, offsetBy: i)]
            if characterToAdd >= "0" && characterToAdd <= "9" {
                digitsOnlyString.append(characterToAdd)
            }
            else if i < originalCursorPosition {
                cursorPosition -= 1
            }
        }

        return digitsOnlyString
    }

    func insertCreditCardSpaces(_ string: String, preserveCursorPosition cursorPosition: inout Int) -> String {
        // Mapping of card prefix to pattern is taken from
        // https://baymard.com/checkout-usability/credit-card-patterns

        // UATP cards have 4-5-6 (XXXX-XXXXX-XXXXXX) format
        let is456 = string.hasPrefix("1")

        // These prefixes reliably indicate either a 4-6-5 or 4-6-4 card. We treat all these
        // as 4-6-5-4 to err on the side of always letting the user type more digits.
        let is465 = [
            // Amex
            "34", "37",

            // Diners Club
            "300", "301", "302", "303", "304", "305", "309", "36", "38", "39"
            ].contains { string.hasPrefix($0) }

        // In all other cases, assume 4-4-4-4-3.
        // This won't always be correct; for instance, Maestro has 4-4-5 cards according
        // to https://baymard.com/checkout-usability/credit-card-patterns, but I don't
        // know what prefixes identify particular formats.
        let is4444 = true
        //            !(is456 || is465)

        var stringWithAddedSpaces = ""
        let cursorPositionInSpacelessString = cursorPosition

        for i in 0..<string.count {
            let needs465Spacing = false
            //                (is465 && (i == 4 || i == 10 || i == 15))
            let needs456Spacing = false
            //                (is456 && (i == 4 || i == 9 || i == 15))
            let needs4444Spacing = (is4444 && i > 0 && (i % 4) == 0)

            if needs465Spacing || needs456Spacing || needs4444Spacing {
                stringWithAddedSpaces.append(" ")

                if i < cursorPositionInSpacelessString {
                    cursorPosition += 1
                }
            }

            let characterToAdd = string[string.index(string.startIndex, offsetBy:i)]
            stringWithAddedSpaces.append(characterToAdd)
        }

        return stringWithAddedSpaces
    }

    func validateNumber(str: String) -> String {
        var dotCounter = 0
        var string = str
        string  = string.replacingOccurrences(of: ",", with: "")
        for s in string {
            if s == "٠" {
                string.removeLast()
                string.append("0")
            } else if s == "١" {
                string.removeLast()
                string.append("1")
            } else if s == "٢" {
                string.removeLast()
                string.append("2")
            } else if s == "٣" {
                string.removeLast()
                string.append("3")
            } else if s == "٤" {
                string.removeLast()
                string.append("4")
            } else if s == "٥" {
                string.removeLast()
                string.append("5")
            } else if s == "٦" {
                string.removeLast()
                string.append("6")
            } else if s == "٧" {
                string.removeLast()
                string.append("7")
            } else if s == "٨" {
                string.removeLast()
                string.append("8")
            } else if s == "٩" {
                string.removeLast()
                string.append("9")
            } else if s != "0" && s != "1" && s != "2" && s != "3" && s != "4" && s != "5" && s != "6" && s != "7" && s != "8" && s != "9" && s != "."  && s != " "  && s != "/" {
                string.removeLast()
            } else if s == "." {
                dotCounter += 1
            }
        }
        if dotCounter > 1 {
            string.removeLast()
        }
        //        string = getNumberFormat(number: string)
        return string
    }
}

extension VisaViewController: UIWebViewDelegate {
    
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebView.NavigationType) -> Bool {
        if let query = request.url?.query {
            let arr = query.components(separatedBy: "&")
            if arr.count > 0 {
                for item in arr {
                    let arr2 = item.components(separatedBy: "=")
                    if arr2[0].lowercased() == "payment_done" {
                        for item2 in arr {
                            let arr3 = item2.components(separatedBy: "=")
                            if arr3[0].lowercased() == "payment_status" {
                                if arr3[1].lowercased() == "paid" {
                                    DispatchQueue.main.async {
                                        self.viewSucess.isHidden = false
                                        self.btnDismiss.isHidden = true
                                        self.webView.isHidden = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                            self.backHome()
                                        }
                                    }
                                } else {
                                    DispatchQueue.main.async {
                                        self.viewError.isHidden = false
                                        self.webView.isHidden = true
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        return true
    }
}
