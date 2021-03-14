//
//  BaseViewController.swift
//  ConnectivityListener
//
//  Created by Anoop M on 2021-03-13.
//

import UIKit
import Combine
class BaseViewController: UIViewController {

    lazy var banner = UIView(frame: .zero)
    var isConnected:Bool = false
    private var connectivitySubscriber:AnyCancellable?
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConnectivitySubscribers()
        setUpView()
        // Do any additional setup after loading the view.
    }
    

    func setUpConnectivitySubscribers() {
        
        connectivitySubscriber = ConnectivityMananger.shared().$isConnected.sink(receiveValue: { [weak self](isConnected) in
            print(isConnected ? "Online" : "Offline")
            self?.isConnected = isConnected
            self?.updateBanner()
        })
    }
    
    func setUpView(){
        banner.translatesAutoresizingMaskIntoConstraints = false
        updateBanner()
        
        view.addSubview(banner)
        
        NSLayoutConstraint.activate([
        
            banner.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            banner.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            banner.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            banner.heightAnchor.constraint(equalToConstant: 5),
            
        
        ])
    }
    
    func updateBanner() {
        banner.backgroundColor = isConnected ? .green : .red
    }
}
