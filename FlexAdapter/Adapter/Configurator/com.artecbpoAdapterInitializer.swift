//
//  com.artecbpoAdaptercom.artecbpoAdapterInitializer.swift
//  FlexAdapter
//
//  Created by Alexey Papin on 11/02/2019.
//  Copyright © 2019 Artec. All rights reserved.
//

import UIKit

class AdapterModuleInitializer: NSObject {

    //Connect with object on storyboard
    @IBOutlet weak var adapterViewController: AdapterViewController!

    override func awakeFromNib() {

        let configurator = AdapterModuleConfigurator()
        configurator.configureModuleForViewInput(viewInput: adapterViewController)
    }

}
