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

    var headerTitle: UILabel!
    var headerView: UIView!
    var tableView: UITableView!
    var stackView: UIStackView!
    
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
        navigationItem.title = "설정"
    }
    
    private func configureViews() {
        headerTitle = UILabel().then {
            $0.text = "\(UserManager.readFactCount)번 알아봤어요"
            $0.font = .systemFont(ofSize: 28, weight: .bold)
            $0.textAlignment = .center
            $0.backgroundColor = .white
            $0.sizeToFit()
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 10
        }
        
        headerView = UIView().then {
            $0.backgroundColor = .systemGroupedBackground
//            $0.backgroundColor = .green
            $0.addSubview(headerTitle)
        }
        
        tableView = UITableView(frame: .zero, style: .insetGrouped).then {
            $0.delegate = self
        }
    
        stackView = UIStackView(arrangedSubviews: [headerView, tableView]).then {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .equalSpacing
        }
        
        view.addSubview(stackView)
        configureLayouts()
    }
    
    private func configureLayouts() {
        headerTitle.snp.makeConstraints { make in
//            make.top.left.equalToSuperview().offset(10)
//            make.bottom.right.equalToSuperview().offset(10)
            make.center.equalToSuperview()
            make.width.equalToSuperview().offset(-50)
        }
        
        headerView.snp.makeConstraints { make in
            make.height.equalTo(70)
            make.width.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.greaterThanOrEqualTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
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
        
        let search = Item(content: "개사실 찾아보기")
        let tutorial = Item(content: "사용방법")
        snapshot.appendItems([search, tutorial], toSection: .user)
        
        let source = Item(content: "api 및 데이터 출처")
        let github = Item(content: "깃허브")
        snapshot.appendItems([source, github], toSection: .dev)
        
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
