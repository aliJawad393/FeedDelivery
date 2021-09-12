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
    private let headerView: ImageSlider?
    private let selectItem: (Int) -> ()
    
    //MARK: UIView Components
    private lazy var tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.register(ItemsListItemTableViewCell.self, forCellReuseIdentifier: "cell")
        view.tableFooterView = UIView()
        view.rowHeight = UITableView.automaticDimension
        view.tableHeaderView = headerView
        return view
    }()
        
    //MARK: Init
    init(presenter: ItemsListPresenter, headerView: ImageSlider?, selectItem: @escaping(Int) -> ()) {
        self.presenter = presenter
        self.headerView = headerView
        self.selectItem = selectItem
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        tableView.tableHeaderView?.frame.size = CGSize(width: tableView.bounds.size.width, height: view.bounds.size.height / 2)
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

extension ItemsListViewController: UITableViewDelegate, UIScrollViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectItem(indexPath.row)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if(scrollView.contentOffset.y > 0) {
            headerView?.setAlpha(alpha: 1 - abs(scrollView.contentOffset.y / (tableView.tableHeaderView?.bounds.size.height ?? 1)))
        } else {
            headerView?.setAlpha(alpha: 1)
        }
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
