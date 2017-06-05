package tplogin

import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken
import com.google.api.client.googleapis.auth.oauth2.GoogleIdToken.Payload
import com.google.api.client.googleapis.auth.oauth2.GoogleIdTokenVerifier
import com.google.api.client.json.jackson2.JacksonFactory
import com.google.api.client.http.javanet.NetHttpTransport
import grails.converters.JSON

class GoogleTokenVerifier {


    def verifyToken(def accessToken) {

        def qparms = "id_token=" + accessToken
        def url = "https://www.googleapis.com/oauth2/v3/tokeninfo?" + qparms
        println("Google Auth URL is:" + url)
        def conn = new URL(url).openConnection()
        conn.setRequestMethod("GET");
        def respCode = conn.getResponseCode()
        println(respCode)
        if(respCode.equals(200)) {
            println('Access token successfully verified with Google!')
            def userDetails = JSON.parse(conn.getInputStream().getText())
            def userInfo = new UserInfo()
            userInfo.setProviderId(userDetails.sub)
            userInfo.setName(userDetails.name)
            userInfo.setEmail(userDetails.email)
            userInfo.setThumbnailLink(userDetails.picture)
            userInfo.setAuthToken(accessToken)
            userInfo.setLoginType("gl")
            userInfo.printInfo()
            return(userInfo)
        } else {
            return null;
        }
    }
}
