//
//  AtorCollectionViewCell.swift
//  Movie Dreams
//
//  Created by Konstantin on 03.06.2022.
//

import UIKit

class ActorCollectionViewCell: UICollectionViewCell {
    
    static let collectionId = "CollectionCell"
    
//    private let fontName = UIFont(name: "Bank Gothic Light", size: 8)
    
    private let actorImgaView: UIImageView = {
       let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Athelas Italic", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let chareckterLabel: UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont(name: "Athelas Italic", size: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    override func layoutSubviews() {
//        actorImgaView.layer.cornerRadius = actorImgaView.frame.width / 2
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: CastList) {
        nameLabel.text = model.name
        chareckterLabel.text = model.character
        
        guard let imageURL = model.profileURL else { return }
        actorImgaView.downloaded(from: imageURL)
        actorImgaView.contentMode = .scaleAspectFill
        actorImgaView.clipsToBounds = true
        actorImgaView.layer.cornerRadius = 35
    }
    
    private func setupViews() {

        addSubview(actorImgaView)
        addSubview(nameLabel)
        addSubview(chareckterLabel)
        clipsToBounds = true
    }
}

extension ActorCollectionViewCell {
    
    private func setConstrains() {
        
        NSLayoutConstraint.activate([
            actorImgaView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            actorImgaView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            actorImgaView.widthAnchor.constraint(equalToConstant: 70),
            actorImgaView.heightAnchor.constraint(equalToConstant: 70),
            actorImgaView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 0)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            nameLabel.bottomAnchor.constraint(equalTo: chareckterLabel.topAnchor, constant: 0),
            nameLabel.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        NSLayoutConstraint.activate([
            chareckterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            chareckterLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            chareckterLabel.widthAnchor.constraint(equalToConstant: 70),
        ])
        
    }
    
}
