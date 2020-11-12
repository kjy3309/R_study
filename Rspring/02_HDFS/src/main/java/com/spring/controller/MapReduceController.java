package com.spring.controller;

import org.apache.hadoop.util.ToolRunner;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.service.HadoopFileSerivce;
import com.spring.service.WordCounter;

@Controller
public class MapReduceController {
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	@Value("#{config['hdfs.host']}") String hdfs;
	
	@RequestMapping(value = "/mapReduce", method = RequestMethod.GET)
	public String mapReduce(Model model, @RequestParam String path) throws Exception {
		logger.info("path = "+path);
		
		// tool : Map-Reduce 를 사용할 클래스
		// args : 실행할 파일 위치, 맵 리듀스 된 파일을 저장할 위치
		String args[] = {hdfs+path, hdfs+"/save/map_reduce/wordcounter"};
		int exitCode;
		String page = "redirect:/list?path=/";
		
		try {
			exitCode = ToolRunner.run(new WordCounter(), args);
			logger.info("exitCode : "+exitCode);
			page = "redirect:/list?path=/save/map_reduce/wordcounter";
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return page;
	}
}