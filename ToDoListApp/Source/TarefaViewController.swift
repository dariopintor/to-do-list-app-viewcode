import UIKit

class TarefaViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private var tasks: [String] = []

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TarefaView.self, forCellReuseIdentifier: TarefaView.identifier)
        return tableView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Adicionar Tarefa", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "To-Do List"
        
        view.addSubview(tableView)
        view.addSubview(addButton)
        
        tableView.dataSource = self
        tableView.delegate = self
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor),
            
            addButton.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func addTask() {
        let alertController = UIAlertController(title: "Nova Tarefa", message: "Entre com o nome da tarefa", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Nome da tarefa"
        }
        
        let addAction = UIAlertAction(title: "Adicionar", style: .default) { [weak self] _ in
            if let taskTitle = alertController.textFields?.first?.text, !taskTitle.isEmpty {
                self?.tasks.append(taskTitle)
                self?.tableView.reloadData()
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(addAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TarefaView.identifier, for: indexPath) as! TarefaView
        cell.configure(with: tasks[indexPath.row])
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle task selection
    }
}
