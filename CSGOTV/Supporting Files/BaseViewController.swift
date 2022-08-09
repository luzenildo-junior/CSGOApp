//
//  BaseViewController.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    private lazy var loadingView: UIView = {
        UIView(frame: self.view.bounds)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundColor()
    }
    
    func startLoading() {
        setupLoadingView()
    }
    
    func stopLoading() {
        loadingView.removeFromSuperview()
    }
    
    func setBackButton(){
        let buttonForBack = UIButton(type: .custom)
        let image = UIImage(named: "back-button")
        
        buttonForBack.setImage(image, for: .normal)
        buttonForBack.imageView?.tintColor = UIColor.white
        buttonForBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        buttonForBack.addTarget(
            self,
            action: #selector(BaseViewController.closeViewController),
            for: .touchUpInside
        )
        
        let barButtonItemForClose = UIBarButtonItem(customView: buttonForBack)
        self.navigationItem.setLeftBarButton(barButtonItemForClose, animated: false)
    }

    @objc func closeViewController() {
        self == self.navigationController?.children.first ? {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }() : {
            self.navigationController?.popViewController(animated: true)
        }()
    }
}

private extension BaseViewController {
    func setupBackgroundColor() {
        view.backgroundColor = AppColors.defaultBackgroundColor
    }
    
    func setupLoadingView() {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .white
        self.view.addSubview(loadingView)
        loadingView.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // loading view
            loadingView.topAnchor.constraint(equalTo: self.view.topAnchor),
            loadingView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            loadingView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            loadingView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            
            // loading activity indicator
            activityIndicator.centerXAnchor.constraint(equalTo: loadingView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: loadingView.centerYAnchor)
        ])
    }
}
