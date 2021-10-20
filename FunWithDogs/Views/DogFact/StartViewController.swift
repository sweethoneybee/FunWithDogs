//
//  ViewController.swift
//  FunWithDogs
//
//  Created by 정성훈 on 2021/10/11.
//

import UIKit
import SnapKit
import Then

class StartViewController: UIViewController {

    var titleView: UILabel!
    var subtitleView: UILabel!
    var imageView: UIImageView!
    var button: UIButton!
    
    required init?(coder: NSCoder) {
        fatalError("not use storyboard")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        playAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }

    private func configureHierarchy() {
        navigationController?.isNavigationBarHidden = true
        titleView = UILabel().then {
            $0.text = "Fun with Dogs".localized
            $0.font = .systemFont(ofSize: 44, weight: .heavy)
            $0.textAlignment = .left
            $0.textColor = .black
            $0.sizeToFit()
        }
        
        subtitleView = UILabel().then {
            $0.text = "random dog facts".localized
            $0.font = .systemFont(ofSize: 22, weight: .heavy)
            $0.textAlignment = .left
            $0.textColor = .black
            $0.sizeToFit()
        }
        
        imageView = UIImageView().then {
            $0.image = UIImage(named: "sittingDog")
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
        
        button = UIButton().then {
            $0.setTitle("start".localized.uppercased(), for: .normal)
            $0.backgroundColor = .systemPink
            $0.layer.cornerRadius = 20
            $0.addTarget(self, action: #selector(popView), for: .touchUpInside)
        }
        
        view.addSubview(imageView)
        view.addSubview(titleView)
        view.addSubview(subtitleView)
        view.addSubview(button)
        configureLayout()
    }
    
    private func configureLayout() {
        titleView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(40)
            make.left.equalTo(self.view.safeAreaLayoutGuide.snp.left).offset(20)
        }
        
        subtitleView.snp.makeConstraints { make in
            make.top.equalTo(self.titleView.snp.bottom).offset(0)
            make.left.equalTo(self.titleView)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(self.view)
            make.width.height.equalTo(self.view)
        }
        
        button.snp.makeConstraints { make in
            make.centerX.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(self.view.safeAreaLayoutGuide.snp.width).offset(-40)
            make.height.equalTo(50)
        }
    }
    
    func playAnimation() {
        titleView.alpha = 0
        subtitleView.alpha = 0
        button.alpha = 0
        button.isEnabled = false
        
        let totalDuration = TimeInterval(3)
        UIView.animateKeyframes(
            withDuration: totalDuration,
            delay: 1,
            animations: {
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1 / totalDuration) {
                    self.titleView.alpha = 1.0
                }
                
                UIView.addKeyframe(withRelativeStartTime: 1 / totalDuration, relativeDuration: 1 / totalDuration) {
                    self.subtitleView.alpha = 1.0
                }
                
                UIView.addKeyframe(withRelativeStartTime: 2 / totalDuration, relativeDuration: 1 / totalDuration * 2) {
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

// MARK: - Taget methods
extension StartViewController {
    @objc
    func popView() {
        navigationController?.popViewController(animated: true)
    }
}

