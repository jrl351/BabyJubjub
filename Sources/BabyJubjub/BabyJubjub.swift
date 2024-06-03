#if canImport(BabyJubjubBridge)
    import BabyJubjubBridge
#endif

import Foundation
import os

/// Swift wrapper for the Rust Baby Jubjub library
public enum BabyJubjub {
    /**
     Compress a signature
     - Parameter signature: The signature
     - Returns: If successful, the compressed signature.  If not, nil
     */
    public static func packSignature(signature: String) -> String? {
        let signatureCString = signature.withCString { $0 }
        guard let packedSignatureCString = pack_signature(signatureCString),
              let packedSignature = String(validatingUTF8: packedSignatureCString) else {
            Logger().log("Returned invalid string from pack_signature")
            return nil
        }
        
        packedSignatureCString.deallocate()
        
        return packedSignature
    }
    
    /**
     Decompress a signature
     - Parameter compressedSignature: The compressed signature
     - Returns: If successful, the decompressed signature.  If not, nil
     */
    public static func unpackSignature(compressedSignature: String) -> String? {
        let compressedSignatureCString = compressedSignature.withCString { $0 }
        guard let signatureCString = unpack_signature(compressedSignatureCString),
              let signature = String(validatingUTF8: signatureCString) else {
            Logger().log("Returned invalid string from unpack_signature")
            return nil
        }
        
        signatureCString.deallocate()
        
        return signature
    }
    
    /**
     Compress a point
     - Parameter pointX: The X coordinate of the point
     - Parameter pointY: The Y coordinate of the point
     - Returns: If successful, the compressed point. If not, nil
     */
    public static func packPoint(pointX: String, pointY: String) -> String? {
        let pointXCString = pointX.withCString { $0 }
        let pointYCString = pointY.withCString { $0 }
        
        guard let packedPointCString = pack_point(pointXCString, pointYCString),
              let packedPoint = String(validatingUTF8: packedPointCString) else {
            Logger().log("Returned invalid string from pack_point")
            return nil
        }
        
        packedPointCString.deallocate()
        
        return packedPoint
    }
    
    /**
     Decompress a point
     - Parameter compressedPoint: The compressedPoint
     - Returns: If successful, the decompressed point.  If not, nil
     */
    public static func unpackPoint(compressedPoint: String) -> String? {
        let compressedPointCString = compressedPoint.withCString { $0 }
        guard let pointCString = unpack_point(compressedPointCString),
              let point = String(validatingUTF8: pointCString) else {
            Logger().log("Returned invalid string from unpack_point")
            return nil
        }
        
        pointCString.deallocate()
        
        return point
    }
    
    /**
     Generate a public key from a private key
     - Parameter hexString: The private key as a hex string, 64-characters long, padded with zeros
     - Returns: If successful, the public key.  If not, nil
     */
    public static func privateKeyToPublicKey(hexString privateKey: String) -> String? {
        let privateKeyCString = privateKey.withCString { $0 }
        guard let publicKeyCString = prv2pub(privateKeyCString),
              let publicKey = String(validatingUTF8: publicKeyCString) else {
            Logger().log("Returned invalid string from prv2pub")
            return nil
        }
        
        publicKeyCString.deallocate()
        
        return publicKey
    }
    
    /**
     Run poseidon hash with one input
     - Parameter input: The hash input
     - Returns: If successful, the hash.  If not, nil
     */
    public static func poseidonHash(input: String) -> String? {
        let inputCString = input.cString(using: .utf8)
        
        guard let hashCString = poseidon_hash(inputCString),
              let hash = String(validatingUTF8: hashCString) else {
            Logger().log("Returned invalid string from poseidon_hash()")
            return nil
        }
        
        hashCString.deallocate()
        
        return hash
    }
    
    /**
     Run poseidon hash with two inputs
     - Parameter input1: The first hash input
     - Parameter input2: The second hash input
     - Returns: If successful, the hash.  If not, nil
     */
    public static func poseidonHash(input1: String, input2: String) -> String? {
        let input1CString = input1.cString(using: .utf8)
        let input2CString = input2.cString(using: .utf8)
        
        guard let hashCString = poseidon_hash2(input1CString,
                                               input2CString),
              let hash = String(validatingUTF8: hashCString) else {
            Logger().log("Returned invalid string from poseidon_hash2()")
            return nil
        }
        
        hashCString.deallocate()
        
        return hash
    }
    
