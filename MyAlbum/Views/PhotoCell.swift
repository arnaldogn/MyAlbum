//
//  PhotoCell.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import SDWebImage

class PhotoCell: UICollectionViewCell {
    private let thumbnail: UIImageView = {
        let thumbnail = UIImageView()
        thumbnail.clipsToBounds = true
        thumbnail.contentMode = .scaleAspectFill
        return thumbnail
    }()
    private let title: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        return label
    }()
    private let nameBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        return view
    }()
    static let defaultIdentifier = "PhotoCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubviewsForAutolayout(thumbnail, nameBackground, title)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let views: [String: Any] = ["thumbnail": thumbnail,
                                    "name": title,
                                    "nameBackground": nameBackground]
        
        contentView.addConstraints(
            NSLayoutConstraint.constraints("H:|[thumbnail]|", views: views),
            NSLayoutConstraint.constraints("H:|-5-[name]-5-|", views: views),
            NSLayoutConstraint.constraints("H:|[nameBackground]|", views: views),
            NSLayoutConstraint.constraints("V:|[thumbnail]|", views: views),
            NSLayoutConstraint.constraints("V:[nameBackground]|", views: views),
            NSLayoutConstraint.constraints("V:[name]-5-|", views: views))
        
        nameBackground.topAnchor.constraint(equalTo: title.topAnchor, constant: -5).isActive = true
    }
    
    func configure(with photo: PhotoDataModel) {
        title.text = photo.title
        thumbnail.sd_addActivityIndicator()
        thumbnail.sd_setImage(with: photo.thumbnail)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnail.image = nil
    }
}
