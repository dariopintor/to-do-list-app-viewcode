//
//  Tarefa.swift
//  ToDoListApp
//
//  Created by Dario Pintor on 17/07/24.
//

import Foundation

class TarefaModel {
    var tasks: [String] = []

        func addTask(_ task: String) {
            tasks.append(task)
        }
}
