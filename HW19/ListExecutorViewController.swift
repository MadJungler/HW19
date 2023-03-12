//
//  ViewController.swift
//  HW19
//
//  Created by Павел on 09.03.2023.
//

import UIKit
import SnapKit

final class ListExecutorViewController : UIViewController {
    
    private var saveSortOrder: SortingViewModel = UserDefaultsStorage.shared.order
    private let tableView = UITableView()
    private let addNewButton = UIButton()
    private var dataSource: [Executor] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstraint()
        makeUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fillData()
    }
    
    private func fillData() {
        var data = CoreDataStorage.shared.getExecutor()
        data.sort { executor1, executor2 in
            guard let name1 = executor1.name, let name2 = executor2.name else {
                return true
            }
                    
            switch saveSortOrder {
            case .asc:
                return name1 < name2
            case .desc:
                return name1 > name2
            }
        }
        dataSource = data

    }
    
    private func makeConstraint() {
        view.addSubview(tableView)
        view.addSubview(addNewButton)
        
        tableView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    func makeUI() {
        tableView.backgroundColor = .systemGray4
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.id)
        
        let addNewButton = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(buttonDidTap))
        navigationItem.rightBarButtonItem = addNewButton
        
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortButtonDidTap))
        navigationItem.leftBarButtonItem = sortButton
    }
    @objc func sortButtonDidTap() {
        saveSortOrder = saveSortOrder.toggled()
        UserDefaultsStorage.shared.order = saveSortOrder
        fillData()
    }
    
    @objc func buttonDidTap() {
        let vc = AddNewExecutorViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension ListExecutorViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.id, for: indexPath) as? CustomTableViewCell else {
            return UITableViewCell()
        }
        let model = dataSource[indexPath.row]
        cell.nameLabel.text = model.name
        cell.surNameLabel.text = model.surname
        cell.ageLabel.text = String(model.age)
        cell.countryLabel.text = model.country
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        let vc = AddNewExecutorViewController()
        vc.previousExecutor = model
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}
