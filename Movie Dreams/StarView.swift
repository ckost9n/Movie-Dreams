//
//  StarView.swift
//  Movie Dreams
//
//  Created by Eugene Kotovich on 24.05.2022.
//

import UIKit

// A view that displays a star rating.
public class StarsView: UIView {
    // The rating to display.
    public var rating: Int = 0 {
        didSet {
            for i in 0..<5 {
                imageViews[i].tintColor = i < rating ? .yellow : .gray
            }
        }
    }
    
    private let imageViews: [UIImageView]
    
    public init() {
        imageViews = (0..<5).map { _ in
            UIImageView(image: UIImage(systemName: "star.fill"))
        }
        
        super.init(frame: .zero)
        
        directionalLayoutMargins = .zero
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 5
        for view in imageViews {
            stackView.addArrangedSubview(view)
        }
        
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
