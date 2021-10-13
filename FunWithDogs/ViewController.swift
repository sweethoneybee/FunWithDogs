//
//  ViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/11.
//

import UIKit
import SnapKit
import Then

class ViewController: UIViewController {

    var titleView: UILabel!
    var subtitleView: UILabel!
    var imageView: UIImageView!
    var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setViews()
    }

    private func setViews() {
        titleView = UILabel().then {
            $0.font = .preferredFont(forTextStyle: .largeTitle)
            $0.text = "Hello".localized
            $0.textAlignment = .center
        }
        
        subtitleView = UILabel().then {
            $0.font = .preferredFont(forTextStyle: .largeTitle)
            $0.text = "I'm Jordy".localized
            $0.textAlignment = .center
        }
        
        imageView = UIImageView().then {
            $0.image = UIImage(named: "jordy")
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
        
        button = UIButton().then {
            $0.setTitle("Play animation".localized, for: .normal)
            $0.backgroundColor = .systemPink
            $0.layer.cornerRadius = 20
            $0.addTarget(self, action: #selector(playAnimation), for: .touchUpInside)
        }
        
        view.addSubview(titleView)
        view.addSubview(subtitleView)
        view.addSubview(imageView)
        view.addSubview(button)
        configureLayout()
    }
    
    private func configureLayout() {
        titleView.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
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
            make.width.height.equalTo(300)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(self.imageView)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(self.view.safeAreaLayoutGuide.snp.width).offset(-40)
            make.height.equalTo(50)
        }
    }
}

// MARK:- Taget methods
extension ViewController {
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
                
                UIView.addKeyframe(withRelativeStartTime: 9 / 10, relativeDuration: 1 / 10) {
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
}

