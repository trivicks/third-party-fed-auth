package tplogin

import net.thegreshams.firebase4j.service.*
import com.google.firebase.auth.*
import com.google.firebase.database.*
import grails.converters.JSON


class UserController {

    class FirebaseTxStatus {
		def statusCode
		def message
	}

    def signup() { 
		def googleClientId = params.googleClientID
		def googleAppKeyId = params.googleAppKeyID
		def facebookAppId = params.facebookAppID
		println(" Params received: " + googleClientId + " / " + googleAppKeyId + " / " + facebookAppId)
       	[ googleClientId:googleClientId, googleAppKeyId:googleAppKeyId, facebookAppId:facebookAppId] 
	}
    
	def validateTokenAndCreateAccount() {

		def creds = JSON.parse(params.creds)
		def accessToken = creds.accessToken
		def userID = creds.userID
		def loginType = creds.loginType

		def verifier = getProviderVerifier(loginType)
		def userInfo = verifier.verifyToken(accessToken)
        if(userInfo != null) {
            def fbStatus = storeUserInFirebase(userInfo)
			def data = [
    			'message': fbStatus.message
			]
			render data as JSON

        } else {
			def data = [
    			'message': "Oops...token verification failed! Token may be invalid or expired."
			]
			render data as JSON
        }
	}
	
	private getProviderVerifier(def loginType) {
        if(loginType.equalsIgnoreCase("fb")) {
            return new FacebookTokenVerifier()
        } else {
            return new GoogleTokenVerifier()
        } 
	}

	private storeUserInFirebase(userInfo) {

        Map<String,Object> params = new LinkedHashMap<>();
        params.put("tpid", userInfo.getProviderId());
        params.put("name", userInfo.getName());
        params.put("email", userInfo.getEmail());
        params.put("provider", userInfo.getLoginType());
        params.put("thumbnail", userInfo.getThumbnailLink());

        StringBuilder postData = new StringBuilder();
        for (Map.Entry<String,Object> param : params.entrySet()) {
            if (postData.length() != 0) postData.append('&');
            postData.append(URLEncoder.encode(param.getKey(), "UTF-8"));
            postData.append('=');
            postData.append(URLEncoder.encode(String.valueOf(param.getValue()), "UTF-8"));
        }
        byte[] postDataBytes = postData.toString().getBytes("UTF-8");

        def url = "https://localhost:8483/user"
		println("NodeJS URL is:" + url)
		def conn = new URL(url).openConnection()
        conn.setRequestMethod("POST");
        conn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
        conn.setRequestProperty("Content-Length", String.valueOf(postDataBytes.length));
        conn.setDoOutput(true);
        conn.getOutputStream().write(postDataBytes)
		def respCode = conn.getResponseCode()
		return(analyzeResponseFromNodeJS(respCode))
	}

	def private analyzeResponseFromNodeJS(def respCode) {

        def firebaseTx = new FirebaseTxStatus()
		firebaseTx.statusCode = respCode
		if(respCode == 201) {
			firebaseTx.message = "User was created Authentication DB and details were successfully stored in Firebase DB"
            return firebaseTx
		} else if(respCode == 200 || respCode == 299) {
			firebaseTx.message = "User details were successfully updated in Firebase DB"
            return firebaseTx
		} else if(respCode == 400) {
			firebaseTx.message = "Signup failed. We were unable to retrieve your email ID from the Auth Provider. Please check your security settings with Auth Provider"
            return firebaseTx
		} else if(respCode == 500) {
			firebaseTx.message = "Call to Firebase nodejs service failed!"
            return firebaseTx
		} else {
			firebaseTx.message = "Unhandled status code: " + respCode;
            return firebaseTx
		}

	}

}
