//
//  Downloader.swift
//  downloader
//
//  Created by 徐國堂 on 2021/4/6.
//

import UIKit
class Downloader:NSObject{
    let config:URLSessionConfiguration!
    lazy var session:URLSession = {
        return URLSession(configuration: self.config, delegate: self, delegateQueue: .main)
    }()
    
    init(config:URLSessionConfiguration){
        self.config = config
        super.init()
    }
}

extension Downloader:URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession,
       downloadTask: URLSessionDownloadTask,
       didFinishDownloadingTo location: URL){
        
    }
}
