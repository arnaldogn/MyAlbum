//
//  PhotoDetailViewController.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/24/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

protocol PhotoDetailViewControllerDelegate: class {
    func photoDetailDidFinish()
}

class PhotoDetailViewController: UIViewController {
    private let photoImg: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var closeBtn: UIButton = {
        let button = UIButton()
        let btnTitle = NSAttributedString(string: "X", attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .heavy), NSAttributedStringKey.foregroundColor: UIColor.white])
        button.setAttributedTitle(btnTitle, for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return button
    }()
    var photo: PhotoDataModel? {
        didSet {
            photoImg.sd_setShowActivityIndicatorView(true)
            photoImg.sd_setImage(with: photo?.url)
        }
    }
    weak var delegate: PhotoDetailViewControllerDelegate?
    
    init() {
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupBlurView() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ])
    }
    
    private func setupViews() {
        view.addSubviewsForAutolayout(photoImg, closeBtn)
        setupConstraints()
        setupBlurView()
    }
    
    private func setupConstraints() {
        photoImg.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        photoImg.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        photoImg.heightAnchor.constraint(equalToConstant: 200).isActive = true
        photoImg.widthAnchor.constraint(equalToConstant: 200).isActive = true
        closeBtn.centerXAnchor.constraint(equalTo: photoImg.trailingAnchor).isActive = true
        closeBtn.centerYAnchor.constraint(equalTo: photoImg.topAnchor).isActive = true
    }
    
    @objc fileprivate func closeTapped() {
        delegate?.photoDetailDidFinish()
    }
}
