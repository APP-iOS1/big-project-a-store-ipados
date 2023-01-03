//
//  UserAuthenticationModel.swift
//  BigProjectAStoreIpadOS
//
//  Created by 이승준 on 2023/01/02.
//

import FirebaseAuth
import FirebaseFirestore

// MARK: 인증 상태
/// 로그인 상태에 따라 switch 해서 뷰를 전환할 수 있도록 함.
enum AuthenticationState {
	case unAuthenticated
	case authenticating
	case authenticated
}

final class SignUpViewModel: ObservableObject {
	@Published var errorMessage = ""
	@Published var authenticationState: AuthenticationState = .unAuthenticated
	@Published var currentUser: StoreInfo?
	
	let database = Firestore.firestore()
	let authentication = Auth.auth()
	
	
	// MARK: - Create New Store(user)
	/// Auth에 새로운 사용자를 생성합니다.
	/// - Parameter email: 입력받은 사용자의 email
	/// - Parameter password: 입력받은 사용자의 password
	/// - Parameter nickname: 입력받은 사용자의 nickname
	///
	@MainActor
	public func createUser(email: String, password: String, nickname: String) async -> Bool {
		authenticationState = .authenticating
		do  {
			try await authentication.createUser(withEmail: email, password: password)
			print("account created.")
			errorMessage = ""
			authenticationState = .authenticated
			// firestore에 user 등록
			let currentUserId = authentication.currentUser?.uid ?? ""
			registerUser(with: currentUserId, email: email, nickname: nickname)
			return true
		}
		catch {
			print(error.localizedDescription)
			errorMessage = error.localizedDescription
			authenticationState = .unAuthenticated
			return false
		}
	}
	
	// MARK: - Register Store(user) in Firestore
	/// Auth에 새롭게 만든 사용자 정보를 Firestore에 등록합니다.
	/// - Parameter uid: 현재 사용자의 Auth uid
	/// - Parameter email: 현재 사용자의 email
	/// - Parameter nickname: 현재 사용자의 nickname
	private func registerUser(with uid: String, email: String, nickname: String) {
		database.collection("\(appCategory.rawValue)")
			.document(uid)
			.setData([
				"id" : uid,
				"userEmail" : email,
				"userNickname" : nickname
			])
	}
	
	// MARK: - 이메일 중복 검사
	/// 잘 안되고 잇음
	/// 사용자가 입력한 이메일이 이미 사용하고 있는지 검사합니다.
	/// 입력받은 이메일이 DB에 이미 있다면 false를, 그렇지 않다면 true를 반환합니다.
	/// - Parameter currentUserEmail: 입력받은 사용자 이메일
	/// - Returns: 중복된 이메일이 있는지에 대한 Boolean 값
	public func isEmailDuplicated(currentUserEmail: String) async -> Bool {
		do {
			let document = try await database.collection("\(appCategory.rawValue)")
				.whereField("userEmail", isEqualTo: currentUserEmail)
				.getDocuments()
			return !(document.isEmpty)
		} catch {
			print(error.localizedDescription)
			return false
		}
	}
	
	// MARK: - 닉네임 중복 검사
	/// 사용자가 입력한 닉네임이 이미 사용하고 있는지 검사합니다.
	/// 입력받은 닉네임이 DB에 이미 있다면 false를, 그렇지 않다면 true를 반환합니다.
	/// - Parameter currentUserNickname: 입력받은 사용자 닉네임
	/// - Returns: 중복된 닉네임이 있는지에 대한 Boolean 값
	public func isNicknameDuplicated(currentStoreName: String) async -> Bool {
		do {
			let document = try await database.collection("\(appCategory.rawValue)")
				.whereField("storeName", isEqualTo: currentStoreName)
				.getDocuments()
			return !(document.isEmpty)
		} catch {
			print(error.localizedDescription)
			return false
		}
	}
	
	// MARK: - Login
	/// 유저 로그인을 실행합니다.
	/// - Important: 메소드 호출 후 리턴된 값이 `true`일 때, 앱 전체에서 활용할 `StoreUser`를 만드는 requestStoreInfo() 메소드를 `StoreNetworkManager` 모델에서 호출해야 합니다.
	/// - Parameter withEmail: 로그인을 시도하는 이메일
	/// - Parameter withPassword: 로그인 인증을 위한 비밀번호
	/// - Returns: 로그인 성공 시 true, 실패 시 false 를 리턴합니다.
    @MainActor
	public func requestUserLogin(withEmail email: String, withPassword password: String) async -> Bool {
		do {
			try await authentication.signIn(withEmail: email, password: password)
			self.authenticationState = .authenticated
			return true
		} catch {
			dump("DEBUG : LOGIN FAILED \(error.localizedDescription)")
			return false
		}
	}
	
	// MARK: - Logout
	public func requestUserSignOut() {
		do {
			try authentication.signOut()
			self.authenticationState = .unAuthenticated
		} catch {
			dump("DEBUG : LOG OUT FAILED \(error.localizedDescription)")
		}
	}
}
