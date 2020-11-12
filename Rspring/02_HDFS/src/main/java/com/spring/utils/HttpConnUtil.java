package com.spring.utils;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;

public class HttpConnUtil {
	
	/**
	 * @param urls:ArrayList<String>
	 * @param header:HashMap<String,String>
	 * @param params 
	 * @param method:String
	 * @return result:String
	 */
	public String sendMsg(ArrayList<String> urls, HashMap<String, String> header, String params, String method) {
		StringBuffer sb = new StringBuffer();//url 사용 버퍼
		String readLine = "";//읽어들일 문자 변수
		BufferedReader reader = null;//버퍼리더
		String result = "";	
		
		if(method.equals("GET") && params != null) {
			urls.add("?"+params);
		}
		
		for(String url : urls) {	sb.append(url);}//url 조합
				
		try {
			System.out.println("request URL : "+sb.toString());
			
			System.out.println("METHOD : "+method);
			System.out.println("PARAMS : "+params);
			System.out.println("HEADER : "+header);

			
			URL url = new URL(sb.toString());					
			HttpURLConnection con = (HttpURLConnection)url.openConnection();			
			/*			
			con.setConnectTimeout(2000);
			con.setReadTimeout(5000);
			*/
			method = method.toUpperCase();						
			con.setRequestMethod(method);//method 적용   
			con.setDoOutput(true);
				        		
			if(header != null && header.size()>0) {//헤더 값이 있을 경우 추가 해 준다.
				for(String key : header.keySet()) {
					con.setRequestProperty(key, header.get(key));	
				}	
			}			

			if(!method.equals("GET") && params != null) {
				con.getOutputStream().write(params.getBytes("UTF-8")); // POST 호출				]
			}
			
			sb = null;
			sb = new StringBuffer();
			if(con.getResponseCode()==200) {
				reader = new BufferedReader(new InputStreamReader(con.getInputStream()));
			} else {
				reader = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			}			
			
			//메시지를 전송 받는다.			
			while ((readLine = reader.readLine()) != null) {sb.append(readLine);}			
			
			result = sb.toString();
			if(con.getResponseCode()!=200) {
				System.out.println("fail message : "+result);
				result = "failCode : "+con.getResponseCode();
			}						
		} catch (Exception e) {
			e.printStackTrace();
			result = "{\"success\":\"false\",\"message\":\"read time out\"}";
		}finally {
			try {
				if(reader != null) { reader.close();}	
				
				} catch (IOException e) {
					e.printStackTrace();
				}
			System.out.println("result : "+result);
		}
				
		return result;
	}

}