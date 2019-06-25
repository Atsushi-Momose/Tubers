//
//  YoutubeChannelViewController.swift
//  Tubers
//
//  Created by 百瀬篤志 on 2019/06/25.
//  Copyright © 2019 mmsc. All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class YoutubeChannelViewController: UIViewController, YTPlayerViewDelegate {
    
    @IBOutlet var playerView: YTPlayerView!
    
    var videoID = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.playerView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        self.playerView.load(withVideoId: self.videoID)
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        self.playerView.playVideo()
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        
    }
    
    func playerView(_ playerView: YTPlayerView, didChangeTo quality: YTPlaybackQuality) {
        
    }
    
    func playerView(_ playerView: YTPlayerView, receivedError error: YTPlayerError) {
        
    }
    
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        
    }
    
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return .black
        
    }
    
    func playerViewPreferredInitialLoading(_ playerView: YTPlayerView) -> UIView? {
        return nil
        
    }
}
