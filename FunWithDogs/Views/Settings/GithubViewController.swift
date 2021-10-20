//
//  GithubViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/19.
//

import UIKit
import SafariServices
import Then
import SnapKit

class GithubViewController: UIViewController {

    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
    }
    
    private let githubURL = "https://github.com/sweethoneybee/FunWithDogs"
    private var githubPage: SFSafariViewController? {
        guard let url = URL(string: githubURL) else {
            return nil
        }
        
        let githubPage = SFSafariViewController(url: url)
        return githubPage
    }
    
    private var titleLabel: UILabel!
    private var urlButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
    }
}

// MARK: - Configure Hierarchy
extension GithubViewController {
    private func configureHierarchy() {
        titleLabel = UILabel().then {
            $0.text = "Github page".localized
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 32, weight: .heavy)
            $0.sizeToFit()
        }
        
        urlButton = UIButton(type: .system).then {
            $0.setTitle(githubURL, for: .normal)
            $0.addTarget(self, action: #selector(presentGithubPage), for: .touchUpInside)
        }
        
        view.addSubview(titleLabel)
        view.addSubview(urlButton)
        configureLayouts()
    }
    
    private func configureLayouts() {
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalTo(urlButton)
            make.bottom.equalTo(urlButton.snp.top).offset(20)
            make.height.equalTo(60)
            make.width.equalToSuperview()
        }
        
        urlButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}

// MARK: - Target Methods
extension GithubViewController {
    @objc
    private func presentGithubPage() {
        guard let githubPage = githubPage else { return }
        present(githubPage, animated: true)
    }
}
