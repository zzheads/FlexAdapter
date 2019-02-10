//
//  Adaptercom.artecbpoAdapterViewController.swift
//  FlexAdapter
//
//  Created by Alexey Papin on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import UIKit

class AdapterViewController: UIViewController, AdapterViewInput {

    var output: AdapterViewOutput!

    // MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        output.viewIsReady()
    }


    // MARK: AdapterViewInput
    func setupInitialState() {
    }
}
