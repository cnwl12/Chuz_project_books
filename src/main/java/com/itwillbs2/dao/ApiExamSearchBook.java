package com.itwillbs2.dao;

// 네이버 검색 API 예제 - 블로그 검색
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.apache.catalina.connector.Response;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;


public class ApiExamSearchBook {

	// TODO : 오버로딩 줄이기,,,,,,,,,,, 
	
    // 없을 때 
	public JsonObject getBook(String keyWord) {
    	
        String clientId = "SG77rERJkx5teoolk8vI"; //애플리케이션 클라이언트 아이디
        String clientSecret = "FaVoUIMTux"; //애플리케이션 클라이언트 시크릿
        String text = null;
        try {
            text = URLEncoder.encode(keyWord, "UTF-8"); // keyWord 안받았을 때 무조건 받음 (하드코딩)
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }


        String apiURL = "https://openapi.naver.com/v1/search/book.json?query=" + text ;    // JSON 결과
        //String apiURL = "https://openapi.naver.com/v1/search/blog.xml?query="+ text; // XML 결과


        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = get(apiURL,requestHeaders);
      //  System.out.println(responseBody);
        
        
        return JsonParser.parseString(responseBody).getAsJsonObject();
    }

 // 키워드 검색했을 때    
	public JsonObject getBook(String keyWord, int start) {
    	
        String clientId = "SG77rERJkx5teoolk8vI"; //애플리케이션 클라이언트 아이디
        String clientSecret = "FaVoUIMTux"; //애플리케이션 클라이언트 시크릿
        String text = null;
        try {
            text = URLEncoder.encode(keyWord, "UTF-8"); // keyWord 안받았을 때 무조건 받음 (하드코딩)
            
        } catch (UnsupportedEncodingException e) {
            throw new RuntimeException("검색어 인코딩 실패",e);
        }


        String apiURL = "https://openapi.naver.com/v1/search/book.json?query=" + text +"&start="+ start;    // JSON 결과

        Map<String, String> requestHeaders = new HashMap<>();
        requestHeaders.put("X-Naver-Client-Id", clientId);
        requestHeaders.put("X-Naver-Client-Secret", clientSecret);
        String responseBody = get(apiURL,requestHeaders);
        System.out.println(responseBody);
        
        
        return JsonParser.parseString(responseBody).getAsJsonObject();
    }
    
    
    
    
    
    
    // ------------------------------------------------------------------------

    private static String get(String apiUrl, Map<String, String> requestHeaders){
        HttpURLConnection con = connect(apiUrl);
        try {
            con.setRequestMethod("GET");
            for(Map.Entry<String, String> header :requestHeaders.entrySet()) {
                con.setRequestProperty(header.getKey(), header.getValue());
            }


            int responseCode = con.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) { // 정상 호출
                return readBody(con.getInputStream());
            } else { // 오류 발생
                return readBody(con.getErrorStream());
            }
        } catch (IOException e) {
            throw new RuntimeException("API 요청과 응답 실패", e);
        } finally {
            con.disconnect();
        }
    }


    private static HttpURLConnection connect(String apiUrl){
        try {
            URL url = new URL(apiUrl);
            return (HttpURLConnection)url.openConnection();
        } catch (MalformedURLException e) {
            throw new RuntimeException("API URL이 잘못되었습니다. : " + apiUrl, e);
        } catch (IOException e) {
            throw new RuntimeException("연결이 실패했습니다. : " + apiUrl, e);
        }
    }


    private static String readBody(InputStream body){
        InputStreamReader streamReader = new InputStreamReader(body);


        try (BufferedReader lineReader = new BufferedReader(streamReader)) {
            StringBuilder responseBody = new StringBuilder();


            String line;
            while ((line = lineReader.readLine()) != null) {
                responseBody.append(line);
            }


            return responseBody.toString();
        } catch (IOException e) {
            throw new RuntimeException("API 응답을 읽는 데 실패했습니다.", e);
        }
    }
    
}