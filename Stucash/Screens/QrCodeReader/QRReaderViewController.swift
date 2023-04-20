//
//  QRReederViewController.swift
//  Stucash
//
//  Created by Maksim Karaseu on 19.04.23.
//

import Foundation
import UIKit
import AVFoundation

final class QRReaderViewController: UIViewController,
                                    QRReaderDisplayLogic {
    typealias Models = QRReaderModels
    
    private let interactor: QRReaderBusinessLogic
    private let router: QRReaderRoutingLogic
    
    private var video = AVCaptureVideoPreviewLayer()
    private let session = AVCaptureSession()
    
    private let videoView = UIView()
    private let qrView = UIView()
    private let qrFrameView: QRFrameView = QRFrameView(frame: .zero)
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor.clear
        button.setAttributedTitle(
            NSAttributedString(
                string: "Cancel",
                attributes: [
                    NSAttributedString.Key.foregroundColor : UIColor.stucashGold,
                    NSAttributedString.Key.font : UIFont.stucashRegular(ofSize: 20.0),
                    NSAttributedString.Key.kern : 2.0
                ]
            ),
            for: .normal
        )
        
        return button
    }()
    
    init(interactor: QRReaderBusinessLogic, router: QRReaderRoutingLogic) {
        self.interactor = interactor
        self.router = router
        
        super.init(nibName: nil, bundle: nil)
        
        self.cancelButton.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        
        configureUI()
        
        hidesBottomBarWhenPushed = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        interactor.requestInitForm(Models.InitialData.Request())
    }
    
    @objc func cancelTapped() {
        self.cancelButton.tapped { [weak self] in
            guard let self = self else { return }
            self.router.routeBack()
        }
    }
    
    // MARK: QRReaderDisplayLogic
    func displayInitForm(_ viewModel: Models.InitialData.ViewModel) {
        setupVideo()
        startRunning()
    }
    
    func displayAmountSelection(_ viewModel: Models.AmountSelection.ViewModel) {
        router.routeToAmountSelection()
    }
    
    func displayRedeem(_ viewModel: Models.Redeem.ViewModel) {
        router.routeBack()
    }
    
    func displayStatusError() {
        
    }
    
    // MARK: Private
    private func setupVideo() {
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)

        do {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
        } catch {
            fatalError(error.localizedDescription)
        }

        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]

        video = AVCaptureVideoPreviewLayer(session: session)
        
        video.frame = videoView.bounds
        
        videoView.layer.addSublayer(video)
    }
    
    func startRunning() {
        DispatchQueue.global().async {
            self.session.startRunning()
        }
    }
    
    private func configureUI() {
        configureFields()
    }
    
    override func viewWillLayoutSubviews() {
        view.insetsLayoutMarginsFromSafeArea = false
        
        videoView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(videoView)
        
        videoView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        videoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        videoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        videoView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        
        qrView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(qrView)
        
        qrView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        qrView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        qrView.heightAnchor.constraint(equalToConstant: 200.0).isActive = true
        qrView.widthAnchor.constraint(equalToConstant: 200.0).isActive = true
        
        qrFrameView.translatesAutoresizingMaskIntoConstraints = false
        qrView.addSubview(qrFrameView)
        
        qrFrameView.topAnchor.constraint(equalTo: qrView.topAnchor).isActive = true
        qrFrameView.leadingAnchor.constraint(equalTo: qrView.leadingAnchor).isActive = true
        qrFrameView.trailingAnchor.constraint(equalTo: qrView.trailingAnchor).isActive = true
        qrFrameView.bottomAnchor.constraint(equalTo: qrView.bottomAnchor).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(cancelButton)
        
        cancelButton.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -22.0).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16.0).isActive = true
        cancelButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16.0).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 55.0).isActive = true
    }
    
    private func configureFields() {

    }
}

extension QRReaderViewController: AVCaptureMetadataOutputObjectsDelegate {
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        guard metadataObjects.count > 0 else { return }
        if let object = metadataObjects.first as? AVMetadataMachineReadableCodeObject {
            if object.type == AVMetadataObject.ObjectType.qr {
                if let string = object.stringValue {
                    interactor.requestActionByQRCode(QRReaderModels.QRAction.Request(string: string))
                    self.session.stopRunning()
                }
            }
        }
    }
}
