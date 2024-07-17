import UIKit

class TarefaViewController: UIViewController {

    private var tasks: [Task] = []
    private let taskView = TarefaView()

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
        
        let addAction = UIAlertAction(title: "Adionar nova tarefa", style: .default) { [weak self] _ in
            if let taskTitle = alertController.textFields?.first?.text, !taskTitle.isEmpty {
                let task = Task(title: taskTitle)
                self?.tasks.append(task)
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
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NovaTarefaView.identifier, for: indexPath) as! NovaTarefaView
        
        cell.configure(with: tasks[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle task selection
    }
}
