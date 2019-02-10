//
//  com.artecbpoAdaptercom.artecbpoAdapterConfigurator.swift
//  FlexAdapter
//
//  Created by Alexey Papin on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import UIKit

class AdapterModuleConfigurator {

    func configureModuleForViewInput<UIViewController>(viewInput: UIViewController) {

        if let viewController = viewInput as? AdapterViewController {
            configure(viewController: viewController)
        }
    }

    private func configure(viewController: AdapterViewController) {

        let router = AdapterRouter()

        let presenter = AdapterPresenter()
        presenter.view = viewController
        presenter.router = router

        let interactor = AdapterInteractor()
        interactor.output = presenter

        presenter.interactor = interactor
        viewController.output = presenter
    }

}
