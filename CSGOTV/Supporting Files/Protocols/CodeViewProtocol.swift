//
//  CodeViewProtocol.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import UIKit

protocol CodeView {
    func addViewHierarchy()
    func setupConstraints()
    func configureViews()
}

extension CodeView {
    func enableCodeView() {
        self.addViewHierarchy()
        self.setupConstraints()
        self.configureViews()
    }
    
    func configureViews() { }
}
