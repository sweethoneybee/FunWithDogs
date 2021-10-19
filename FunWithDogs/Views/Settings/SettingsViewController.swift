//
//  SettingsViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/16.
//

import Foundation
import UIKit

class SettingsViewController: UIViewController {
    
    enum Section {
        case user
        case dev
    }

    struct Item: Hashable {
        var identifier = UUID()
        var content: String
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(identifier)
        }
        
        static func ==(lhs: Item, rhs: Item) -> Bool {
            return lhs.identifier == rhs.identifier
        }
    }

    var tableView: UITableView!
    var headerView: UIView!
    var headerLabel: UILabel!
    
    private var dataSource: UITableViewDiffableDataSource<Section, Item>!
    
    required init?(coder: NSCoder) {
        fatalError("no storyboard")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        configureNavigation()
        configureViews()
        configureDataSource()
    }
    
    // MARK: - configure view
    private func configureNavigation() {
        navigationItem.title = "Settings".localized
        navigationItem.backButtonDisplayMode = .minimal
    }
    
    private func configureViews() {
        tableView = UITableView(frame: .zero, style: .grouped).then {
            $0.delegate = self
        }
        
        headerView = UIView().then {
            $0.frame.size.height = 40
        }
        
        headerLabel = UILabel().then {
            $0.textAlignment = .left
            $0.font = .preferredFont(forTextStyle: .caption1)
            $0.textColor = .systemGray
            $0.text = String(format: "Hooray! We found %d dogs".localized, UserManager.readFactCount)
        }
        
        headerView.addSubview(headerLabel)
        tableView.tableHeaderView = headerView
        view.addSubview(tableView)

        configureLayouts()
    }
    
    private func configureLayouts() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        headerLabel.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(10)
            make.leading.equalToSuperview().offset(15)
            make.bottom.equalToSuperview().offset(-5)
        }
    }
}

// MARK: - Datasource
extension SettingsViewController {
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Item>(tableView: tableView) {
            tableView, indexPath, item in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "temp")
            
            var content = cell.defaultContentConfiguration()
            content.text = item.content
            
            cell.contentConfiguration = content
            
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.user, .dev])
        
        let search = Item(content: "Search all dog facts".localized)
        let tutorial = Item(content: "How to use".localized)
        snapshot.appendItems([search, tutorial], toSection: .user)
        
        let source = Item(content: "Open-source license".localized)
        let github = Item(content: "Github".localized)
        snapshot.appendItems([source, github], toSection: .dev)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - TableView Delegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let destination: UIViewController?
        switch (indexPath.section, indexPath.row) {
        case (0, 0): destination = SearchDogFactsViewController()
        case (0, 1): destination = TutorialViewController()
        case (1, 0): destination = LicenseViewController()
        case (1, 1): destination = GithubViewController()
        default: destination = nil
        }
        
        if let vc = destination {
            navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
