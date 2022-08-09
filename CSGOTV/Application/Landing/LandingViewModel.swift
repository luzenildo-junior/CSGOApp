//
//  LandingViewModel.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import Foundation
import Combine

final class LandingViewModel {
    @Published var dismissView = false
    
    func startCountdownToDismissView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismissView = true
        }
    }
}
