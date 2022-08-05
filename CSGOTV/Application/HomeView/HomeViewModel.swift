//
//  HomeViewModel.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import Foundation
import Combine

final class HomeViewModel {
    enum HomeState {
        case loading
        case showMatches
        case showError(message: String)
    }
    
    @Published var viewState: HomeState = .loading
}
