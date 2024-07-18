//
//  TarefaViewModel.swift
//  ToDoListApp
//
//  Created by Dario Pintor on 17/07/24.
//

import Foundation


class TarefaViewModel {
    private let taskModel = TarefaModel()

    var tasks: [String] {
        return taskModel.tasks
    }

    var taskCount: Int {
        return taskModel.tasks.count
    }

    func addTask(_ task: String) {
        taskModel.addTask(task)
    }
}
