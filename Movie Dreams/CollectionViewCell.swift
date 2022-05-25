//
//  CollectionViewCell.swift
//  Movie Dreams
//
//  Created by Konstantin on 25.05.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = "collectionCell"
    
    private let currentDate = Date()
    
    private let movieImgaView: UIImageView = {
       let imageView = UIImageView()
//        imageView.image = UIImage(systemName: "house")
        imageView.image = UIImage(named: "poster")
//        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateLabel: UILabel = {
       let label = UILabel()
        label.text = Date().getDate()
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstrains()
    }
    
    private func setupViews() {
        
        
        addSubview(movieImgaView)
        addSubview(nameLabel)
        addSubview(dateLabel)
        clipsToBounds = true
        movieImgaView.layer.cornerRadius = 15
    }
    
    func configure(model: String) {
        nameLabel.text = model
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CollectionViewCell {
    
    private func setConstrains() {
        
        NSLayoutConstraint.activate([
            movieImgaView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            movieImgaView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            movieImgaView.widthAnchor.constraint(equalToConstant: frame.width - 10),
            movieImgaView.heightAnchor.constraint(equalToConstant: 200),
            movieImgaView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.bottomAnchor.constraint(equalTo: dateLabel.topAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
    }
    
}
