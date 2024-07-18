import UIKit

class TarefaViewController: UIViewController {
    private var viewModel = TarefaViewModel()

    private lazy var tarefaView: TarefaView = {
        let view = TarefaView()
        view.tableView.dataSource = self
        view.tableView.delegate = self
        view.addTaskAction = { [weak self] in
            self?.addTask()
        }
        return view
    }()

    override func loadView() {
        view = tarefaView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "To-Do List"
    }
    
    func addTask() {
        let alertController = UIAlertController(title: "Nova Tarefa", message: "Entre com o nome da tarefa", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Nome da tarefa"
        }
        
        let addAction = UIAlertAction(title: "Adicionar", style: .default) { [unowned self] _ in
            if let taskTitle = alertController.textFields?.first?.text, !taskTitle.isEmpty {
                self.viewModel.addTask(taskTitle)
                self.tarefaView.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension TarefaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.taskCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NovaTarefaView.identifier, for: indexPath) as! NovaTarefaView
        cell.configure(with: viewModel.tasks[indexPath.row])
        return cell
    }
}
