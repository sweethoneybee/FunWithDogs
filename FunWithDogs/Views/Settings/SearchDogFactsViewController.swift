//
//  SearchDogFactsViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/19.
//

import UIKit
import PanModal

class SearchDogFactsViewController: UIViewController {

    enum Section {
        case main
    }
    
    private let dogs = ModelData().dogs
    
    private var searchBar: UISearchBar!
    private var collectionView: UICollectionView!
    private var dataSoruce: UICollectionViewDiffableDataSource<Section, Dog>!
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureDataSource()
    }
}

// MARK: - CollectionViewLayout
extension SearchDogFactsViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        let inset = CGFloat(2)
        item.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(40))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = 5
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
}

// MARK: - Hierarchy
extension SearchDogFactsViewController {
    private func configureHierarchy() {
        searchBar = UISearchBar().then {
            $0.delegate = self
            $0.placeholder = "find dogs fact...".localized
        }
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.keyboardDismissMode = .onDrag
        
        navigationItem.titleView = searchBar
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<TextCollectionViewCell, Dog> { cell, indexPath, dog in
            cell.label.text = dog.fact
        }
        
        dataSoruce = UICollectionViewDiffableDataSource<Section, Dog>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, dog: Dog) -> UICollectionViewCell in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: dog)
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Dog>()
        snapshot.appendSections([.main])
        snapshot.appendItems(dogs)
        
        dataSoruce.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - CollectionView Delegate
extension SearchDogFactsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        if let item = dataSoruce.itemIdentifier(for: indexPath) {
            let destination = DetailFactViewController()
            destination.content = item.fact
            
            presentPanModal(destination)
        }
    }
}

// MARK: - SearchBar Delegate
extension SearchDogFactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performQuery(for: searchText)
    }
    
    func performQuery(for text: String) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Dog>()
        snapshot.appendSections([.main])
        
        if text.isEmpty {
            snapshot.appendItems(dogs)
        } else {
            let foundFacts = dogs.filter {
                $0.fact.localizedCaseInsensitiveContains(text)
            }
            snapshot.appendItems(foundFacts)
        }
        
        dataSoruce.apply(snapshot)
    }
}
