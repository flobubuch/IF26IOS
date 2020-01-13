//
//  SingleViewController.swift
//  ProjetIOS
//
//  Created by Florian Bucheron on 21/12/2019.
//  Copyright © 2019 Florian Bucheron. All rights reserved.
//

import UIKit
import AVKit

class SingleViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameResultLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var myView: UIView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var videoView: UIView!
    @IBOutlet weak var videoButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var actualLengthLabel: UILabel!
    @IBOutlet weak var endLengthLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var lyricsTextView: UITextView!
    @IBOutlet weak var lyricsButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var queueSingle : [Single] = []
    var videoPlayer : AVQueuePlayer?
    var tableItemPlayer : [AVPlayerItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientBackground()
        setItemProperties()
        navigationItem.title = "Single"
        videoView.isHidden = true
        setupPlayer()
        setSlider()
        
    }
    
    var item : Item? {
        didSet{
        }
    }
    
    private func setLyrics() {
        let bundle = Bundle.main
        let path = bundle.path(forResource: item?.lyrics, ofType: "txt")
        do {
            lyricsTextView.text = try String(contentsOfFile: path!, encoding: String.Encoding.utf8)
        } catch {
            
        }
    }
    
    private func setSlider() {
        slider.thumbTintColor = .black
    }
    
    func updateLike() {
        if Single.singleFromFavorite.contains(Single.singleFromName(singleName: item!.name2!).first!) {
            likeButton.setBackgroundImage(UIImage(systemName: "heart.fill"), for: .normal)
            print("EST CONTENUE DANS FAVOOOOOO")
        } else {
            likeButton.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func likeButtonOnClick() {
        let single = Single.singleFromName(singleName: item!.name2!).first!
        let context = AppDelegate.viewContext
        if !Single.singleFromFavorite.contains(single) {
            single.addToPlaylists(Playlist.playlistFavorite.first!)
        } else {
            single.removeFromPlaylists(Playlist.playlistFavorite.first!)
        }
        do {
            try context.save()
            print("Context saved !")
        } catch {
            print("Error impossible to save context !")
        }
        updateLike()
    }
    
    private func setItemProperties() {
        imageView.image = UIImage(named: item!.imageName!)
        imageView.contentMode = .scaleToFill
        nameResultLabel.text = item?.name2
        titleLabel.text = item?.name1
        setLyrics()
        updateLike()
        canGoPreviousNext()
    }
    
    private func canGoPreviousNext() {
        if queueSingle.last?.titleSingle! == item?.name2! {
            nextButton.tintColor = .darkGray
            previousButton.tintColor = .link
        } else if queueSingle.first?.titleSingle! == item?.name2! {
            previousButton.tintColor = .darkGray
            nextButton.tintColor = .link
        } else {
            nextButton.tintColor = .link
            previousButton.tintColor = .link
        }
    }
    
    private func gradientBackground() {
        let newLayer = CAGradientLayer()
        let topColor = UIColor(red:0.28, green:0.16, blue:0.20, alpha:1.0).cgColor
        let botColor = UIColor(red:0.11, green:0.22, blue:0.40, alpha:1.0).cgColor
        newLayer.colors = [topColor, botColor]
        newLayer.frame = view.frame
        myView.layer.addSublayer(newLayer)
    }
    
    @IBAction func videoButtonOnclick() {
        if videoView.isHidden {
            imageView.isHidden = true
            lyricsTextView.isHidden = true
            videoView.isHidden = false
            videoView.layer.masksToBounds = true
            videoButton.setBackgroundImage(UIImage(systemName: "music.note"), for: .normal)
        } else {
            imageView.isHidden = false
            videoView.isHidden = true
            lyricsTextView.isHidden = true
            videoButton.setBackgroundImage(UIImage(systemName: "play.rectangle.fill"), for: .normal)
        }
        lyricsButton.tintColor = .link
        
    }
    
    private func setupPlayer() {
        if videoPlayer == nil {
            for i in 0...queueSingle.count-1 {
                print(queueSingle[i].video)
                print(" 1 er fois")
                let path = Bundle.main.path(forResource: queueSingle[i].video, ofType: "mp4")
                let avi = AVPlayerItem(url: URL(fileURLWithPath: path!))
                print(" a passé avi")
                tableItemPlayer.append(avi)
            }
            videoPlayer = AVQueuePlayer(items: tableItemPlayer)
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.queuePlayer?.pause()
            appDelegate.queuePlayer = videoPlayer
            appDelegate.queueSingle = queueSingle
            appDelegate.singleInTrack = Single.singleFromName(singleName: item!.name2!).first!
            appDelegate.tableItemPlayer = tableItemPlayer
            let playerLayer = AVPlayerLayer(player: videoPlayer)
            videoView.layer.addSublayer(playerLayer)
            playerLayer.frame = CGRect(x: 0, y: 0, width: videoView.frame.width, height: videoView.frame.height)
            videoPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            var indexOfActualMusic : Int?
            for i in 0...queueSingle.count-1 {
                if queueSingle[i].titleSingle == item?.name2 {
                    indexOfActualMusic = i
                }
            }
            while tableItemPlayer[indexOfActualMusic!] != videoPlayer?.currentItem {
                videoPlayer?.advanceToNextItem()
            }
            videoPlayer?.play()
            playButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
        } else {
            let playerLayer = AVPlayerLayer(player: videoPlayer)
            videoView.layer.addSublayer(playerLayer)
            playerLayer.frame = CGRect(x: 0, y: 0, width: videoView.frame.width, height: videoView.frame.height)
            videoPlayer?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
            videoPlayer?.play()
            playButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
        }
        //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        //        appDelegate.queuePlayer?.pause()
        //        appDelegate.queuePlayer = nil
        
        trackProgress()
    }
    
    private func trackProgress() {
        let interval = CMTime(value: 1, timescale: 2)
        videoPlayer?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progressTime) in
            
            let seconds = CMTimeGetSeconds(progressTime)
            let secondsString = String(format: "%02d", Int(seconds) % 60)
            let minutesString = String(format: "%02d", Int(seconds / 60))
            self.actualLengthLabel.text = "\(minutesString):\(secondsString)"
            
            if let duration = self.videoPlayer?.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                self.slider.value = Float(seconds/durationSeconds)
                if durationSeconds <= seconds {
                    if self.queueSingle.last?.titleSingle! != self.item?.name2! {
                        self.nextMusicButtonOnClick()
                    } else {
                        self.playButton.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
                    }
                }
            }
        })
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            if let duration = videoPlayer?.currentItem?.duration {
                let seconds : Float64 = CMTimeGetSeconds(duration)
                if !seconds.isNaN && !seconds.isInfinite {
                    let secondsText = Int(seconds) % 60
                    let minutesText = String(format: "%02d", Int(seconds/60))
                    endLengthLabel.text = "\(minutesText):\(secondsText)"
                }
            }
        }
    }
    
    @IBAction func handleSlider() {
        
        if let duration = videoPlayer?.currentItem?.duration {
            let totalSeconds = CMTimeGetSeconds(duration)
            let value = Float64(slider.value) * totalSeconds
            let seekTime = CMTime(value: CMTimeValue(Int(value)), timescale: 1)
            videoPlayer?.seek(to: seekTime)
            
        }
    }
    
    @IBAction func playButtonOnClick() {
        if playButton.backgroundImage(for: .normal) == UIImage(systemName: "play") {
            videoPlayer?.play()
            playButton.setBackgroundImage(UIImage(systemName: "pause"), for: .normal)
            if let duration = self.videoPlayer?.currentItem?.duration {
                let durationSeconds = CMTimeGetSeconds(duration)
                if durationSeconds <= Float64(slider.value)*durationSeconds {
                    self.playButton.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
                }
            }
            
        } else {
            videoPlayer?.pause()
            playButton.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        }
        
    }
    
    
    @IBAction func lyricsButtonOnClick() {
        if lyricsTextView.isHidden {
            lyricsTextView.isHidden = false
            imageView.isHidden = true
            videoView.isHidden = true
            lyricsButton.tintColor = .white
            videoButton.setBackgroundImage(UIImage(systemName: "play.rectangle.fill"), for: .normal)
        } else {
            lyricsTextView.isHidden = true
            imageView.isHidden = false
            videoView.isHidden = true
            lyricsButton.tintColor = .link
        }
    }
    
    @IBAction func musicBeforeButtonOnClick() {
        if queueSingle.first?.titleSingle != item?.name2 {
            let indexOfNextMusic = findIndexInQueue() - 1
            item = createItem(single: queueSingle[indexOfNextMusic])
            (UIApplication.shared.delegate as! AppDelegate).singleInTrack = queueSingle[indexOfNextMusic]
            setItemProperties()
            for i in 0...tableItemPlayer.count-1 {
                videoPlayer?.remove(tableItemPlayer[i])
                if i==0 {
                    videoPlayer?.insert(tableItemPlayer[i], after: tableItemPlayer[tableItemPlayer.count-1])
                } else {
                    videoPlayer?.insert(tableItemPlayer[i], after: tableItemPlayer[i-1])
                }
            }
            while tableItemPlayer[indexOfNextMusic] != videoPlayer?.currentItem {
                videoPlayer?.advanceToNextItem()
            }
            videoPlayer?.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
        } else {
            print("premier de la track")
        }
    }
    
    @IBAction func nextMusicButtonOnClick() {
        if queueSingle.last?.titleSingle! != item?.name2! {
            let indexOfNextMusic = findIndexInQueue() + 1
            item = createItem(single: queueSingle[indexOfNextMusic])
            (UIApplication.shared.delegate as! AppDelegate).singleInTrack = queueSingle[indexOfNextMusic]
            setItemProperties()
            videoPlayer?.advanceToNextItem()
            videoPlayer?.seek(to: CMTime(seconds: 0, preferredTimescale: 1))
        } else {
            print("dernier de la track")
        }
        
    }
    private func createItem(single : Single) -> Item {
        let item = Item()
        item.name1 = single.artist?.name
        item.name2 = single.titleSingle
        item.lyrics = single.lyrics
        item.video = single.video
        item.category = "Single"
        if single.album != nil {
            item.imageName = single.album?.image
        } else {
            item.imageName = single.artist?.image
        }
        return item
    }
    
    private func findIndexInQueue() -> Int {
        var index : Int?
        var i = 0
        while i < queueSingle.count {
            if item?.name2! == queueSingle[i].titleSingle! {
                index = i
                break
            }
            i=i+1
        }
        return index!
    }
    
    @IBAction func addPlaylistButtonOnClick() {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAddToPlaylist" {
            let addPlaylist = segue.destination as! AddToPlaylistViewController
            addPlaylist.singleName = item?.name2
            addPlaylist.viewController = self
        }
    }
    
    func showToast(messageToast : String) {
        let label = PaddingLabel()
        label.frame = CGRect(x: 0, y: view.frame.height-100, width: view.frame.width-25, height: 0)
        label.text = messageToast
        label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        label.textAlignment = .center
        label.sizeToFit()
        label.backgroundColor = #colorLiteral(red: 0.400228709, green: 0.4003006816, blue: 0.400219202, alpha: 1)
        label.numberOfLines = 0
        label.alpha = 1.0
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.frame.origin.x = (view.frame.width/2)-(label.frame.width/2)
        self.view.addSubview(label)
        
        UIView.animate(withDuration: 2.0, delay: 0.1, options: .curveEaseOut, animations: {label.alpha = 0.0}) {(isCompleted) in
            label.removeFromSuperview()
        }
    }
}


