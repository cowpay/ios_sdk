//
//  FawryDesign.swift
//  CowPayExampleCode
//
//  Created by Mohamed on 12/6/20.
//

import Foundation
import UIKit

extension FawryViewController {
    
    func initBackBtn() {
//        btnDismiss.setImage(dismissNav ? #imageLiteral(resourceName: "cowPayClose") : #imageLiteral(resourceName: "cowPayBack"), for: .normal)
        btnDismiss.setImage(dismissNav ? UIImage.init(named: "close", in: bundle, compatibleWith: nil) : UIImage.init(named: "back", in: bundle, compatibleWith: nil), for: .normal)
        btnDismiss.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissNavFunc)))
        view.addSubview(btnDismiss)
        
        btnDismiss.translatesAutoresizingMaskIntoConstraints = false
        btnDismiss.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        btnDismiss.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        btnDismiss.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnDismiss.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    @objc func dismissNavFunc() {
        if dismissNav {
            CowPaySDK.delegateCowPayDelegate?.userDidCancel()
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
    
    func initPowerdBy() {
//        imageViewPowerdBy.image = #imageLiteral(resourceName: "cowPayLogo")
        imageViewPowerdBy.image = UIImage.init(named: "logo", in: bundle, compatibleWith: nil)
        imageViewPowerdBy.contentMode = .scaleAspectFit
        view.addSubview(imageViewPowerdBy)
        
        imageViewPowerdBy.translatesAutoresizingMaskIntoConstraints = false
        imageViewPowerdBy.center = view.center
        imageViewPowerdBy.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        imageViewPowerdBy.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        imageViewPowerdBy.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let label = UILabel()
        label.text = "Powerd by"
        label.textColor = .SDKPowerdByColor
        label.font = UIFont.systemFont(ofSize: 10.0)

        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: imageViewPowerdBy.centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: imageViewPowerdBy.leadingAnchor, constant: -8).isActive = true
    }
    
    func initFawryImage() {
//        imageViewFawry.image = #imageLiteral(resourceName: "cowPayFawry")
        imageViewFawry.image = UIImage.init(named: "fawry", in: bundle, compatibleWith: nil)
        view.addSubview(imageViewFawry)
        
        imageViewFawry.translatesAutoresizingMaskIntoConstraints = false
        imageViewFawry.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40).isActive = true
        imageViewFawry.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        imageViewFawry.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
        imageViewFawry.heightAnchor.constraint(equalTo: imageViewFawry.widthAnchor).isActive = true
    }
    
    func initViewLoading() {
        viewLoading.backgroundColor = .clear
        view.addSubview(viewLoading)
        
        viewLoading.translatesAutoresizingMaskIntoConstraints = false
        viewLoading.topAnchor.constraint(equalTo: imageViewFawry.bottomAnchor, constant: 8).isActive = true
        viewLoading.bottomAnchor.constraint(equalTo: imageViewPowerdBy.topAnchor, constant: -8).isActive = true
        viewLoading.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.startAnimating()
        viewLoading.addSubview(indicator)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.centerXAnchor.constraint(equalTo: viewLoading.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: viewLoading.centerYAnchor, constant: -20).isActive = true
        
        let labelWait = UILabel()
        labelWait.textColor = .white
        labelWait.text = "Please wait"
        labelWait.font = UIFont.systemFont(ofSize: 20.0)
        labelWait.textAlignment = .center
        viewLoading.addSubview(labelWait)
        
        labelWait.translatesAutoresizingMaskIntoConstraints = false
        labelWait.topAnchor.constraint(equalTo: indicator.bottomAnchor, constant: 20).isActive = true
        labelWait.leadingAnchor.constraint(equalTo: viewLoading.leadingAnchor, constant: 20).isActive = true
        labelWait.trailingAnchor.constraint(equalTo: viewLoading.trailingAnchor, constant: -20).isActive = true
    }
    
    func initViewSuccess() {
        viewSuccess.backgroundColor = .clear
        view.addSubview(viewSuccess)
        
        viewSuccess.translatesAutoresizingMaskIntoConstraints = false
        viewSuccess.topAnchor.constraint(equalTo: imageViewFawry.bottomAnchor, constant: 8).isActive = true
        viewSuccess.bottomAnchor.constraint(equalTo: imageViewPowerdBy.topAnchor, constant: -8).isActive = true
        viewSuccess.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let backgroundImage = UIImageView()
//        backgroundImage.image = #imageLiteral(resourceName: "cowPayFawry_bg")
        backgroundImage.image = UIImage.init(named: "fawry_bg", in: bundle, compatibleWith: nil)
        backgroundImage.isUserInteractionEnabled = true
        backgroundImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(copyCode)))
        viewSuccess.addSubview(backgroundImage)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.centerXAnchor.constraint(equalTo: viewSuccess.centerXAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: viewSuccess.topAnchor, constant: 8).isActive = true
