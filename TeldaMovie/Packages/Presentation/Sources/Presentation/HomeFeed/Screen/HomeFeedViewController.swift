//
//  HomeFeedViewController.swift
//  Presentation
//
//  Created by Amr on 04/11/2024.
//

import UIKit

class HomeFeedViewController: UIViewController {
    
    let viewModel: HomeFeedViewModel
    
    init(viewModel: HomeFeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}
