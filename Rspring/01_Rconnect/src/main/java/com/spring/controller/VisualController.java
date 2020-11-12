package com.spring.controller;

import java.nio.charset.Charset;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.rosuda.REngine.Rserve.RConnection;
import org.rosuda.REngine.Rserve.RserveException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class VisualController {
	
	@RequestMapping(value = "/graph", method = RequestMethod.GET)
	public String graph(Model model) throws Exception {		
		RConnection conn = new RConnection();		
		//https://pandoc.org/installing.html	
		conn.eval("library(plotly)");
		conn.eval("library(htmlwidgets)");
		conn.eval("e <- plot_ly(economics,x=~date,y=~unemploy)");
		conn.eval("e<-add_paths(e)");
		conn.eval("saveWidget(e,'C:/visual/linechart.html',libdir = 'lib')");				
		conn.close();		
		model.addAttribute("fileName", "linechart.html");
		return "home";
	}
	
	@RequestMapping(value = "/textMining", method = RequestMethod.GET)
	public String textMining(Model model) throws Exception {		
		RConnection conn = new RConnection();		
		//https://pandoc.org/installing.html	
		//사용자가 가장 많은 지하철 역 워드 클라우드 만들기
		conn.eval("library(htmlwidgets)");
		conn.eval("library(wordcloud2)");
		conn.eval("library(KoNLP)");
		conn.eval("library(stringr)");
		conn.eval("library(dplyr)");
		conn.eval("sub <- read.csv('C:/R/chap01/data/ch02/202006_SUBWAY.csv')");
		conn.eval("table <- sub %>% mutate(total=승차총승객수+하차총승객수) %>%  select(역명,total)");
		conn.eval("df_words<-table %>% group_by(역명) %>%  summarise(stotal=sum(total),.groups='drop')");
		conn.eval("stations<-df_words %>% arrange(desc(stotal))");
		conn.eval("e<-wordcloud2(stations,size=0.2, color='random-light', shape = 'star')");
		conn.eval("saveWidget(e,'C:/visual/wordcloud.html',selfcontained=FALSE, libdir = 'lib')");
		conn.close();		
		model.addAttribute("fileName", "wordcloud.html");
		return "home";
	}
	
	@RequestMapping(value = "/map", method = RequestMethod.GET)
	public String map(Model model, @RequestParam String file) throws Exception {		
		System.out.println("읽을 스크립트 파일명 : "+file);
		Path path = null;
		String fileName = file.substring(0, file.lastIndexOf("."));
			
		path = Paths.get("C:/visual/script/"+file);//1. 스크립트 파일 가져오기
		if(Files.notExists(path)) {
			path = Paths.get("C:/visual/script/"+file);//1. 스크립트 파일 가져오기
			//2. 스크립트를 한줄씩 읽어오기
			List<String> contents = Files.readAllLines(path, Charset.forName("UTF-8"));
			String cmd = "";
			RConnection conn = new RConnection();		
			for(String line : contents) {
				//System.out.println(line);
				//한줄 읽고 -> ; 있으면 실행 -> 없으면 합치기
				cmd += line;
				if(cmd.length()>0 && cmd.indexOf(";")>-1) {
					System.out.println("eval("+cmd+")");
					conn.eval(cmd);//3. 읽어온 스크립트를 R 명령어로 실행
					cmd = "";
				}			
			}
			conn.close();		
		}
		
		model.addAttribute("fileName", fileName+".html");
		return "home";
	}
	
	
	
	

}
