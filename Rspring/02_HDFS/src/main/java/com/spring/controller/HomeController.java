package com.spring.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.service.HadoopFileSerivce;

@Controller
public class HomeController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Autowired HadoopFileSerivce service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		return "redirect:/list?path=/";
	}
	
	// 특정 경로의 파일리스트 보기
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Model model, @RequestParam String path) throws Exception {
		logger.info("path : "+path);
		
		if(path==null || path.contentEquals("/")) {
			path="";
		}
		
		String result = service.fileList(path);
		System.out.println(result);
		// String(json 형태) -> 자바 데이터 타입
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String, Object> map = mapper.readValue(result, new TypeReference<Map<String,Object>>() {});
		
		map.put("currPath", path);
		model.addAttribute("fileInfo", map);
		
		return "home";
	}
	
	
	@RequestMapping(value = "/mkdir", method = RequestMethod.GET)
	public String mkdir(Model model, @RequestParam String path) throws Exception {
		logger.info("path : "+path);
		
		model.addAttribute("msg",service.mkdir(path));
		return "home";
	}
	
	@RequestMapping(value = "/delDir", method = RequestMethod.GET)
	public String delDir(Model model, @RequestParam String path) throws Exception {
		logger.info("path : "+path);
		
		model.addAttribute("msg",service.delDir(path));
		return "home";
	}
	
	// Local -> HDFS
	@RequestMapping(value = "/copyFromLocal", method = RequestMethod.POST)
	public String copyFromLocal(Model model, @RequestParam HashMap<String, String> params) throws Exception {
		logger.info("params : "+params);
		
		String srcPath = params.get("srcPath").replace("\\", "/");
		String dstPath = params.get("dstPath")+srcPath.substring(srcPath.lastIndexOf("/"), srcPath.length());
		
		logger.info(srcPath+" =>"+dstPath);
		model.addAttribute("msg", service.copyFromLocal(srcPath,dstPath)); 
		
		return "home";
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(Model model, @RequestParam String path) throws Exception {
		logger.info("path : "+path);
		
		model.addAttribute("content",service.readFile(path));
		return "home";
	}
	
	@RequestMapping(value = "/download", method = RequestMethod.GET)
	public void download(Model model, @RequestParam String path, HttpServletResponse resp) throws Exception {
		logger.info("path : "+path);
		service.copyToLocal(path, resp);
	}
}
