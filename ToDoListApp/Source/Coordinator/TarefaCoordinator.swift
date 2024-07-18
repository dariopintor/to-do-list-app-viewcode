//
//  TarefaCoordinator.swift
//  ToDoListApp
//
//  Created by Dario Pintor on 18/07/24.
//

import Foundation
import UIKit

class TarefaCoordinator:Coordiantor {
    private let navigationController: UINavigationController
    
    lazy var tarefaViewController: TarefaViewController = {
        let viewModel = TarefaViewModel(coordinator: self)
        let viewController = TarefaViewController(taskViewModel: viewModel)
        //adiciona o nome home na tabbar
        viewController.tabBarItem.title = "Tarefas"
        viewController.tabBarItem.image = UIImage(systemName: "homekit")
        return viewController
    }()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.navigationController.setViewControllers([tarefaViewController], animated: false)
    }
    
}
