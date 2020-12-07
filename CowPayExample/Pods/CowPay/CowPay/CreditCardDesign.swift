//
//  CreditCardDesign.swift
//  CowPayExampleCode
//
//  Created by Mohamed on 12/7/20.
//

import Foundation
import UIKit

extension VisaViewController {
    
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
    
    func initViewData() {
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: btnDismiss.bottomAnchor, constant: 8).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: imageViewPowerdBy.topAnchor, constant: -8).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let viewInside = UIView()
        scrollView.addSubview(viewInside)
        
        viewInside.translatesAutoresizingMaskIntoConstraints = false
        viewInside.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        viewInside.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        viewInside.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        viewInside.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        viewInside.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let constraint = viewInside.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        constraint.priority = UILayoutPriority(250)
        constraint.isActive = true
        
        viewInside.addSubview(viewData)

        viewData.translatesAutoresizingMaskIntoConstraints = false
        viewData.topAnchor.constraint(equalTo: viewInside.topAnchor).isActive = true
        viewData.bottomAnchor.constraint(equalTo: viewInside.bottomAnchor).isActive = true
        viewData.leadingAnchor.constraint(equalTo: viewInside.leadingAnchor).isActive = true
        viewData.trailingAnchor.constraint(equalTo: viewInside.trailingAnchor).isActive = true
        initViewDataContent()
    }
    
    func initViewDataContent() {
        let labelAddNewCard = UILabel()
        labelAddNewCard.textColor = .SDKTitleColor
        labelAddNewCard.text = "Add a new card"
        labelAddNewCard.font = UIFont.systemFont(ofSize: 18.0)
        viewData.addSubview(labelAddNewCard)
        
        labelAddNewCard.translatesAutoresizingMaskIntoConstraints = false
        labelAddNewCard.topAnchor.constraint(equalTo: viewData.topAnchor, constant: 8).isActive = true
        labelAddNewCard.leadingAnchor.constraint(equalTo: viewData.leadingAnchor, constant: 20).isActive = true
        
        let labelEnterCardData = UILabel()
        labelEnterCardData.textColor = .SDKSubTitleColor
        labelEnterCardData.text = "Enter your credit or debit card details"
        labelEnterCardData.font = UIFont.systemFont(ofSize: 13.0)
        viewData.addSubview(labelEnterCardData)
        
        labelEnterCardData.translatesAutoresizingMaskIntoConstraints = false
        labelEnterCardData.topAnchor.constraint(equalTo: labelAddNewCard.bottomAnchor, constant: 8).isActive = true
        labelEnterCardData.leadingAnchor.constraint(equalTo: labelAddNewCard.leadingAnchor).isActive = true
        
        initCardNumberViews(labelEnterCardData)
        initExpiryAndCVVViews()
    }
    
    func initCardNumberViews(_ labelEnterCardData: UILabel) {
        let labelCardNumber = UILabel()
        labelCardNumber.textColor = .SDKSubTitleColor
        labelCardNumber.text = "Card number"
        labelCardNumber.font = UIFont.systemFont(ofSize: 13.0)
        viewData.addSubview(labelCardNumber)
        
        labelCardNumber.translatesAutoresizingMaskIntoConstraints = false
        labelCardNumber.topAnchor.constraint(equalTo: labelEnterCardData.bottomAnchor, constant: 36).isActive = true
        labelCardNumber.leadingAnchor.constraint(equalTo: labelEnterCardData.leadingAnchor).isActive = true
        
        labelErrorCard.textColor = .white
        labelErrorCard.text = "Invalid card number"
        labelErrorCard.font = UIFont.systemFont(ofSize: 11.0)
        viewData.addSubview(labelErrorCard)
        
        labelErrorCard.translatesAutoresizingMaskIntoConstraints = false
        labelErrorCard.centerYAnchor.constraint(equalTo: labelCardNumber.centerYAnchor).isActive = true
        labelErrorCard.trailingAnchor.constraint(equalTo: viewData.trailingAnchor, constant: -28).isActive = true
        
        viewErrorCard.backgroundColor = .SDKErrorColor
        viewErrorCard.layer.cornerRadius = 4
        viewData.insertSubview(viewErrorCard, belowSubview: labelErrorCard)
        viewErrorCard.isHidden = true
        
        viewErrorCard.translatesAutoresizingMaskIntoConstraints = false
        viewErrorCard.leadingAnchor.constraint(equalTo: labelErrorCard.leadingAnchor, constant: -8).isActive = true
        viewErrorCard.trailingAnchor.constraint(equalTo: labelErrorCard.trailingAnchor, constant: 8).isActive = true
        viewErrorCard.topAnchor.constraint(equalTo: labelErrorCard.topAnchor, constant: -8).isActive = true
        viewErrorCard.bottomAnchor.constraint(equalTo: labelErrorCard.bottomAnchor, constant: 8).isActive = true
        
        viewCard.layer.cornerRadius = 4
        viewCard.layer.borderColor = UIColor.SDKSubTitleColor.cgColor
        viewCard.layer.borderWidth = 1
        viewData.addSubview(viewCard)
        
        viewCard.translatesAutoresizingMaskIntoConstraints = false
        viewCard.leadingAnchor.constraint(equalTo: labelCardNumber.leadingAnchor).isActive = true
        viewCard.trailingAnchor.constraint(equalTo: viewErrorCard.trailingAnchor).isActive = true
        viewCard.topAnchor.constraint(equalTo: viewErrorCard.bottomAnchor, constant: 4).isActive = true
        viewCard.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        textFieldCardNumber.placeholder = "0000 0000 0000 0000"
        textFieldCardNumber.font = UIFont.systemFont(ofSize: 14)
        textFieldCardNumber.borderStyle = .none
        textFieldCardNumber.delegate = self
        viewCard.addSubview(textFieldCardNumber)
        
        textFieldCardNumber.translatesAutoresizingMaskIntoConstraints = false
        textFieldCardNumber.leadingAnchor.constraint(equalTo: viewCard.leadingAnchor, constant: 4).isActive = true
        textFieldCardNumber.trailingAnchor.constraint(equalTo: viewErrorCard.trailingAnchor, constant: -4).isActive = true
        textFieldCardNumber.topAnchor.constraint(equalTo: viewCard.topAnchor).isActive = true
        textFieldCardNumber.bottomAnchor.constraint(equalTo: viewCard.bottomAnchor).isActive = true
    }
    
    func initExpiryAndCVVViews() {
        let labelExpiry = UILabel()
        labelExpiry.textColor = .SDKSubTitleColor
        labelExpiry.text = "Exp. Date"
        labelExpiry.font = UIFont.systemFont(ofSize: 13.0)
        viewData.addSubview(labelExpiry)
        
        labelExpiry.translatesAutoresizingMaskIntoConstraints = false
        labelExpiry.topAnchor.constraint(equalTo: textFieldCardNumber.bottomAnchor, constant: 20).isActive = true
        labelExpiry.leadingAnchor.constraint(equalTo: textFieldCardNumber.leadingAnchor, constant: -4).isActive = true
        
        viewExp.layer.cornerRadius = 4
        viewExp.layer.borderColor = UIColor.SDKSubTitleColor.cgColor
        viewExp.layer.borderWidth = 1
        
        viewCVV.layer.cornerRadius = 4
        viewCVV.layer.borderColor = UIColor.SDKSubTitleColor.cgColor
        viewCVV.layer.borderWidth = 1
        viewData.addSubview(viewExp)
        viewData.addSubview(viewCVV)
        
        viewExp.translatesAutoresizingMaskIntoConstraints = false
        viewCVV.translatesAutoresizingMaskIntoConstraints = false
        viewExp.topAnchor.constraint(equalTo: labelExpiry.bottomAnchor, constant: 8).isActive = true
        viewExp.leadingAnchor.constraint(equalTo: labelExpiry.leadingAnchor).isActive = true
        viewCVV.trailingAnchor.constraint(equalTo: textFieldCardNumber.trailingAnchor, constant: 4).isActive = true
        viewCVV.leadingAnchor.constraint(equalTo: viewExp.trailingAnchor, constant: 8).isActive = true
        viewExp.heightAnchor.constraint(equalTo: viewCVV.heightAnchor).isActive = true
        viewExp.widthAnchor.constraint(equalTo: viewCVV.widthAnchor).isActive = true
        viewCVV.heightAnchor.constraint(equalToConstant: 40).isActive = true
        viewCVV.centerYAnchor.constraint(equalTo: viewExp.centerYAnchor).isActive = true
        
        textFieldExp.placeholder = "MM / YY"
        textFieldExp.font = UIFont.systemFont(ofSize: 14)
        textFieldExp.borderStyle = .none
        textFieldExp.delegate = self
        viewExp.addSubview(textFieldExp)

        textFieldExp.translatesAutoresizingMaskIntoConstraints = false
        textFieldExp.leadingAnchor.constraint(equalTo: viewExp.leadingAnchor, constant: 4).isActive = true
        textFieldExp.trailingAnchor.constraint(equalTo: viewExp.trailingAnchor, constant: -4).isActive = true
        textFieldExp.topAnchor.constraint(equalTo: viewExp.topAnchor).isActive = true
        textFieldExp.bottomAnchor.constraint(equalTo: viewExp.bottomAnchor).isActive = true
        
        labelErrorExp.textColor = .white
        labelErrorExp.text = "Invalid Exp. Date"
        labelErrorExp.font = UIFont.systemFont(ofSize: 11.0)
        viewData.addSubview(labelErrorExp)
        
        labelErrorExp.translatesAutoresizingMaskIntoConstraints = false
        labelErrorExp.centerYAnchor.constraint(equalTo: labelExpiry.centerYAnchor).isActive = true
        labelErrorExp.trailingAnchor.constraint(equalTo: viewExp.trailingAnchor, constant: -4).isActive = true
        
        
        viewErrorExp.backgroundColor = .SDKErrorColor
        viewErrorExp.layer.cornerRadius = 4
        viewErrorExp.isHidden = true
        viewData.insertSubview(viewErrorExp, belowSubview: labelErrorExp)
        
        viewErrorExp.translatesAutoresizingMaskIntoConstraints = false
        viewErrorExp.leadingAnchor.constraint(equalTo: labelErrorExp.leadingAnchor, constant: -4).isActive = true
        viewErrorExp.trailingAnchor.constraint(equalTo: labelErrorExp.trailingAnchor, constant: 4).isActive = true
        viewErrorExp.topAnchor.constraint(equalTo: labelErrorExp.topAnchor, constant: -8).isActive = true
        viewErrorExp.bottomAnchor.constraint(equalTo: labelErrorExp.bottomAnchor, constant: 8).isActive = true
        
        let labelCVV = UILabel()
        labelCVV.textColor = .SDKSubTitleColor
        labelCVV.text = "CVV"
        labelCVV.font = UIFont.systemFont(ofSize: 13.0)
        viewData.addSubview(labelCVV)
        
        labelCVV.translatesAutoresizingMaskIntoConstraints = false
        labelCVV.centerYAnchor.constraint(equalTo: labelExpiry.centerYAnchor).isActive = true
        labelCVV.leadingAnchor.constraint(equalTo: viewCVV.leadingAnchor).isActive = true
        
        textFieldCVV.placeholder = "123"
        textFieldCVV.font = UIFont.systemFont(ofSize: 14)
        textFieldCVV.borderStyle = .none
        textFieldCVV.delegate = self
        viewCVV.addSubview(textFieldCVV)

        textFieldCVV.translatesAutoresizingMaskIntoConstraints = false
        textFieldCVV.leadingAnchor.constraint(equalTo: viewCVV.leadingAnchor, constant: 4).isActive = true
        textFieldCVV.trailingAnchor.constraint(equalTo: viewCVV.trailingAnchor, constant: -4).isActive = true
        textFieldCVV.topAnchor.constraint(equalTo: viewCVV.topAnchor).isActive = true
        textFieldCVV.bottomAnchor.constraint(equalTo: viewCVV.bottomAnchor).isActive = true
        
        labelErrorCVV.textColor = .white
        labelErrorCVV.text = "Invalid CVV"
        labelErrorCVV.font = UIFont.systemFont(ofSize: 11.0)
        viewData.addSubview(labelErrorCVV)
        
        labelErrorCVV.translatesAutoresizingMaskIntoConstraints = false
        labelErrorCVV.centerYAnchor.constraint(equalTo: labelCVV.centerYAnchor).isActive = true
        labelErrorCVV.trailingAnchor.constraint(equalTo: viewCVV.trailingAnchor, constant: -4).isActive = true
        
        viewErrorCVV.layer.cornerRadius = 4
        viewErrorCVV.backgroundColor = .SDKErrorColor
        viewData.insertSubview(viewErrorCVV, belowSubview: labelErrorCVV)
        viewErrorCVV.isHidden = true
        
        viewErrorCVV.translatesAutoresizingMaskIntoConstraints = false
        viewErrorCVV.leadingAnchor.constraint(equalTo: labelErrorCVV.leadingAnchor, constant: -4).isActive = true
        viewErrorCVV.trailingAnchor.constraint(equalTo: labelErrorCVV.trailingAnchor, constant: 4).isActive = true
        viewErrorCVV.topAnchor.constraint(equalTo: labelErrorCVV.topAnchor, constant: -8).isActive = true
        viewErrorCVV.bottomAnchor.constraint(equalTo: labelErrorCVV.bottomAnchor, constant: 8).isActive = true
        initSaveCardBtn(viewCVV)
    }
    
    func initSaveCardBtn(_ viewCVV: UIView) {
        btnSaveCard.setTitle("Save this card data", for: .normal)
//        btnSaveCard.setImage(#imageLiteral(resourceName: "cowPayNot_save"), for: .normal)
        btnSaveCard.setImage(UIImage.init(named: "not_save", in: bundle, compatibleWith: nil), for: .normal)
        btnSaveCard.titleLabel!.font = UIFont.systemFont(ofSize: 18)
        btnSaveCard.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        btnSaveCard.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8)
        btnSaveCard.setTitleColor(.SDKSubTitleColor, for: .normal)
        btnSaveCard.contentHorizontalAlignment = .left
        viewData.addSubview(btnSaveCard)
        btnSaveCard.isHidden = true
        
        btnSaveCard.translatesAutoresizingMaskIntoConstraints = false
        btnSaveCard.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        btnSaveCard.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        btnSaveCard.topAnchor.constraint(equalTo: viewCVV.bottomAnchor, constant: 20).isActive = true
        btnSaveCard.heightAnchor.constraint(equalToConstant: 40).isActive = true
        initPayBtn(btnSaveCard)
    }
    
    func initPayBtn(_ btnSaveCard: UIButton) {
        btnMakePayment.setTitleColor(.white, for: .normal)
        btnMakePayment.backgroundColor = .SDKPowerdByColor
        btnMakePayment.setTitle("Make Payment", for: .normal)
        btnMakePayment.titleLabel!.font = UIFont.systemFont(ofSize: 14.0)
        btnMakePayment.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(makePayment)))
        btnMakePayment.layer.cornerRadius = 8
        viewData.addSubview(btnMakePayment)
        
        btnMakePayment.translatesAutoresizingMaskIntoConstraints = false
        btnMakePayment.topAnchor.constraint(equalTo: btnSaveCard.bottomAnchor, constant: 40).isActive = true
        btnMakePayment.bottomAnchor.constraint(equalTo: viewData.bottomAnchor, constant: -20).isActive = true
        btnMakePayment.trailingAnchor.constraint(equalTo: btnSaveCard.trailingAnchor).isActive = true
        btnMakePayment.leadingAnchor.constraint(equalTo: btnSaveCard.leadingAnchor).isActive = true
        btnMakePayment.heightAnchor.constraint(equalToConstant: 45).isActive = true
    }
    
    func initViewLoading() {
        view.addSubview(viewLoading)
        viewLoading.isHidden = true
        
        viewLoading.translatesAutoresizingMaskIntoConstraints = false
        viewLoading.topAnchor.constraint(equalTo: btnDismiss.bottomAnchor, constant: 8).isActive = true
        viewLoading.bottomAnchor.constraint(equalTo: imageViewPowerdBy.topAnchor, constant: -8).isActive = true
        viewLoading.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewLoading.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let imageView = UIImageView()
//        imageView.image = #imageLiteral(resourceName: "cowPayVisa_loading")
        imageView.image = UIImage.init(named: "visa_loading", in: bundle, compatibleWith: nil)
        viewLoading.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: viewLoading.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: viewLoading.centerYAnchor).isActive = true
        
        let labelWait = UILabel()
        labelWait.textColor = .SDKSubTitleColor
        labelWait.text = "Please wait"
        labelWait.font = UIFont.systemFont(ofSize: 14.0)
        labelWait.textAlignment = .center
        viewLoading.addSubview(labelWait)
        
        labelWait.translatesAutoresizingMaskIntoConstraints = false
        labelWait.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        labelWait.leadingAnchor.constraint(equalTo: viewLoading.leadingAnchor, constant: 20).isActive = true
        labelWait.trailingAnchor.constraint(equalTo: viewLoading.trailingAnchor, constant: -20).isActive = true
    }
    
    func initViewSuccess() {
        view.addSubview(viewSucess)
        viewSucess.isHidden = true
        
        viewSucess.translatesAutoresizingMaskIntoConstraints = false
        viewSucess.topAnchor.constraint(equalTo: btnDismiss.bottomAnchor, constant: 8).isActive = true
        viewSucess.bottomAnchor.constraint(equalTo: imageViewPowerdBy.topAnchor, constant: -8).isActive = true
        viewSucess.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewSucess.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let imageView = UIImageView()
//        imageView.image = #imageLiteral(resourceName: "cowPayVisa_accepted")
        imageView.image = UIImage.init(named: "visa_accepted", in: bundle, compatibleWith: nil)
        viewSucess.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: viewSucess.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: viewSucess.centerYAnchor).isActive = true
        
        let labelSucess = UILabel()
        labelSucess.textColor = .SDKSucessColor
        labelSucess.text = "Successful Payment"
        labelSucess.font = UIFont.systemFont(ofSize: 14.0)
        labelSucess.textAlignment = .center
        viewSucess.addSubview(labelSucess)
        
        labelSucess.translatesAutoresizingMaskIntoConstraints = false
        labelSucess.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        labelSucess.leadingAnchor.constraint(equalTo: viewSucess.leadingAnchor, constant: 20).isActive = true
        labelSucess.trailingAnchor.constraint(equalTo: viewSucess.trailingAnchor, constant: -20).isActive = true
        
        let btnHome = UIButton()
        btnHome.setTitleColor(.SDKSubTitleColor, for: .normal)
        btnHome.setTitle("Back Home", for: .normal)
        btnHome.titleLabel!.font = UIFont.systemFont(ofSize: 14.0)
        btnHome.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backHome)))
        btnHome.isEnabled = false
        viewSucess.addSubview(btnHome)
        
        btnHome.translatesAutoresizingMaskIntoConstraints = false
        btnHome.bottomAnchor.constraint(equalTo: viewSucess.bottomAnchor, constant: -20).isActive = true
        btnHome.centerXAnchor.constraint(equalTo: viewSucess.centerXAnchor).isActive = true
        btnHome.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    func initViewError() {
        view.addSubview(viewError)
        viewError.isHidden = true
        
        viewError.translatesAutoresizingMaskIntoConstraints = false
        viewError.topAnchor.constraint(equalTo: btnDismiss.bottomAnchor, constant: 8).isActive = true
        viewError.bottomAnchor.constraint(equalTo: imageViewPowerdBy.topAnchor, constant: -8).isActive = true
        viewError.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewError.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        let imageView = UIImageView()
//        imageView.image = #imageLiteral(resourceName: "cowPayVisa_error")
        imageView.image = UIImage.init(named: "visa_error", in: bundle, compatibleWith: nil)
        viewError.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: viewError.centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: viewError.centerYAnchor).isActive = true
        
        let labelError = UILabel()
        labelError.textColor = .SDKSubTitleColor
        labelError.text = "Something went wrong."
        labelError.font = UIFont.systemFont(ofSize: 14.0)
        labelError.textAlignment = .center
        viewError.addSubview(labelError)
        
        labelError.translatesAutoresizingMaskIntoConstraints = false
        labelError.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        labelError.leadingAnchor.constraint(equalTo: viewError.leadingAnchor, constant: 20).isActive = true
        labelError.trailingAnchor.constraint(equalTo: viewError.trailingAnchor, constant: -20).isActive = true
        
        let btnHome = UIButton()
        btnHome.setTitleColor(.SDKSubTitleColor, for: .normal)
        btnHome.setTitle("Back Home", for: .normal)
        btnHome.titleLabel!.font = UIFont.systemFont(ofSize: 14.0)
        btnHome.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(backHome)))
        viewError.addSubview(btnHome)
        
        btnHome.translatesAutoresizingMaskIntoConstraints = false
        btnHome.bottomAnchor.constraint(equalTo: viewError.bottomAnchor, constant: -20).isActive = true
        btnHome.leadingAnchor.constraint(equalTo: viewError.leadingAnchor, constant: 20).isActive = true
        btnHome.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
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
        btnRetry.centerYAnchor.constraint(equalTo: btnHome.centerYAnchor).isActive = true
        btnRetry.trailingAnchor.constraint(equalTo: viewError.trailingAnchor, constant: -20).isActive = true
        btnRetry.leadingAnchor.constraint(equalTo: btnHome.trailingAnchor, constant: 20).isActive = true
        btnRetry.heightAnchor.constraint(equalTo: btnHome.heightAnchor).isActive = true
        btnRetry.widthAnchor.constraint(equalTo: btnHome.widthAnchor).isActive = true
    }
    
    @objc func retry() {
        viewError.isHidden = true
        viewData.isHidden = false
    }
    
    func initWebView() {
        view.addSubview(webView)
        webView.delegate = self
        webView.isHidden = true
        
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.topAnchor.constraint(equalTo: btnDismiss.bottomAnchor, constant: 8).isActive = true
        webView.bottomAnchor.constraint(equalTo: imageViewPowerdBy.topAnchor, constant: -8).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
}
