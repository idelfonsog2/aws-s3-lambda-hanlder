import Foundation
import AWSLambdaRuntime
import AWSLambdaEvents
import AsyncHTTPClient
import Logging

@main
struct S3Handler: LambdaHandler {
    typealias Event = SNSEvent
    typealias Output = Void
    
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    let logger = Logger(label: "com.idelfonso.aws-s3-lambda-handler")
    init(context: LambdaInitializationContext) async throws {
        // you can initialize database connections, libraries, and other resources
    }
    
    func handle(_ event: SNSEvent, context: LambdaContext) async throws {
        logger.info("S3Handler")
        for record in event.records {
            logger.info(" SNS idelfonso \(record.eventSource)")
            
            let s3Event = try jsonDecoder.decode(S3Event.self, from: record.sns.message)
            logger.info("processing s3 event record with key \(s3Event)")
            
            guard let event = s3Event.records.first else {
                throw APIError.noObjectFound
            }
            
            logger.info("processing s3 event record with name \(event.s3.bucket.name)")
            logger.info("processing s3 event record with urlDecodedKey \(event.s3.object.urlDecodedKey)")
            
        }
    }
}

extension JSONEncoder {
    func encodeAsString<T: Encodable>(_ value: T) throws -> String {
        try String(decoding: self.encode(value), as: Unicode.UTF8.self)
    }
}

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, from string: String) throws -> T {
        try self.decode(type, from: Data(string.utf8))
    }
}


enum APIError: Error {
    case exception
    case noObjectFound
}
