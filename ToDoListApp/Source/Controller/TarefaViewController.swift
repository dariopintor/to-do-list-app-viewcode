import UIKit

class TarefaViewController: UIViewController {
    var taskModel = TarefaModel()

    private lazy var tarefaView: TarefaView = {
        let view = TarefaView()
        view.delegate = self
        view.tableView.dataSource = self
        view.tableView.delegate = self
        return view
    }()

    override func loadView() {
        view = tarefaView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "To-Do List"
    }
}

extension TarefaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskModel.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NovaTarefaView.identifier, for: indexPath) as! NovaTarefaView
        cell.configure(with: taskModel.tasks[indexPath.row])
        return cell
    }
}

extension TarefaViewController: TarefaViewDelegate {
    func didRequestAddTask() {
        let alertController = UIAlertController(title: "Nova Tarefa", message: "Entre com o nome da tarefa", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Nome da tarefa"
        }
        
        let addAction = UIAlertAction(title: "Adicionar", style: .default) { [weak self] _ in
            if let taskTitle = alertController.textFields?.first?.text, !taskTitle.isEmpty {
                self?.taskModel.addTask(taskTitle)
                self?.tarefaView.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }

    func didAddTask(named name: String) {
        taskModel.addTask(name)
        tarefaView.tableView.reloadData()
    }
}
