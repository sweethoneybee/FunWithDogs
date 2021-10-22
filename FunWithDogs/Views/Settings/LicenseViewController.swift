//
//  LicenseViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/19.
//

import UIKit
import SnapKit

class LicenseViewController: UIViewController {

    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
    }
    
    var scrollView: UIScrollView!
    var contentView: UIView!
    var licenseLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavigation()
        configureHierarchy()
    }
}

// MARK: - Congigure
extension LicenseViewController {
    private func configureNavigation() {
        navigationItem.title = "Open Source License".localized
    }
    
    private func configureHierarchy() {
        
        scrollView = UIScrollView().then {
            view.addSubview($0)
        }
        
        contentView = UIView().then {
            scrollView.addSubview($0)
        }
    
        licenseLabel = UILabel().then {
            $0.text = OpensourceLicense().content
            $0.font = .preferredFont(forTextStyle: .body)
            $0.numberOfLines = 0
            $0.sizeToFit()
            contentView.addSubview($0)
        }
        
        configureLayouts()
    }
    
    private func configureLayouts() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        licenseLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view).inset(5)
        }
    }
}
