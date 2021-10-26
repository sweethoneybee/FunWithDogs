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
    var containerView: UIView!
    var dogImageView: UIImageView!
    var dogFactDescription: UILabel!
    var refreshButton: UIButton!
    var indicator = UIActivityIndicatorView(style: .large)
    
    var viewModel: DogFactViewModel
    
    private var isRefreshing = false
    private var isScaleAspectFit = false
    
    required init?(coder: NSCoder) {
        fatalError("not use storyboard")
    }
    
    init(viewModel: DogFactViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
        
        self.viewModel.dogImageDataDidChange = dogImageDataDidChange(_:)
        self.viewModel.dogFactDidChange = dogFactDidChange(_:)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNavigation()
        configureHierarchy()
        
        addGesture()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        containerView.backgroundColor = isScaleAspectFit ? .userInterfaceStyleBackgroundColor : .clear
        containerView.layer.shadowColor = UIColor.userInterfaceStyleShadowColor.cgColor
    }
}

// MARK: - Closures for property change
extension DogFactViewController {
    private func dogImageDataDidChange(_ data: Data?) {
        guard let data = data,
              let image = UIImage(data: data) else {
                  return
              }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.dogImageView.alpha = 0
        } completion: { _ in
            self.dogImageView.image = image
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut) {
                self.dogImageView.alpha = 1
            }
        }
    }
    
    private func dogFactDidChange(_ fact: String) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
            self.dogFactDescription.alpha = 0
        } completion: { _ in
            self.dogFactDescription.text = fact
            UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut) {
                self.dogFactDescription.alpha = 1
            }
        }
    }
}

// MARK: - Configure Methods
extension DogFactViewController {
    private func configureNavigation() {
        navigationItem.title = "Fun with Dogs"
        navigationItem.backButtonDisplayMode = .minimal
        
        let settingItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(pushSettingVC)
        )
        settingItem.tintColor = .systemPink
        navigationItem.rightBarButtonItem = settingItem
    }
    
    private func configureHierarchy() {
        containerView = UIView().then {
            $0.layer.shadowOpacity = 0.5
            $0.layer.shadowOffset = CGSize(width: 8, height: 5)
            $0.layer.shadowRadius = 10
            $0.layer.shadowColor = UIColor.userInterfaceStyleShadowColor.cgColor
            $0.layer.masksToBounds = false
        }
        
        dogImageView = UIImageView().then {
            $0.contentMode = .scaleAspectFill
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 20
            
            if let data = viewModel.dogImageData {
                $0.image = UIImage(data: data)
            } else {
                $0.image = UIImage(named: "whiteDog")
            }
        }
        
        dogFactDescription = UILabel().then {
            $0.font = .systemFont(ofSize: 17)
            $0.numberOfLines = 15
            $0.textAlignment = .center
            $0.text = viewModel.dogFact
            $0.sizeToFit()
        }
        
        refreshButton = UIButton().then {
            $0.setTitle("new fact".localized, for: .normal)
            $0.backgroundColor = .systemPink
            $0.layer.cornerRadius = 30
            $0.addTarget(self, action: #selector(refreshDog), for: .touchUpInside)
        }
        
        indicator.tintColor = .systemPink

        view.addSubview(containerView)
        containerView.addSubview(dogImageView)
        view.addSubview(dogFactDescription)
        view.addSubview(refreshButton)
        view.addSubview(indicator)
        configureLayouts()
    }
    
    private func configureLayouts() {
        containerView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            
            make.width.equalTo(containerView.snp.height).priority(1000)
            make.leading.trailing.edges.equalToSuperview().inset(20).priority(900)
            make.width.lessThanOrEqualTo(330).priority(800)
        }
        
        dogImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        dogFactDescription.snp.makeConstraints { make in
            make.centerX.equalTo(dogImageView)
            make.top.equalTo(dogImageView.snp.bottom).offset(20)
            make.width.lessThanOrEqualTo(dogImageView.snp.width)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(150)
            make.height.equalTo(60)
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.equalTo(refreshButton)
            make.bottom.equalTo(refreshButton.snp.top).offset(-10)
        }
    }
}

// MARK: - target methods
extension DogFactViewController {
    @objc
    func pushSettingVC() {
        let settingVC = SettingsViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    @objc
    func refreshDog() {
        guard isRefreshing == false else {
            return
        }
        
        isRefreshing = true
        indicator.startAnimating()
        viewModel.refreshDog(previousFact: dogFactDescription.text ?? "") {
            self.indicator.stopAnimating()
            self.isRefreshing = false
        }
    }
    
    @objc
    func dogImageViewTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            isScaleAspectFit.toggle()
            containerView.backgroundColor = isScaleAspectFit ? .userInterfaceStyleBackgroundColor : .clear
            dogImageView.contentMode = isScaleAspectFit ? .scaleAspectFit : .scaleAspectFill
            dogImageView.setNeedsLayout()
            
        }
    }
}

// MARK: - Gesture
extension DogFactViewController {
    private func addGesture() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(dogImageViewTapped(sender:)))
        containerView.addGestureRecognizer(tapRecognizer)
    }
}