//        backgroundImage.widthAnchor.constraint(equalTo: viewSuccess.widthAnchor, multiplier: 0.75).isActive = true
//        backgroundImage.heightAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 1).isActive = true
        
        let labelTitle = UILabel()
        labelTitle.text = "You can pay the required amount"
        labelTitle.textColor = .SDKTitleColor
        labelTitle.font = UIFont.systemFont(ofSize: 12.0)
        labelTitle.textAlignment = .center
        viewSuccess.addSubview(labelTitle)
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.topAnchor.constraint(equalTo: backgroundImage.topAnchor, constant: 30).isActive = true
        labelTitle.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 20).isActive = true
        labelTitle.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -20).isActive = true
        
        labelPrice.textAlignment = .center
        viewSuccess.addSubview(labelPrice)
        
        labelPrice.translatesAutoresizingMaskIntoConstraints = false
        labelPrice.topAnchor.constraint(equalTo: labelTitle.bottomAnchor, constant: 16).isActive = true
        labelPrice.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor, constant: 20).isActive = true
        labelPrice.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor, constant: -20).isActive = true
        labelPrice.setSpecificAttributes(texts: [String(format:"%.2f", Double(billingData["amount"]!) ?? 0.0), "LE"], fonts: [UIFont.systemFont(ofSize: 42.0), UIFont.systemFont(ofSize: 17.0)], colors: [.SDKTitleColor, .SDKSubTitleColor])
        
        let labelCopy = UILabel()
        labelCopy.text = "Copy this number to use it while paying"
        labelCopy.textColor = .SDKSubTitleColor
        labelCopy.font = UIFont.systemFont(ofSize: 10.0)
        labelCopy.textAlignment = .center
        viewSuccess.addSubview(labelCopy)
        
        labelCopy.translatesAutoresizingMaskIntoConstraints = false
        labelCopy.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: -25).isActive = true
        labelCopy.centerXAnchor.constraint(equalTo: backgroundImage.centerXAnchor, constant: 8).isActive = true
        
        let imageViewCopy = UIImageView()
