//
//  ViewController.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 07/09/2021.
//

import UIKit

class ItemsListViewController: UIViewController {
    private let presenter: ItemsListPresenter
    
    //MARK: Init
    init(presenter: ItemsListPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }


}

