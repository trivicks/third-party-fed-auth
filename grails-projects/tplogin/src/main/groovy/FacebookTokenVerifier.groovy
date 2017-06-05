package tplogin

import com.google.firebase.auth.*
import com.google.firebase.database.*
import grails.converters.JSON

class FacebookTokenVerifier {

	def verifyToken(def accessToken) {

        def qparms = "access_token=" + accessToken + "&" + "fields=name,email"
        def url = "https://graph.facebook.com/me?" + qparms
        println("Facebook Auth URL is:" + url)
        def conn = new URL(url).openConnection()
        conn.setRequestMethod("GET");
        def respCode = conn.getResponseCode()
        println(respCode)
        if(respCode.equals(200)) {
            println('Access token successfully verified with Facebook!')
            def userDetails = JSON.parse(conn.getInputStream().getText())
            def userInfo = new UserInfo()
			userInfo.setProviderId(String.valueOf(userDetails.id))
			userInfo.setName(userDetails.name)
			userInfo.setEmail(userDetails.email)
			userInfo.setThumbnailLink("")
			userInfo.setAuthToken(accessToken)
			userInfo.setLoginType("fb")
			userInfo.printInfo()
			return(userInfo)
        } else {
            return null;
        }
	}	

}
