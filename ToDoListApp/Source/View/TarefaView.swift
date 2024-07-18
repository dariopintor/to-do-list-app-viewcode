//
//  TarefaView.swift
//  ToDoListApp
//
//  Created by Dario Pintor on 17/07/24.
//

import Foundation
import UIKit

protocol TarefaViewDelegate: AnyObject {
    func didRequestAddTask()
    func didAddTask(named name: String)
}

class TarefaView: UIView {
    weak var delegate: TarefaViewDelegate?
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(NovaTarefaView.self, forCellReuseIdentifier: NovaTarefaView.identifier)
        return tableView
    }()
    
    let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar Tarefa", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        backgroundColor = .white
        addSubview(tableView)
        addSubview(addButton)
        
        addButton.addTarget(self, action: #selector(requestAddTask), for: .touchUpInside)
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
    
    @objc private func requestAddTask() {
        delegate?.didRequestAddTask()
    }
}
