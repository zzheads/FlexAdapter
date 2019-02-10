//
//  Adaptercom.artecbpoAdapterPresenter.swift
//  FlexAdapter
//
//  Created by Alexey Papin on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

class AdapterPresenter: AdapterModuleInput, AdapterViewOutput, AdapterInteractorOutput {

    weak var view: AdapterViewInput!
    var interactor: AdapterInteractorInput!
    var router: AdapterRouterInput!

    func viewIsReady() {

    }
}