//
//  TempViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/14.
//

import UIKit
import Then
import SnapKit

class TempViewController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
