//
//  HomeViewController.swift
//  CSGOTV
//
//  Created by Luzenildo Junior on 04/08/22.
//

import Foundation
import Combine

final class HomeViewController: BaseViewController {
    private let viewModel: HomeViewModel
    
    private var cancellables = Set<AnyCancellable>()
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableCodeView()
        subscribeToPublishers()
        viewModel.fetchTournamentData()
    }
    
    private func subscribeToPublishers() {
        viewModel.$viewState
        .receive(on: DispatchQueue.main)
        .sink { [weak self] viewState in
            switch viewState {
            case .loading:
                self?.startLoading()
            case .showMatches:
                self?.stopLoading()
                print("Showing matches")
            case .showError(let message):
                print(message)
            }
        }.store(in: &cancellables)
    }
}

extension HomeViewController: CodeView {
    func addViewHierarchy() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func configureViews() {
        title = "home.title".localized
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