    /**
     Run poseidon hash with three inputs
     - Parameter input1: The first hash input
     - Parameter input2: The second hash input
     - Parameter input3: The third hash input
     - Returns: If successful, the hash.  If not, nil
     */
    public static func poseidonHash(input1: String, input2: String, input3: String) -> String? {
        let input1CString = input1.cString(using: .utf8)
        let input2CString = input2.cString(using: .utf8)
        let input3CString = input3.cString(using: .utf8)
        
        guard let hashCString = poseidon_hash3(input1CString,
                                               input2CString,
                                               input3CString),
              let hash = String(validatingUTF8: hashCString) else {
            Logger().log("Returned invalid string from poseidon_hash3()")
            return nil
        }
        
        hashCString.deallocate()
        
        return hash
    }
    
    /**
     Run poseidon hash with four inputs
     - Parameter input1: The first hash input
     - Parameter input2: The second hash input
     - Parameter input3: The third hash input
     - Parameter input4: The fourth hash input
     - Returns: If successful, the hash.  If not, nil
     */
    public static func poseidonHash(input1: String, input2: String, input3: String, input4: String) -> String? {
        let input1CString = input1.cString(using: .utf8)
        let input2CString = input2.cString(using: .utf8)
        let input3CString = input3.cString(using: .utf8)
        let input4CString = input4.cString(using: .utf8)
        
        guard let hashCString = poseidon_hash4(input1CString,
                                               input2CString,
                                               input3CString,
                                               input4CString),
              let hash = String(validatingUTF8: hashCString) else {
            Logger().log("Returned invalid string from poseidon_hash4()")
            return ""
        }
        
        hashCString.deallocate()
        
        return hash
    }
    
    /**
     Run poseidon hash with the hash of three trees
     - Parameter claimsTree: The claims tree hash
     - Parameter revocationTree: The revocation tree hash
     - Parameter rootsTreeRoot: The hash of the roots tree
     - Returns: If successful, the hash.  If not, nil
     */
    public static func hashPoseidon(claimsTree: String, revocationTree: String, rootsTreeRoot: String) -> String? {
        let claimsTreeCString = claimsTree.cString(using: .utf8)
        let revocationTreeCString = revocationTree.cString(using: .utf8)
        let rootsTreeRootCString = rootsTreeRoot.cString(using: .utf8)
        
        guard let hashCString = hash_poseidon(claimsTreeCString,
                                              revocationTreeCString,
                                              rootsTreeRootCString),
              let hash = String(validatingUTF8: hashCString) else {
            Logger().log("Returned invalid string from hash_poseidon()")
            return nil
        }
        
        hashCString.deallocate()
        
        return hash
    }
    
    /**
     Use poseidon to sign a message
     - Parameter privateKey: The private key as a hex string
     - Parameter msg: The message
     - Returns: If successful, the signed message.  If not, nil
     */
    public static func signPoseidon(privateKeyHex: String, message: String) -> String? {
        let privateKeyCString = privateKeyHex.cString(using: .utf8)
        let messageCString = message.cString(using: .utf8)
        
        guard let signedMsgCString = sign_poseidon(privateKeyCString, messageCString),
              let signedMsg = String(validatingUTF8: signedMsgCString) else {
            Logger().log("Returned invalid string from poseidon_hash()")
            return ""
        }
        
        signedMsgCString.deallocate()
        
        return signedMsg
    }
    
    /**
     Run verify a signed message with a private key
     - Parameter privateKey: The private key
     - Parameter compressedSignature: The signature
     - Parameter message: The message
     - Returns: If successful, the result.  If not, nil
     */
    public static func verifyPoseidon(privateKey: String, compressedSignature: String, message: String) -> Bool? {
        let privateKeyCString = privateKey.cString(using: .utf8)
        let compressedSignatureCString = compressedSignature.cString(using: .utf8)
        let messageCString = message.cString(using: .utf8)
        
        guard let verifyCString = verify_poseidon(privateKeyCString,
                                                  compressedSignatureCString,
                                                  messageCString),
              let verify = String(validatingUTF8: verifyCString) else {
            Logger().log("Returned invalid string from hash_poseidon()")
            return nil
        }
        
        verifyCString.deallocate()
        
        return verify == "1"
    }
}
