//
//  TarefaView.swift
//  ToDoListApp
//
//  Created by Dario Pintor on 17/07/24.
//

import Foundation
import UIKit
import UIKit

class TarefaView: UIView {
    var viewModel: TarefaViewModel
    
    init(viewModel: TarefaViewModel){
        self.viewModel = viewModel
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
    }
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NovaTarefaView.self, forCellReuseIdentifier: NovaTarefaView.identifier)
        return tableView
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adiconar Tarefa", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(tableView)
        addSubview(addButton)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor),
            
            addButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            addButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

