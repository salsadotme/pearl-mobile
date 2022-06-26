////
////  LoginViewr.swift
////  Pearl
////
////  Created by Zorayr Khalapyan on 6/25/22.
////
//
//import UIKit
//
//func onMainThread(_ closure: @escaping () -> Void) {
//    if Thread.isMainThread {
//        closure()
//    } else {
//        DispatchQueue.main.async {
//            closure()
//        }
//    }
//}
//
//struct LoginViewController: UIViewController {
//    var walletConnect: WalletConnect!
//    
//    init() {
//        walletConnect = WalletConnect(delegate: self)
//    }
//    
//    var body: some View {
//        Button("foo") {
//            
//        }
//    }
//}
//
//extension LoginView: WalletConnectDelegate {
//    func failedToConnect() {
//        onMainThread { [unowned self] in
//            if let handshakeController = self.handshakeController {
//                handshakeController.dismiss(animated: true)
//            }
//            UIAlertController.showFailedToConnect(from: self)
//        }
//    }
//    
//    func didConnect() {
//        onMainThread { [unowned self] in
//            self.actionsController = ActionsViewController.create(walletConnect: self.walletConnect)
//            if let handshakeController = self.handshakeController {
//                handshakeController.dismiss(animated: false) { [unowned self] in
//                    self.present(self.actionsController, animated: false)
//                }
//            } else if self.presentedViewController == nil {
//                self.present(self.actionsController, animated: false)
//            }
//        }
//    }
//    
//    func didDisconnect() {
//        onMainThread { [unowned self] in
//            if let presented = self.presentedViewController {
//                presented.dismiss(animated: false)
//            }
//            UIAlertController.showDisconnected(from: self)
//        }
//    }
//}
//
//struct LoginView_Previews: PreviewProvider {
//    static var previews: some View {
//        LoginView()
//    }
//}
