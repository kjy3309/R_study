package com.spring.controller;

import java.io.BufferedInputStream;
import java.io.IOException;

import org.apache.commons.io.IOUtils;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	FileSystem fs = null;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		return "home";
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	public String upload(Model model) throws Exception {
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS", "hdfs://localhost:9000");
		fs = FileSystem.get(conf);
		
		String srcPath = "c:/test/word.txt";
		String dstPath = "/store/test/";
		String filePath = "/store/test/word.txt";
		
		Path dst = new Path(dstPath);
		if(!fs.exists(dst)) {
			fs.mkdirs(dst);
		}
		
		Path src = new Path(srcPath);
		Path file = new Path(filePath);
		
		if(!fs.exists(file)) {
			fs.copyFromLocalFile(src, dst);
			if(fs.exists(file)) {
				model.addAttribute("msg", "파일 생성 성공");
			}else {
				model.addAttribute("msg", "파일 생성 실패");
			}
		}
		
		fs.close();
		String page = "http://localhost:9870/explorer.html#/store/test";
		model.addAttribute("page", page);
		
		return "home";
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(Model model) throws Exception {
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS", "hdfs://localhost:9000");
		fs = FileSystem.get(conf);
		
		String dstPath = "/store/test/word.txt";
		Path dst = new Path(dstPath);
		
		BufferedInputStream bis = new BufferedInputStream(fs.open(dst));
		
		if(fs.exists(dst)) {
			String result = IOUtils.toString(bis, "UTF-8");
			String content = result.replaceAll("\n", "<br/>");
			model.addAttribute("content", content);
			bis.close();
		}
		
		fs.close();
		
		return "home";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(Model model) throws Exception {
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS", "hdfs://localhost:9000");
		fs = FileSystem.get(conf);
		
		String delPath = "/store/test/word.txt";
		Path del = new Path(delPath);
		
		if(fs.exists(del)) {
			if(fs.delete(del, true)) {
				model.addAttribute("msg", "삭제 성공");
			}else {
				model.addAttribute("msg", "삭제 실패");
			}
		} else {
			model.addAttribute("msg", "삭제하려는 파일이 존재하지 않아요.");
		}
		
		fs.close();
		return "home";
	}
}
