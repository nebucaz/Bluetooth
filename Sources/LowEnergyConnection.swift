//
//  LowEnergyConnection.swift
//  Bluetooth
//
//  Created by Alsey Coleman Miller on 11/29/17.
//  Copyright © 2017 PureSwift. All rights reserved.
//

public extension BluetoothHostControllerInterface {
    
    /// LE Create Connection Cancel Command
    ///
    /// The LE_Create_Connection_Cancel command is used to cancel the LE_Create_Connection command.
    /// This command shall only be issued after the LE_Create_Connection command has been issued,
    /// a Command Status event has been received for the LE Create Connection command and before 
    /// the LE Connection Complete event.
    func lowEnergyCreateConnectionCancel(timeout: HCICommandTimeout = .default) throws {
        
        // cancel connection
        try deviceRequest(HCILowEnergyCommand.createConnectionCancel, timeout: timeout)
    }
    
    /// LE Read Suggested Default Data Length Command
    ///
    /// This command allows the Host to read the Host's suggested values (SuggestedMaxTxOctets and SuggestedMaxTxTime)
    /// for the Controller's maximum transmitted number of payload octets and maximum packet transmission time to be used for new connections.
    func lowEnergyReadSuggestedDefaultDataLength(timeout: HCICommandTimeout = .default) throws -> HCILowEnergyCommand.HCILEReadSuggestedDefaultDataLength {
        
        return try deviceRequest(HCILowEnergyCommand.HCILEReadSuggestedDefaultDataLength.self, timeout: timeout)
    }
    
    /// LE Read Local P-256 Public Key Command
    ///
    /// This command is used to return the local P-256 public key from the Controller.
    func lowEnergyReadLocalP256PublicKey(timeout: HCICommandTimeout = .default) throws -> UInt512 {
        
        let event = try deviceRequest(HCILowEnergyCommand.readLocalP256PublicKeyCommand,
                          LowEnergyEvent.ReadLocalP256PublicKeyCompleteEventParameter.self,
                          timeout: timeout)
        
        switch event.status {
            
        case let .error(error):
            throw error
            
        case .success:
            
            return event.localP256PublicKey
        }
    }
}
