//
//  VideoTableViewCell.swift
//  YoutubeVideoPlayer
//
//  Created by Matej Hetzel on 07/10/2019.
//  Copyright © 2019 Matej Hetzel. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class IndexTableViewCell: UITableViewCell {
    
    let videoImageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 2
        view.text = "testTitle"
        return view
    }()
    
    let channelName: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.numberOfLines = 1
        view.text = "TestChannelNamea"
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView(){
        contentView.addSubview(videoImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(channelName)
        
        
        NSLayoutConstraint.activate([
            videoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            videoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            videoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            videoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            titleLabel.topAnchor.constraint(equalTo: videoImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: videoImageView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: videoImageView.trailingAnchor, constant: -20),
            
            channelName.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            channelName.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            channelName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            channelName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
    }
    
    func setupCell(channel: String, title: String, imageURL: String){
        videoImageView.kf.setImage(with: URL(string: imageURL))
        titleLabel.text = title
        channelName.text = channel
    }
}
