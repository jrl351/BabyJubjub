import XCTest
@testable import BabyJubjub

final class BabyJubjubTests: XCTestCase {
    func testPackSignature_doesNotError() throws {
        let signature = "1717fe".padLeft(length: 128, char: "0")
        
        let compressed = try XCTUnwrap(BabyJubjub.packSignature(signature: signature))
        XCTAssertNotNil(compressed)
    }
    
    func testUnpackSignature_doesNotError() throws {
        let signature = "deadbeef".padLeft(length: 128, char: "0")
        
        let decompressed = BabyJubjub.unpackSignature(compressedSignature: signature)
        XCTAssertNotNil(decompressed)
    }
    
    func testPackPoint_doesNotError() throws {
        let x = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        let y = "2626589144620713026669568689430873010625803728049924121243784502389097019475"
        
        let compressed = try XCTUnwrap(BabyJubjub.packPoint(pointX: x, pointY: y))
        XCTAssertNotNil(compressed)
    }
    
    func testUnpackPoint_doesNotError() throws {
        let hexString = "deadbeef".padLeft(length: 128, char: "0")
        
        let decompressed = BabyJubjub.unpackSignature(compressedSignature: hexString)
        XCTAssertNotNil(decompressed)
    }
    
    func testPrivateKeyToPublicKey_doesNotError() {
        let hexString = "42fe".padLeft(length: 64, char: "0")
        
        let result = BabyJubjub.privateKeyToPublicKey(hexString: hexString)
        XCTAssertNotNil(result)
    }
    
    func testPoseidonHash_WithOneInput_doesNotError() {
        let input = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        
        let result = BabyJubjub.poseidonHash(input: input)
        XCTAssertNotNil(result)
    }
    
    func testPoseidonHash_WithTwoInputs_doesNotError() {
        let input1 = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        let input2 = "17777552123799933955779906779655732241715742912184938656739573121738514868268"

        let result = BabyJubjub.poseidonHash(input1: input1, input2: input2)
        XCTAssertNotNil(result)
    }
    
    func testPoseidonHash_WithThreeInputs_doesNotError() {
        let input1 = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        let input2 = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        let input3 = "17777552123799933955779906779655732241715742912184938656739573121738514868268"

        let result = BabyJubjub.poseidonHash(input1: input1, input2: input2, input3: input3)
        XCTAssertNotNil(result)
    }
    
    func testPoseidonHash_WithFourInputs_doesNotError() {
        let input1 = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        let input2 = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        let input3 = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        let input4 = "17777552123799933955779906779655732241715742912184938656739573121738514868268"

        let result = BabyJubjub.poseidonHash(input1: input1,
                                             input2: input2,
                                             input3: input3,
                                             input4: input4)
        XCTAssertNotNil(result)
    }
    
    func testHashPoseidon_doesNotError() {
        let claimsTree = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        let revocationTree = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        let rootsTreeRoot = "17777552123799933955779906779655732241715742912184938656739573121738514868268"

        let result = BabyJubjub.hashPoseidon(claimsTree: claimsTree,
                                             revocationTree: revocationTree,
                                             rootsTreeRoot: rootsTreeRoot)
        XCTAssertNotNil(result)
    }
    
    func testSignPoseidon_signsCorrectly() throws {
        let privateKey = "e38c0dbe6bb723f9532b9ab847f54d8ef200ca14b3619342ff148ee9c682d580"
        
        let message = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        
        let result = BabyJubjub.signPoseidon(privateKeyHex: privateKey,
                                             message: message)
        
        let expectedSignedMessage = "2a580ed879dd4d9d85868301fd6620c530ec147f386895eddec08b52fe2f3e8364f05df303496ffb4f2b64db174613f5828fde0333d18ee49965aa7cdcdd7401"
        XCTAssertEqual(result, expectedSignedMessage)
    }
    
    func testVerifyPoseidon_doesNotError() throws {
        let privateKey = "e38c0dbe6bb723f9532b9ab847f54d8ef200ca14b3619342ff148ee9c682d580"
        
        let message = "17777552123799933955779906779655732241715742912184938656739573121738514868268"
        
        let signedMessage = "2a580ed879dd4d9d85868301fd6620c530ec147f386895eddec08b52fe2f3e8364f05df303496ffb4f2b64db174613f5828fde0333d18ee49965aa7cdcdd7401"
        
        let result = BabyJubjub.verifyPoseidon(privateKey: privateKey,
                                               compressedSignature: signedMessage,
                                               message: message)
        
        XCTAssertNotNil(result)
    }
}

extension String {
    func padLeft(length: Int, char: String) -> String {
        guard self.count < length else {
            return self
        }
        
        let padLength = length - self.count
        let padding = String(repeating: char, count: padLength)
        return padding + self
    }
}
