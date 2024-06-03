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
        guard let packedSignatureCString = pack_signature(signature),
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
        guard let signatureCString = unpack_signature(compressedSignature),
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
        guard let packedPointCString = pack_point(pointX, pointY),
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
        guard let pointCString = unpack_point(compressedPoint),
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
        guard let publicKeyCString = prv2pub(privateKey),
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
        guard let hashCString = poseidon_hash(input),
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
        guard let hashCString = poseidon_hash2(input1, input2),
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
        guard let hashCString = poseidon_hash3(input1, input2, input3),
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
        guard let hashCString = poseidon_hash4(input1, input2, input3, input4),
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
        guard let hashCString = hash_poseidon(claimsTree, revocationTree, rootsTreeRoot),
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
        guard let signedMsgCString = sign_poseidon(privateKeyHex, message),
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
        guard let verifyCString = verify_poseidon(privateKey, compressedSignature, message),
              let verify = String(validatingUTF8: verifyCString) else {
            Logger().log("Returned invalid string from hash_poseidon()")
            return nil
        }
        
        verifyCString.deallocate()
        
        return verify == "1"
    }
}
