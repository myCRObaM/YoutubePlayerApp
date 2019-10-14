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
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        let cvsnp = contentView.snp
        
        videoImageView.snp.makeConstraints { (make) in
            make.top.equalTo(cvsnp.top)
            make.height.equalTo(200)
            make.leading.equalTo(cvsnp.leading)
            make.trailing.equalTo(cvsnp.trailing)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(videoImageView.snp.bottom).offset(10)
            make.leading.equalTo(videoImageView.snp.leading).offset(10)
            make.trailing.equalTo(videoImageView.snp.trailing).offset(-20)
        }
        
        channelName.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(5)
            make.bottom.equalTo(cvsnp.bottom).offset(-5)
            make.leading.equalTo(cvsnp.leading).offset(10)
            make.trailing.equalTo(cvsnp.trailing).offset(-10)
        }
    }
    
    func setupCell(channel: String, title: String, imageURL: String){
        videoImageView.kf.setImage(with: URL(string: imageURL))
        titleLabel.text = title
        channelName.text = channel
    }
}
