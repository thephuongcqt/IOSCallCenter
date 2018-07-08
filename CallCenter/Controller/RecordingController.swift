//
//  RecordingController.swift
//  CallCenter
//
//  Created by Nguyen The Phuong on 7/7/18.
//  Copyright © 2018 Nguyen The Phuong. All rights reserved.
//

import UIKit
import AVFoundation

class RecordingController: UIViewController {

    var isAudioRecordingGranted = false
    var isRecording = false
    var isPlaying = false
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var meterTimer: Timer!
    
    let lblTimer: UILabel = {
        let label = UILabel()
        label.text = "00.00:00"
        label.font = .boldSystemFont(ofSize: 17)
        label.textColor = .mainColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let btnRecord: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Bắt đầu ghi âm", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.mainColor.cgColor
        button.setTitleColor(.mainColor, for: .normal)
        return button
    }()
    
    let btnPlay: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Phát đoạn ghi âm", for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.mainColor.cgColor
        button.setTitleColor(.mainColor, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cài đặt lời chào"
        view.backgroundColor = .white
        checkRecordingPermission()
    }
    
    func permissionChecked(){
        if isAudioRecordingGranted{
            DispatchQueue.main.async {
                self.view.addSubview(self.lblTimer)
                self.view.addSubview(self.btnRecord)
                self.view.addSubview(self.btnPlay)
                self.btnRecord.addTarget(self, action: #selector(self.handleButtonRecordingSelected), for: .touchUpInside)
                self.btnPlay.addTarget(self, action: #selector(self.handleButtonPlaySelected), for: .touchUpInside)
                self.setupLayout()
            }
        }
    }
    
    func setupLayout(){
        NSLayoutConstraint.activate([
            lblTimer.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            lblTimer.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
            ])
        
        NSLayoutConstraint.activate([
            btnRecord.trailingAnchor.constraint(equalTo: view.centerXAnchor, constant: -30),
            btnRecord.topAnchor.constraint(equalTo: lblTimer.bottomAnchor, constant: 15),
            btnRecord.widthAnchor.constraint(equalToConstant: 150),
            btnRecord.heightAnchor.constraint(equalToConstant: 45)
            ])
        
        NSLayoutConstraint.activate([
            btnPlay.leadingAnchor.constraint(equalTo: view.centerXAnchor, constant: 30),
            btnPlay.topAnchor.constraint(equalTo: btnRecord.topAnchor),
            btnPlay.widthAnchor.constraint(equalToConstant: 150),
            btnPlay.heightAnchor.constraint(equalToConstant: 45)
            ])
    }
    
    // MARK: - Check permission
    
    func checkRecordingPermission(){
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            isAudioRecordingGranted = true
            permissionChecked()
            break
        case .denied:
            isAudioRecordingGranted = false
            permissionChecked()
            break
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
                if granted{
                    self.isAudioRecordingGranted = true
                } else{
                    self.isAudioRecordingGranted = false
                }
                self.permissionChecked()
            }
        default:
            break
        }
    }
    
    // MARK: - Directory file
    
    func getCacheDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func getFileURL() -> URL{
        let fileName = "Greeting.m4a"
        let filePath = getCacheDirectory().appendingPathComponent(fileName)
        return filePath
    }
    
    // MARK: - Handle recording
    
    func setupRecorder(){
        if isAudioRecordingGranted{
            let session = AVAudioSession.sharedInstance()
            do {
                try session.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
                try session.setActive(true, options: .notifyOthersOnDeactivation)
                let settings = [
                    AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
                    AVSampleRateKey: 44100,
                    AVNumberOfChannelsKey: 2,
                    AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
                ]
                audioRecorder = try AVAudioRecorder(url: getFileURL(), settings: settings)
                audioRecorder.delegate = self
                audioRecorder.isMeteringEnabled = true
                audioRecorder.prepareToRecord()
            } catch let error{
                showAlert(title: "Lỗi", message: error.localizedDescription)
            }
        } else{
            showAlert(title: "Lỗi", message: "Bạn không có quyền sử dụng microphone")
        }
    }
    
    @objc func handleButtonRecordingSelected(){
        if isRecording{
            finishAudioRecording(success: true)
            updateNotRecording()
        } else{
            setupRecorder()
            audioRecorder.record()
            meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateAudioMeter(timer:)), userInfo: nil, repeats: true)
            updateRecording()
        }
    }
    
    func finishAudioRecording(success: Bool){
        if success {
            audioRecorder.stop()
            audioRecorder = nil
            meterTimer.invalidate()
            showAlert(title: "Thông báo", message: "Ghi âm hoàn tất")
        } else{
            showAlert(title: "Lỗi", message: "Ghi âm thất bại")
        }
    }
    
    @objc func updateAudioMeter(timer: Timer){
        if audioRecorder != nil && audioRecorder.isRecording {
            let hr = Int((audioRecorder.currentTime / 60) / 60)
            let min = Int(audioRecorder.currentTime / 60)
            let sec = Int(audioRecorder.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            lblTimer.text = totalTimeString
            audioRecorder.updateMeters()
        } else
        if audioPlayer != nil && audioPlayer.isPlaying {
            let hr = Int((audioPlayer.currentTime / 60) / 60)
            let min = Int(audioPlayer.currentTime / 60)
            let sec = Int(audioPlayer.currentTime.truncatingRemainder(dividingBy: 60))
            let totalTimeString = String(format: "%02d:%02d:%02d", hr, min, sec)
            lblTimer.text = totalTimeString
            audioPlayer.updateMeters()
        }
    }
    
    func updateNotRecording(){
        meterTimer = nil
        lblTimer.text = "00.00.00"
        btnRecord.setTitle("Bắt đầu ghi âm", for: .normal)
        btnPlay.isEnabled = true
        isRecording = false
    }
    
    func updateRecording(){
        btnRecord.setTitle("Kết thúc ghi âm", for: .normal)
        btnPlay.isEnabled = false
        isRecording = true
    }
    
    // MARK: - Handle play recorded file
    
    func updateNotPlaying(){
        meterTimer = nil
        lblTimer.text = "00.00.00"
        btnPlay.setTitle("Phát đoạn ghi âm", for: .normal)
        isPlaying = false
        btnRecord.isEnabled = true
    }
    
    func updatePlaying(){
        lblTimer.text = "00.00.00"
        btnPlay.setTitle("Dừng phát", for: .normal)
        isPlaying = true
        btnRecord.isEnabled = false
    }
    
    @objc func handleButtonPlaySelected(){
        if isPlaying {
            audioPlayer.stop()
            updateNotPlaying()
        } else{
            if FileManager.default.fileExists(atPath: getFileURL().path) {
                prepareForPlay()
                audioPlayer.play()
                meterTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateAudioMeter(timer:)), userInfo: nil, repeats: true)
                updatePlaying()
            } else{
                showAlert(title: "Thông báo", message: "Chưa có file ghi âm nào")
            }
        }
    }
    
    func prepareForPlay(){
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: getFileURL())
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
        } catch let error{
            showAlert(title: "Lỗi", message: error.localizedDescription)
        }
    }
}

extension RecordingController: AVAudioRecorderDelegate, AVAudioPlayerDelegate{
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishAudioRecording(success: false)
        }
        updateNotRecording()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        updateNotPlaying()
    }
}
