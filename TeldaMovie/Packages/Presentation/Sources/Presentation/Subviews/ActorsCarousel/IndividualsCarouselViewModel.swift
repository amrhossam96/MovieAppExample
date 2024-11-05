//
//  IndividualsCarouselViewModel.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import Foundation
import struct Core.PresentableCastMember

class IndividualsCarouselViewModel: ObservableObject {
    @Published var individuals: [PresentableCastMember] = []
    let title: String
    init(title: String) {
        self.title = title
    }
}
