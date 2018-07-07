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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cài đặt lời chào"
        view.backgroundColor = .white
        checkRecordingPermission()
    }
    
    // MARK: - Check permission
    
    func checkRecordingPermission(){
        switch AVAudioSession.sharedInstance().recordPermission {
        case .granted:
            isAudioRecordingGranted = true
            break
        case .denied:
            isAudioRecordingGranted = false
            break
        case .undetermined:
            AVAudioSession.sharedInstance().requestRecordPermission { (granted) in
                if granted{
                    self.isAudioRecordingGranted = true
                } else{
                    self.isAudioRecordingGranted = false
                }
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
                
            } catch let error{
                showAlert(title: "Lỗi", message: error.localizedDescription)
            }
        } else{
            showAlert(title: "Lỗi", message: "Bạn không có quyền sử dụng microphone")
        }
    }
}
