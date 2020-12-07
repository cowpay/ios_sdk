//
//  SelectMethodViewController.swift
//  CowPayExampleCode
//
//  Created by Mohamed on 12/3/20.
//

import UIKit

class SelectMethodViewController: UIViewController {

    let btnDismiss = UIButton()
    let labelSelect = UILabel()
    let viewCreditCard = UIView()
    let viewFawry = UIView()
    
    var billingData = [String: String]()
    var baseUrl = ""
    let bundle = Bundle(for: SelectMethodViewController.self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        initViews()
    }
    
    func initViews() {
        initDismissBtn()
        initSelectMethodLabel()
        initSelectCreditCardView()
        initSelectFawryView()
        initPowerdBy()
    }
    
    func initDismissBtn() {
//        btnDismiss.setImage(#imageLiteral(resourceName: "cowPayClose"), for: .normal)
        btnDismiss.setImage(UIImage.init(named: "close", in: bundle, compatibleWith: nil), for: .normal)
        btnDismiss.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissNav)))
        view.addSubview(btnDismiss)
        
        btnDismiss.translatesAutoresizingMaskIntoConstraints = false
        btnDismiss.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        btnDismiss.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        btnDismiss.widthAnchor.constraint(equalToConstant: 50).isActive = true
        btnDismiss.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }

    @objc func dismissNav() {
        dismiss(animated: true, completion: nil)
    }
    
    func initSelectMethodLabel() {
        labelSelect.text = "Select method"
        labelSelect.textColor = .SDKTitleColor
        view.addSubview(labelSelect)
        
        labelSelect.translatesAutoresizingMaskIntoConstraints = false
        labelSelect.topAnchor.constraint(equalTo: btnDismiss.bottomAnchor, constant: 20).isActive = true
        labelSelect.leadingAnchor.constraint(equalTo: btnDismiss.leadingAnchor).isActive = true
    }
    
    func initSelectCreditCardView() {
        view.addSubview(viewCreditCard)
        viewCreditCard.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openCreditCard)))
        
        viewCreditCard.translatesAutoresizingMaskIntoConstraints = false
        viewCreditCard.topAnchor.constraint(equalTo: labelSelect.bottomAnchor, constant: 8).isActive = true
        viewCreditCard.leadingAnchor.constraint(equalTo: labelSelect.leadingAnchor).isActive = true
        viewCreditCard.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        viewCreditCard.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let imageView = UIImageView()
//        imageView.image = #imageLiteral(resourceName: "cowPayVisa_list")
        imageView.image = UIImage.init(named: "visa_list", in: bundle, compatibleWith: nil)
        viewCreditCard.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: viewCreditCard.topAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: viewCreditCard.leadingAnchor, constant: 8).isActive = true
        imageView.bottomAnchor.constraint(equalTo: viewCreditCard.bottomAnchor, constant: -8).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        
        let label = UILabel()
        label.text = "Debit / Credit Card"
        label.textColor = .SDKTitleColor
        label.font = UIFont.systemFont(ofSize: 12.0)

        viewCreditCard.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: viewCreditCard.topAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: viewCreditCard.bottomAnchor, constant: -8).isActive = true
        
        let labelSep = UILabel()
        labelSep.backgroundColor = .SDKSeparatorColor
        viewCreditCard.addSubview(labelSep)
        
        labelSep.translatesAutoresizingMaskIntoConstraints = false
        labelSep.leadingAnchor.constraint(equalTo: viewCreditCard.leadingAnchor, constant: 20).isActive = true
        labelSep.trailingAnchor.constraint(equalTo: viewCreditCard.trailingAnchor, constant: -20).isActive = true
        labelSep.heightAnchor.constraint(equalToConstant: 1).isActive = true
        labelSep.bottomAnchor.constraint(equalTo: viewCreditCard.bottomAnchor).isActive = true
    }
    
    @objc func openCreditCard() {
        let vc = VisaViewController()
        vc.billingData = billingData
        vc.baseUrl = baseUrl
        vc.dismissNav = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func initSelectFawryView() {
        view.addSubview(viewFawry)
        viewFawry.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(openFawry)))
        
        viewFawry.translatesAutoresizingMaskIntoConstraints = false
        viewFawry.topAnchor.constraint(equalTo: viewCreditCard.bottomAnchor, constant: 8).isActive = true
        viewFawry.leadingAnchor.constraint(equalTo: viewCreditCard.leadingAnchor).isActive = true
        viewFawry.trailingAnchor.constraint(equalTo: viewCreditCard.trailingAnchor).isActive = true
        viewFawry.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let imageView = UIImageView()
//        imageView.image = #imageLiteral(resourceName: "cowPayFawry_list")
        imageView.image = UIImage.init(named: "fawry_list", in: bundle, compatibleWith: nil)
        viewFawry.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: viewFawry.topAnchor, constant: 8).isActive = true
        imageView.leadingAnchor.constraint(equalTo: viewFawry.leadingAnchor, constant: 8).isActive = true
        imageView.bottomAnchor.constraint(equalTo: viewFawry.bottomAnchor, constant: -8).isActive = true
        imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
        
        let label = UILabel()
        label.text = "Fawry Service"
        label.textColor = .SDKTitleColor
        label.font = UIFont.systemFont(ofSize: 12.0)

        viewFawry.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: viewFawry.topAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 8).isActive = true
        label.bottomAnchor.constraint(equalTo: viewFawry.bottomAnchor, constant: -8).isActive = true
        
        let labelSep = UILabel()
        labelSep.backgroundColor = .SDKSeparatorColor
        viewFawry.addSubview(labelSep)
        
        labelSep.translatesAutoresizingMaskIntoConstraints = false
        labelSep.leadingAnchor.constraint(equalTo: viewFawry.leadingAnchor, constant: 20).isActive = true
        labelSep.trailingAnchor.constraint(equalTo: viewFawry.trailingAnchor, constant: -20).isActive = true
        labelSep.heightAnchor.constraint(equalToConstant: 1).isActive = true
        labelSep.bottomAnchor.constraint(equalTo: viewFawry.bottomAnchor).isActive = true
    }
    
    @objc func openFawry() {
        let vc = FawryViewController()
        vc.billingData = billingData
        vc.baseUrl = baseUrl
        vc.dismissNav = false
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func initPowerdBy() {
        let imageView = UIImageView()
//        imageView.image = #imageLiteral(resourceName: "cowPayLogo")
        imageView.image = UIImage.init(named: "logo", in: bundle, compatibleWith: nil)
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.center = view.center
        imageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 20).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        let label = UILabel()
        label.text = "Powerd by"
        label.textColor = .SDKPowerdByColor
        label.font = UIFont.systemFont(ofSize: 10.0)

        view.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: -8).isActive = true
    }
}
