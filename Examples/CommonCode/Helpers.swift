import Foundation

extension String {
    func toData() -> Data? {
        return self.data(using: .utf8, allowLossyConversion: false)
    }
}

extension Dictionary {
    func toData() -> Data? {
        do {
            if #available(OSX 10.13, iOS 11.0, *) {
                return try NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: true) as Data?
            } else {
                return NSKeyedArchiver.archivedData(withRootObject: self) as Data?
            }
        } catch {
            return nil
        }
    }
}

extension Data {
    func toString() -> String? {
        return String(data: self, encoding: .utf8)
    }

    func toDictionary() -> [String: AnyObject]? {
        do {
            if #available(OSX 10.11, iOS 11.0, *) {
                return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(self) as? [String : AnyObject]
            } else {
                return NSKeyedUnarchiver.unarchiveObject(with: self) as? [String: AnyObject]
            }
        } catch {
            return nil
        }
    }
}
