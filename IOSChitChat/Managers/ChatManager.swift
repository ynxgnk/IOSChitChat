//
//  ChatManager.swift
//  IOSChitChat
//
//  Created by Nazar Kopeyka on 19.04.2023.
//

import StreamChat /* 9 */
import StreamChatUI /* 10 */
import Foundation

final class ChatManager { /* 11 */
    static let shared = ChatManager() /* 12 */
    
    private var client: ChatClient! /* 15 */
    
    private let tokens = [ /* 64 */
        "stevejobs": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoic3RldmVqb2JzIn0.dbF3ObfVunOkdjTnEBO9TorkhvqejRpSW4j_p3tAnIM", /* 65 */
        "markz": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoibWFya3oifQ.9RzOZkZ91_fAFFW7Z2KRXDOSOMEXtFaUaymfu9lSP5k" /* 66 */
    ]
    
    func setUp() { /* 13 */
        let client = ChatClient(config: .init(apiKey: .init("mxhuqh6xgmd3"))) /* 14 */
        self.client = client /* 16 */
    }
    
    //Authentication
    
    func signIn(with username: String, completion: @escaping (Bool) -> Void) { /* 17 */
        guard !username.isEmpty else { /* 67 */
            completion(false) /* 68 */
            return /* 69 */
        }
        
        guard let token = tokens[username.lowercased()] else { /* 71 */
            completion(false) /* 72 */
            return /* 73 */
        }
        
        client.connectUser(
            userInfo: UserInfo(id: username, name: username),
            token: Token(stringLiteral: token)
        ) { error in
                completion(error == nil) /* 74 */
            } /* 70 */
    }
    
    func signOut() { /* 18 */
        client.disconnect() /* 75 */
        client.logout() /* 76 */
    }
    
    var isSignedIn: Bool { /* 19 */
//        return false /* 20 */
        return client.currentUserId != nil /* 77 */
    }
    
    var currentUser: String? { /* 21 */
        return client.currentUserId /* 22 change nil */
    }
    
    //chanelList
    
    public func createChanelList() -> UIViewController? { /* 23 */ /* 89 make in nolable (add ?) */
        guard let id = currentUser else { return nil } /* 88 */
        let list = client.channelListController(query: .init(filter: .containMembers(userIds: [id]))) /* 87 */
        
        let vc = ChatChannelListVC() /* 91 */
        vc.content = list /* 92 */
        list.synchronize() /* 90 important for live updates */
        return vc /* 24 */ /* 93 change UIViewController() */
    }
    
    public func createNewChannel(name: String) { /* 25 */
        guard let current = currentUser else { /* 156 */
            return /* 157 */
        }
        let keys: [String] = tokens.keys.filter({ $0 != current }).map { $0 } /* 158 */ /* 172 add .map and [String] */
//        print(keys) /* 159 */
//        return /* 160 */
        do { /* 151 */
            let result = try client.channelController(
                createChannelWithId: .init(type: .messaging, id: name),
                name: name,
                members: Set(keys), /* 173 change [] */
                isCurrentUserMember: true
            ) /* 153 */
            result.synchronize() /* 155 */
        }
        catch { /* 152 */
            print("\(error)") /* 154 */
        }
    }
}
