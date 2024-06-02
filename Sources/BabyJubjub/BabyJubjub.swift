#if canImport(BabyJubjubBridge)
    import BabyJubjubBridge
#endif

import Foundation
import os

/// Swift wrapper for the Rust Baby Jubjub library
public enum BabyJubjub {
    /// Generate a public key from a private key
    /// - Parameters:
    ///     - hexString: the private key as a hex string
    public static func privateKeyToPublicKey(hexString privateKey: String) -> String {
        let privateKeyCString = privateKey.withCString { $0 }
        guard let publicKeyCString = prv2pub(privateKeyCString) else {
            Logger().log("Returned invalid string from prv2pub")
            return ""
        }
        
        let publicKey = String(validatingUTF8: publicKeyCString) ?? ""
        
        publicKeyCString.deallocate()
        
        return publicKey
    }
    
    public static func hashPoseidon(input: String) -> String {
        let inputCString = input.cString(using: .utf8)
        
        guard let hashCString = poseidon_hash(inputCString) else {
            Logger().log("Returned invalid string from poseidon_hash()")
            return ""
        }
        
        let hash = String(validatingUTF8: hashCString) ?? ""
        hashCString.deallocate()
        
        return hash
    }
    
    public static func hashPoseidon(input1: String, input2: String) -> String {
        let input1CString = input1.cString(using: .utf8)
        let input2CString = input2.cString(using: .utf8)
        
        guard let hashCString = poseidon_hash2(input1CString,
                                               input2CString) else {
            Logger().log("Returned invalid string from poseidon_hash2()")
            return ""
        }
        
        let hash = String(validatingUTF8: hashCString) ?? ""
        hashCString.deallocate()
        
        return hash
    }
    
    public static func hashPoseidon(input1: String, input2: String, input3: String) -> String {
        let input1CString = input1.cString(using: .utf8)
        let input2CString = input2.cString(using: .utf8)
        let input3CString = input3.cString(using: .utf8)
        
        guard let hashCString = poseidon_hash3(input1CString,
                                               input2CString,
                                               input3CString) else {
            Logger().log("Returned invalid string from poseidon_hash3()")
            return ""
        }
        
        let hash = String(validatingUTF8: hashCString) ?? ""
        hashCString.deallocate()
        
        return hash
    }
    
    public static func hashPoseidon(input1: String, input2: String, input3: String, input4: String) -> String {
        let input1CString = input1.cString(using: .utf8)
        let input2CString = input2.cString(using: .utf8)
        let input3CString = input3.cString(using: .utf8)
        let input4CString = input4.cString(using: .utf8)
        
        
        guard let hashCString = poseidon_hash4(input1CString,
                                               input2CString,
                                               input3CString,
                                               input4CString) else {
            Logger().log("Returned invalid string from poseidon_hash4()")
            return ""
        }
        
        
        let hash = String(validatingUTF8: hashCString) ?? ""
        hashCString.deallocate()
        
        return hash
    }
    
    public static func signPoseidon(privateKeyHex: String, msg: String) -> String {
        let privateKeyCString = privateKeyHex.cString(using: .utf8)
        let msgCString = msg.cString(using: .utf8)
        
        guard let signedMsgCString = sign_poseidon(privateKeyCString, msgCString) else {
            Logger().log("Returned invalid string from poseidon_hash()")
            return ""
        }
        
        let signedMsg = String(validatingUTF8: signedMsgCString) ?? ""
        signedMsgCString.deallocate()
        
        return signedMsg
    }
}
