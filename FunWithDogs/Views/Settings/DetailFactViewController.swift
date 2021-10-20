//
//  DetailFactViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/20.
//

import UIKit
import Then
import SnapKit
import PanModal

class DetailFactViewController: UIViewController {
    var content: String? {
        didSet {
            body.text = content
        }
    }
    
    private var body: UILabel!

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
    }
}

// MARK: - Configure
extension DetailFactViewController {
    private func configureHierarchy() {
        body = UILabel().then {
            $0.numberOfLines = 0
            $0.font = .systemFont(ofSize: 20)
            $0.textAlignment = .center
        }
        
        view.addSubview(body)
        configureLayouts()
    }
    
    private func configureLayouts() {
        body.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.leading.trailing.equalToSuperview().inset(10)
        }
    }
}

// MARK: - PanModal
extension DetailFactViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeight(250)
    }
    
    var longFormHeight: PanModalHeight {
        return .maxHeightWithTopInset(200)
    }
}
