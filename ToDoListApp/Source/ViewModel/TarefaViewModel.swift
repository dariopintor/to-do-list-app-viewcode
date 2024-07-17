//
//  TarefaViewModel.swift
//  ToDoListApp
//
//  Created by Dario Pintor on 17/07/24.
//

import Foundation

class TarefaViewModel {
    private var tasks: [Tarefa] = []
    
    var tasksCount: Int {
        return tasks.count
    }
    
    func task(at index: Int) -> Tarefa {
        return tasks[index]
    }
    
    func addTask(title: String) {
        let task = Tarefa(title: title)
        tasks.append(task)
    }
}
