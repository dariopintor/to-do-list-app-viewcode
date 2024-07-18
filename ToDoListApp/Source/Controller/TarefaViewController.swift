import UIKit

class TarefaViewController: UIViewController {
    
    private var taskViewModel: TarefaViewModel
    
    
    init(taskViewModel: TarefaViewModel) {
        self.taskViewModel = taskViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var taskView: TarefaView = {
        let taskView = TarefaView(viewModel: taskViewModel)
        return taskView
    } ( )
    
    override func loadView() {
        view = taskView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "To-Do List"
        
        taskView.tableView.dataSource = self
        taskView.tableView.delegate = self
        taskView.addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
    }
    
    @objc private func addTask() {
        let alertController = UIAlertController(title: "Nova Tarefa", message: "Entre com o nome da tarefa", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Nome da Tarefa"
        }
        
        let addAction = UIAlertAction(title: "Adionar", style: .default) { [weak self] _ in
            if let taskTitle = alertController.textFields?.first?.text, !taskTitle.isEmpty {
                self?.taskViewModel.addTask(title: taskTitle)
                self?.taskView.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension TarefaViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskViewModel.tasksCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NovaTarefaView.identifier, for: indexPath) as! NovaTarefaView
        let task = taskViewModel.task(at: indexPath.row)
        cell.configure(with: task.title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle task selection
    }
}
