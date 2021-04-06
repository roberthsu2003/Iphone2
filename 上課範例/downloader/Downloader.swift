//
//  Downloader.swift
//  downloader
//
//  Created by 徐國堂 on 2021/4/6.
//

import UIKit
typealias DownloaderCh = (URL?) -> ()
class Downloader:NSObject{
    var handlers = [Int:DownloaderCh]()
    let config:URLSessionConfiguration!
    lazy var session:URLSession = {
        return URLSession(configuration: self.config, delegate: self, delegateQueue: .main)
    }()
    
    init(config:URLSessionConfiguration){
        self.config = config
        super.init()
    }
    
    func download(url:URL, completionHandler ch:@escaping DownloaderCh){
        let task = self.session.downloadTask(with: url)
        handlers[task.taskIdentifier] = ch
        task.resume()
    }
}

extension Downloader:URLSessionDownloadDelegate{
    func urlSession(_ session: URLSession,
       downloadTask: URLSessionDownloadTask,
       didFinishDownloadingTo location: URL){
        let ch = handlers[downloadTask.taskIdentifier]
        ch?(location)
    }
}
