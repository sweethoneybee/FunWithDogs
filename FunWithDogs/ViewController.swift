//
//  ViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/11.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var titleView: UILabel!
    var subtitleView: UILabel!
    var imageView: UIImageView!
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }

    @objc
    func playAnimation() {
        titleView.alpha = 0
        subtitleView.alpha = 0
        imageView.alpha = 0
        button.alpha = 0
        button.isEnabled = false
        
        UIView.animateKeyframes(
            withDuration: 5,
            delay: 0,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1 / 5) {
                    self.titleView.alpha = 1.0
                }
                
                UIView.addKeyframe(withRelativeStartTime: 1 / 5, relativeDuration: 1 / 5) {
                    self.subtitleView.alpha = 1.0
                }
                
                UIView.addKeyframe(withRelativeStartTime: 3 / 5, relativeDuration: 1 / 5) {
                    self.imageView.alpha = 1.0
                }
                
                UIView.addKeyframe(withRelativeStartTime: 4 / 5, relativeDuration: 1 / 5) {
                    self.button.alpha = 1.0
                }
            },
            completion: { result in
                if result {
                    self.button.isEnabled = true
                }
            }
        )
    }
    
    private func setViews() {
        titleView = UILabel()
        titleView.font = .preferredFont(forTextStyle: .largeTitle)
        titleView.text = "안녕하세요"
        titleView.textAlignment = .center
        view.addSubview(titleView)
        
        subtitleView = UILabel()
        subtitleView.font = .preferredFont(forTextStyle: .largeTitle)
        subtitleView.text = "저는 죠르디예요"
        subtitleView.textAlignment = .center
        view.addSubview(subtitleView)
        
        imageView = UIImageView()
        imageView.image = UIImage(named: "jordy")
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        view.addSubview(imageView)
        
        button = UIButton()
        button.setTitle("애니메이션 실행", for: .normal)
        button.backgroundColor = .gray
        button.layer.cornerRadius = 5
        button.addTarget(self, action: #selector(playAnimation), for: .touchUpInside)
        view.addSubview(button)
        
        setLayout()
    }
    
    private func setLayout() {
        titleView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(100)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        subtitleView.snp.makeConstraints { make in
            make.centerX.equalTo(self.titleView)
            make.top.equalTo(self.titleView.snp.bottom).offset(0)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalTo(self.subtitleView)
            make.top.equalTo(self.subtitleView.snp.bottom).offset(20)
            make.width.height.equalTo(200)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(self.imageView)
            make.top.equalTo(self.imageView.snp.bottom).offset(20)
            make.width.equalTo(150)
        }
    }
}

