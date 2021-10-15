//
//  TempViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/14.
//

import UIKit
import Then
import SnapKit

class DogFactViewController: UIViewController {
    private var firstShow = true
    override func viewDidLoad() {
        super.viewDidLoad()
        

        let label = UILabel().then {
            $0.text = "안녕"
        }
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if firstShow {
            firstShow.toggle()
            let vc = StartViewController()
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false)
        }
    }
}
