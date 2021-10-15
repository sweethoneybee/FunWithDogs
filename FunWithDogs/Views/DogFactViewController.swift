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
    var dogImageView: UIImageView!
    var dogFactDescription: UILabel!
    var refreshButton: UIButton!
    var indicator = UIActivityIndicatorView(style: .medium)
    
    var viewModel: DogFactViewModel
    
    required init?(coder: NSCoder) {
        fatalError("not use storyboard")
    }
    
    init(viewModel: DogFactViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
        
        self.viewModel.dogImageDataDidChange = dogImageDataDidChange(_:)
        self.viewModel.dogFactDidChange = dogFactDidChange(_:)
    }
    
    private func dogImageDataDidChange(_ data: Data?) {
        guard let data = data,
              let image = UIImage(data: data) else {
                  return
              }
        dogImageView.image = image
    }
    
    private func dogFactDidChange(_ fact: String) {
        dogFactDescription.text = fact
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        configureNavigation()
        setViews()
    }
    
    private func configureNavigation() {
        let settingItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape"),
            style: .plain,
            target: self,
            action: #selector(pushSettingVC)
        )
        settingItem.tintColor = .black
        navigationItem.rightBarButtonItem = settingItem
    }
    
    private func setViews() {
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
            $0.font = .systemFont(ofSize: 14)
            $0.numberOfLines = 8
            $0.textAlignment = .center
            $0.text = viewModel.dogFact
            $0.sizeToFit()
        }
        
        refreshButton = UIButton().then {
            $0.setTitle("refresh".localized.uppercased(), for: .normal)
            $0.backgroundColor = .systemPink
            $0.layer.cornerRadius = 30
            $0.addTarget(self, action: #selector(refreshDog), for: .touchUpInside)
        }
        
        indicator.tintColor = .systemPink
        

        view.addSubview(dogImageView)
        view.addSubview(dogFactDescription)
        view.addSubview(refreshButton)
        view.addSubview(indicator)
        configureLayouts()
    }
    
    private func configureLayouts() {
        dogImageView.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.width.height.equalTo(300)
        }
        
        dogFactDescription.snp.makeConstraints { make in
            make.centerX.equalTo(dogImageView)
            make.top.equalTo(dogImageView.snp.bottom).offset(20)
            make.width.lessThanOrEqualTo(dogImageView.snp.width)
        }
        
        refreshButton.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.width.equalTo(90)
            make.height.equalTo(60)
        }
        
        indicator.snp.makeConstraints { make in
            make.centerX.equalTo(refreshButton)
            make.bottom.equalTo(refreshButton.snp.top).offset(-10)
        }
    }
}

// MARK:- target methods
extension DogFactViewController {
    @objc
    func pushSettingVC() {
        print("hi")
    }
    
    @objc
    func refreshDog() {
        indicator.startAnimating()
        viewModel.refreshDog(previousFact: dogFactDescription.text ?? "") {
            self.indicator.stopAnimating()
        }
    }
}
