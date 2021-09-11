//
//  ViewController.swift
//  FoodDelivery
//
//  Created by Ali Jawad on 07/09/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ItemsListViewController: UIViewController {
    private let presenter: ItemsListPresenter
    private let disposeBag = DisposeBag()
    private let headerView: UIView
    
    //MARK: UIView Components
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ItemsListItemTableViewCell.self, forCellReuseIdentifier: "cell")
        view.tableFooterView = UIView()
        view.rowHeight = UITableView.automaticDimension
        return view
    }()
    
    //MARK: Init
    init(presenter: ItemsListPresenter, headerView: UIView) {
        self.presenter = presenter
        self.headerView = headerView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupView()
        bindWithData()
    }
}

//MARK: Setup View
private extension ItemsListViewController {
    private func setupView() {
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension ItemsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        5
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

//MARK: RxSwift
private extension ItemsListViewController {
    private func bindWithData() {
        tableView.rx
                .setDelegate(self)
                .disposed(by: disposeBag)
        
        presenter.items.bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: ItemsListItemTableViewCell.self)) {
            index, element, cell in
            cell.setData(element)
        }.disposed(by: disposeBag)

        presenter.error
            .observe(on: MainScheduler.instance)
            .subscribe {[weak self] error in
                self?.alert("Error", message: error.element?.localizedDescription ?? "Something went wrong")
            }.disposed(by: disposeBag)

    }
}
