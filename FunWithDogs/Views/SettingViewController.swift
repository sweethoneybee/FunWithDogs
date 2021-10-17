//
//  SettingViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/16.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    
    enum Section {
        case main
        case sub
    }
    
    var tableView: UITableView!
    private var dataSource: UITableViewDiffableDataSource<Section, Int>!
    
    required init?(coder: NSCoder) {
        fatalError("no storyboard")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        configureViews()
        configureDataSource()
    }
    
    // MARK: - configure view
    private func configureViews() {
        tableView = UITableView().then {
            $0.delegate = self
        }
    
        view.addSubview(tableView)
        configureLayouts()
    }
    
    private func configureLayouts() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    private func configureDataSource() {
        dataSource = UITableViewDiffableDataSource<Section, Int>(tableView: tableView) {
            tableView, indexPath, itemIdentifier in
            let cell = UITableViewCell(style: .default, reuseIdentifier: "temp")
            
            var content = cell.defaultContentConfiguration()
            content.image = UIImage(systemName: "star")
            content.text = "\(itemIdentifier). WoW this is new apis"
            
            cell.contentConfiguration = content
            
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main, .sub])
        snapshot.appendItems(Array(0..<3), toSection: .main)
        snapshot.appendItems(Array(5..<8), toSection: .sub)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
