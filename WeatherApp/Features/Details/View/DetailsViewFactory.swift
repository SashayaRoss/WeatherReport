//
//  DetailsViewFactory.swift
//  WeatherApp
//
//  Created by Aleksandra Kustra on 10/12/2025.
//

import UIKit

final class DetailsViewFactory {
    private let appearanceManager: DetailsAppearanceManaging
    private let layoutManager: DetailsLayoutManaging
    
    init(
        appearanceManager: DetailsAppearanceManaging,
        layoutManager: DetailsLayoutManaging
    ) {
        self.appearanceManager = appearanceManager
        self.layoutManager = layoutManager
    }
}

extension DetailsViewFactory: DetailsViewProducing {
    func make() -> DetailsViewInterface {
        let view = DetailsView()
        layoutManager.layout(view: view)
        appearanceManager.decorate(view: view)

        return view
    }
}
