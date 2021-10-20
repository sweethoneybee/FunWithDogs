//
//  TextCollectionViewCell.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/19.
//

import UIKit
import SnapKit

class TextCollectionViewCell: UICollectionViewCell {
    let label = UILabel()
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    func configure() {
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 15)
        label.lineBreakMode = .byTruncatingTail
        addSubview(label)
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.systemGray2.cgColor
        layer.cornerRadius = 10
        
        let inset = 5
        label.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(inset)
            make.trailing.bottom.equalToSuperview().offset(-inset)
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                backgroundColor = .systemPink.withAlphaComponent(0.4)
            } else {
                backgroundColor = .clear
            }
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                backgroundColor = .systemPink.withAlphaComponent(0.4)
            } else {
                backgroundColor = .clear
            }
        }
    }
}
