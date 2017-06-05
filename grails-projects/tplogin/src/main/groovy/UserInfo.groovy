package tplogin

class UserInfo {

	def providerId
	def name
	def email
	def thumbnailLink
	def authToken
	def loginType

	def printInfo() {

		println('Auth provider user id: ' + providerId)
		println('User name: ' + name)
		println('User email: ' + email)
		println('User login type: ' + loginType)
		println('User thumbnail link: ' + thumbnailLink)
	}
}
