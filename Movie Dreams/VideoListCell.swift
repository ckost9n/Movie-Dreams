//
//  VideoListCell.swift
//  Movie Dreams
//
//  Created by Konstantin on 24.05.2022.
//

import UIKit

class VideoListCell: UITableViewCell {
    
    static let identifier = "VideListCell"
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .black
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setConstraints()
        
        
    }
    
    private func setupViews() {
        addSubview(nameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(_ model: String) {
        nameLabel.text = model
        print(model)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 7),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
        
    }
    
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
