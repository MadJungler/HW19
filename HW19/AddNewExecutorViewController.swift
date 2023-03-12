//
//  AddNewExecutorViewController.swift
//  HW19
//
//  Created by Павел on 09.03.2023.
//

import UIKit
import SnapKit

class AddNewExecutorViewController: UIViewController {
    
    var previousExecutor: Executor?
    private let saveButton = UIButton()
    private let stackView = UIStackView()
    
    private let nameLabel = UILabel()
    private let surNameLabel = UILabel()
    private let dateAgeLabel = UILabel()
    private let countryLabel = UILabel()
    
    private let nameTextField = UITextField()
    private let surNameTextField = UITextField()
    private let dateAgeTextField = UITextField()
    private let countryTextField = UITextField()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        makeConstrains()
        makeUI()
    }
    
    private func saveData() {
        let id = previousExecutor?.id ?? UUID().uuidString
        guard let name = nameTextField.text,
              let surname = surNameTextField.text,
              let dateAge = dateAgeTextField.text,
              let country = countryTextField.text else {
            return
        }
        let model = ExecutorViewModel(name: name, surname: surname, age: Int(dateAge) ?? 0, country: country, id: id)
        CoreDataStorage.shared.saveExecutor(model)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func saveButtonDidTap() {
        saveData()
    }
    
}

private extension AddNewExecutorViewController {
    func makeUI() {
        view.backgroundColor = .systemGray4
        stackView.distribution = .equalSpacing
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        nameLabel.text = "Name"
        surNameLabel.text = "Surname"
        dateAgeLabel.text = "Date age"
        countryLabel.text = "Country"
        
        nameTextField.placeholder = "nameLabel"
        surNameTextField.placeholder = "surNameText"
        dateAgeTextField.placeholder = "dateAge"
        countryTextField.placeholder = "country"
        
        if let previousExecutor = previousExecutor {
            nameTextField.text = previousExecutor.name
            surNameTextField.text = previousExecutor.surname
            dateAgeTextField.text = String(previousExecutor.age)
            countryTextField.text = previousExecutor.country
        }
        
        saveButton.backgroundColor = .blue
        saveButton.layer.cornerRadius = 10
        saveButton.setTitle("SAVE", for: .normal)
        
        saveButton.addTarget(self, action: #selector(saveButtonDidTap), for: .touchUpInside)
    }
    
}

private extension AddNewExecutorViewController {
    func makeConstrains() {
        view.addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        saveButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.width.equalTo(100)
        }
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(nameTextField)
        stackView.addArrangedSubview(surNameLabel)
        stackView.addArrangedSubview(surNameTextField)
        stackView.addArrangedSubview(dateAgeLabel)
        stackView.addArrangedSubview(dateAgeTextField)
        stackView.addArrangedSubview(countryLabel)
        stackView.addArrangedSubview(countryTextField)
        stackView.addArrangedSubview(saveButton)
        
    }
}
