//
//  VideoViewController.swift
//  rePear
//
//  Created by Sara Du on 5/25/16.
//  Copyright © 2016 Sara Du. All rights reserved.
//

import UIKit
import YouTubePlayer

class VideoViewController: UIViewController {
    @IBOutlet weak var playerView: YouTubePlayerView!
    override func viewDidLoad() {
        playerView.loadPlaylistID("PLAWzAhT15N-qurIyzUG8bI8OHA1w80utI")
    }
}
