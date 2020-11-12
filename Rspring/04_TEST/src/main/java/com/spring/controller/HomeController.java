package com.spring.controller;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.apache.commons.io.IOUtils;
import org.apache.commons.math3.distribution.FDistribution;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
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
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {
		
		return "home";
	}
	
	FileSystem fs = null;
	
	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	public String upload(Model model) throws Exception {
		
			Configuration conf = new Configuration();
			conf.set("fs.defaultFS","hdfs://localhost:9000");
			fs = FileSystem.get(conf);
			
			String srcpath = "C:/test/word.txt";
			String dstpath ="/store/test";
			
			Path src = new Path(srcpath);
			Path dst = new Path(dstpath);
			
			if(!fs.exists(dst)) {
				fs.mkdirs(dst);
			}
			fs.copyFromLocalFile(src, dst);
			
			String[] depth = srcpath.split("/");
			dst = new Path(dst+"/"+depth[depth.length-1]);
			String msg = "다운로드 실패";
			if(fs.exists(dst)) {
				msg = "다운로드 성공";
			}
			fs.close();
			model.addAttribute("msg",msg);
			
		
		return "home";
	}
	
	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(Model model) throws Exception {
		
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS","hdfs://localhost:9000");
		fs = FileSystem.get(conf);
		
		Path readpath = new Path("/store/test/word.txt");
		
		if(fs.exists(readpath)) {
			
			FSDataInputStream in = fs.open(readpath);
			BufferedInputStream bs = new BufferedInputStream(in);
			String out = IOUtils.toString(bs,"UTF-8");
			String result = out.replace("\n", "<br/>");
			in.close();
			bs.close();
			
			model.addAttribute("link",result);
		}
		
		fs.close();
		
		
		return "home";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(Model model) throws Exception {
		
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS","hdfs://localhost:9000");
		fs = FileSystem.get(conf);
		
		Path delpath = new Path("/store");
		String msg = "파일 삭제 실패";
		if(fs.exists(delpath)) {
			if(fs.delete(delpath, true)) {
				msg = "파일 삭제 성공";
			}
			model.addAttribute("msg",msg);
		}
		fs.close();
		
		return "home";
	}
	
	
	
}
