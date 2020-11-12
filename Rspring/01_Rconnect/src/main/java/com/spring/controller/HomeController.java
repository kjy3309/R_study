package com.spring.controller;

import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;

import org.rosuda.REngine.REXP;
import org.rosuda.REngine.REXPMismatchException;
import org.rosuda.REngine.REngineException;
import org.rosuda.REngine.RList;
import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		return "home";
	}
	
	@RequestMapping(value = "/ver", method = RequestMethod.GET)
	public String getVersion(Model model) throws RserveException, REXPMismatchException {
		logger.info("R 버전 확인 요청");
		
		// 1. R 과 연결
		RConnection conn = new RConnection();
		// 2. R 코드 실행
		REXP exp = conn.eval("R.version.string");
		// 3. 반환값에서 원하는 데이터 추출
		String ver = exp.asString();
		logger.info(ver);
		// 4. 연결 종료
		conn.close();
		
		model.addAttribute("msg",ver);
		return "home";
	}
	
	@RequestMapping(value = "/reqPage", method = RequestMethod.GET)
	public String reqPage(Model model) {
		return "reqPage";
	}
	
	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insert(Model model, @RequestParam String params) throws REngineException, REXPMismatchException {
		logger.info("params : "+params);
		int[] arr = null;
		// 1. 받아온 값을 숫자 배열로 생성
		if(params.indexOf(",")>-1) {
			String[] values = params.split(",");
			arr = new int[values.length];
			for(int i=0; i<values.length; i++) {
				arr[i] = Integer.parseInt(values[i]);
			}
		}else {
			arr = new int[1];
			arr[0] = Integer.parseInt(params);
		}
		
		
		// 2. R 연결
		RConnection conn = new RConnection();
		// 3. 스크립트 실행
		// 우리가 실행할 R 스크립트
		// x<-c(1,3,5,7,9)
		conn.assign("x", arr); // assign 은 java의 데이터를 R로 전송할 때 (변수명, 보낼 값)
		// y<-x+2
		conn.eval("y<-x+2");
		REXP exp = conn.eval("y");// y
		// 4. 결과 확인
		int[] rData= exp.asIntegers();
		// 5. R 연결 종료
		conn.close();
		
		String result = "R 에서 "+params+" 에 2를 더한 값 : ";
		for(int num : rData) {
			result += num+" ";
		}
		
		model.addAttribute("msg",result);
		
		return "reqPage";
	}
	
	
	@RequestMapping(value = "/dataFrame", method = RequestMethod.POST)
	public @ResponseBody HashMap<String, Object> dataFrame(@RequestBody HashMap<String, Object> params) throws Exception {
		System.out.println(params);
		ArrayList<HashMap<String, String>> paramList = (ArrayList<HashMap<String, String>>) params.get("values");
		int size = paramList.size();
		
		int idx = 0;
		int[] clas = new int[size];
		String[] lec = new String[size];
		int[] score = new int[size];
		String[] name = new String[size];
		
		for(HashMap<String, String> param : paramList) {
			for(String key : param.keySet()) {
				logger.info(idx+"번째 데이터 -> "+key+":"+param.get(key));
				switch(key) {
				case "name":
					name[idx] = param.get(key);
					break;
				case "class":
					clas[idx] = Integer.parseInt(param.get(key));
					break;
				case "lecture":
					lec[idx] = param.get(key);
					break;
				case "score":
					score[idx] = Integer.parseInt(param.get(key));
					break;
				}
			}
			idx++;
		}
		
		RConnection conn = new RConnection();
		conn.assign("name", name);
		conn.assign("lecture", lec);
		conn.assign("score", score);
		conn.assign("class", clas);
		REXP exp = conn.eval("df <- data.frame(name,lecture,score,class)");
		RList list = exp.asList();
		logger.info("df 안에 리스트 갯수 : "+list.size());
		logger.info("1번째 리스트 길이 : "+list.at(0).length());
		
		for(int i=0; i<list.size();i++) {
			//list.at(i).?//컬럼의 내용을 하나씩 뽑아 내기
			logger.info(i+"번째 리스트");
			for(String item : list.at(i).asStrings()) {
				logger.info(item);
			}
		}
		
		/*
		library(dplyr)
		eng <- df %>% filter(lecture=='eng')
		mean(eng$score) # 영어평균
		mean(df$score)   # 전체 점수 평균
		*/
		conn.eval("library(dplyr)");
		conn.eval("eng <- df %>% filter(lecture=='eng')");
		double eAvg = conn.eval("mean(eng$score)").asDouble();
		double tAvg = conn.eval("mean(df$score)").asDouble();
		logger.info(eAvg+"/"+tAvg);
		HashMap<String, Object> result = new HashMap<String, Object>();
		result.put("msg", "영어평균 : "+eAvg+" / 통합평균 : "+tAvg);
		conn.close();		
		
		return result;
	}
}
