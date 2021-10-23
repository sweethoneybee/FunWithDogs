//
//  TutorialViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/19.
//

import UIKit
import SnapKit

class TutorialViewController: UIViewController {

    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
    }

    var contentLabel: UILabel!
    var contents: NSAttributedString {
        let boldFont = UIFont.systemFont(ofSize: 32, weight: .bold)
        let normalAttributes: [NSAttributedString.Key: Any] = [.font: boldFont]
        
        let foregroundColor = UIColor.white
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.systemPink
        shadow.shadowBlurRadius = 5
        
        let coloredAttributes: [NSAttributedString.Key: Any] = [
            .font: boldFont,
            .foregroundColor: foregroundColor,
            .shadow: shadow
        ]
        
        let firstString = NSMutableAttributedString(string: "JUST\nPRESS\n", attributes: normalAttributes)
        let secondString = NSAttributedString(string: "THE PINK\nBUTTON", attributes: coloredAttributes)
        
        firstString.append(secondString)
        return firstString
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
    }
}

// MARK: - Configure
extension TutorialViewController {
    private func configureHierarchy() {
        contentLabel = UILabel().then {
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.attributedText = contents
            $0.sizeToFit()
            view.addSubview($0)
        }
        
        configureLayouts()
    }
    
    private func configureLayouts() {
        contentLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