//        imageViewCopy.image = #imageLiteral(resourceName: "cowPayInfo")
        imageViewCopy.image = UIImage.init(named: "info", in: bundle, compatibleWith: nil)
        viewSuccess.addSubview(imageViewCopy)
        
        imageViewCopy.translatesAutoresizingMaskIntoConstraints = false
        imageViewCopy.centerYAnchor.constraint(equalTo: labelCopy.centerYAnchor).isActive = true
        imageViewCopy.trailingAnchor.constraint(equalTo: labelCopy.leadingAnchor, constant: -8).isActive = true
        
        labelNumber.textColor = .SDKTitleColor
        labelNumber.backgroundColor = .SDKPriceBackgroundColor
        labelNumber.textAlignment = .center
        labelNumber.text = "236 5733 6576 23"
        labelNumber.font = UIFont.systemFont(ofSize: 24.0)
        viewSuccess.addSubview(labelNumber)
        
        labelNumber.translatesAutoresizingMaskIntoConstraints = false
        labelNumber.bottomAnchor.constraint(equalTo: labelCopy.topAnchor, constant: -15).isActive = true
        labelNumber.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor).isActive = true
        labelNumber.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor).isActive = true
        labelNumber.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let labelTitle2 = UILabel()
        labelTitle2.textColor = .SDKTitleColor
        labelTitle2.textAlignment = .center
        labelTitle2.text = "Through Fawry machine, invoice number:"
        labelTitle2.font = UIFont.systemFont(ofSize: 12.0)
        viewSuccess.addSubview(labelTitle2)
        
        labelTitle2.translatesAutoresizingMaskIntoConstraints = false
        labelTitle2.bottomAnchor.constraint(equalTo: labelNumber.topAnchor, constant: -15).isActive = true
        labelTitle2.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor).isActive = true
        labelTitle2.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor).isActive = true
        
        let btnFinish = UIButton()
        btnFinish.setTitleColor(.white, for: .normal)
        btnFinish.backgroundColor = .SDKPowerdByColor
        btnFinish.setTitle("Finish", for: .normal)
        btnFinish.titleLabel!.font = UIFont.systemFont(ofSize: 14.0)
        btnFinish.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(finish)))
        btnFinish.layer.cornerRadius = 8
        viewSuccess.addSubview(btnFinish)
        
        btnFinish.translatesAutoresizingMaskIntoConstraints = false
        btnFinish.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 20).isActive = true
        btnFinish.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor).isActive = true
        btnFinish.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor).isActive = true
        btnFinish.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    @objc func copyCode() {
        UIPasteboard.general.string = labelNumber.text
        let alert = UIAlertController(title: "", message: "Copied", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func finish() {
        CowPaySDK.delegateCowPayDelegate?.transactionAccepted(paymentMethod: .fawry, paymentData: labelNumber.text ?? "error in retriving number")
        dismiss(animated: true, completion: nil)
    }
    
    func initViewError() {
        viewError.backgroundColor = .clear
        view.addSubview(viewError)
        
        viewError.translatesAutoresizingMaskIntoConstraints = false
        viewError.topAnchor.constraint(equalTo: imageViewFawry.bottomAnchor, constant: 8).isActive = true
        viewError.bottomAnchor.constraint(equalTo: imageViewPowerdBy.topAnchor, constant: -8).isActive = true
        viewError.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let backgroundImage = UIImageView()
//        backgroundImage.image = #imageLiteral(resourceName: "cowPayFawry_error_bg")
        backgroundImage.image = UIImage.init(named: "fawry_error_bg", in: bundle, compatibleWith: nil)
        viewError.addSubview(backgroundImage)
        
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.centerXAnchor.constraint(equalTo: viewError.centerXAnchor).isActive = true
        backgroundImage.topAnchor.constraint(equalTo: viewError.topAnchor, constant: 8).isActive = true
        backgroundImage.widthAnchor.constraint(equalTo: viewError.widthAnchor, multiplier: 0.75).isActive = true
        backgroundImage.heightAnchor.constraint(equalTo: backgroundImage.widthAnchor, multiplier: 0.6).isActive = true
        
        
        labelError.text = "Oops, Something went wrong"
        labelError.textColor = .SDKErrorColor
        labelError.font = UIFont.systemFont(ofSize: 16.0)
        labelError.textAlignment = .center
        labelError.numberOfLines = 0
        viewError.addSubview(labelError)
        
        labelError.translatesAutoresizingMaskIntoConstraints = false
        labelError.topAnchor.constraint(equalTo: backgroundImage.bottomAnchor, constant: 25).isActive = true
        labelError.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor).isActive = true
        labelError.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor).isActive = true
        
        let btnRetry = UIButton()
        btnRetry.setTitleColor(.SDKErrorColor, for: .normal)
        btnRetry.backgroundColor = .clear
        btnRetry.setTitle("Try again", for: .normal)
//        btnRetry.setImage(#imageLiteral(resourceName: "cowPayRepeat"), for: .normal)
        btnRetry.setImage(UIImage.init(named: "repeat", in: bundle, compatibleWith: nil), for: .normal)
        btnRetry.titleEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        btnRetry.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        btnRetry.titleLabel!.font = UIFont.systemFont(ofSize: 14.0)
        btnRetry.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(retry)))
        btnRetry.layer.cornerRadius = 8
        btnRetry.layer.borderColor = UIColor.SDKErrorColor.cgColor
        btnRetry.layer.borderWidth = 1
        viewError.addSubview(btnRetry)
        
        btnRetry.translatesAutoresizingMaskIntoConstraints = false
        btnRetry.topAnchor.constraint(equalTo: labelError.bottomAnchor, constant: 20).isActive = true
        btnRetry.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor).isActive = true
        btnRetry.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor).isActive = true
        btnRetry.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    @objc func retry() {
        callApi()
    }
}

extension UILabel {
    
    func setSpecificAttributes(texts: [String], fonts: [UIFont]?, colors: [UIColor]?) {
        var main = ""
        var ranges = [NSRange]()
        for sub in texts {
            main += sub
            ranges.append((main as NSString).range(of: sub))
        }
        let attribute = NSMutableAttributedString.init(string: main)
        
        if fonts != nil {
            for (i, font) in fonts!.enumerated() {
                attribute.addAttribute(NSAttributedString.Key.font, value: font, range: ranges[i])
            }
        }
        
        if colors != nil {
            for (i, color) in colors!.enumerated() {
                attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: ranges[i])
            }
        }
        self.attributedText = attribute
    }
}
