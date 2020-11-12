package kr.co.goodee.controller;

import java.io.BufferedInputStream;

import org.apache.commons.io.IOUtils;
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
	
	FileSystem fs = null;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Model model) {

		return "home";
	}
	
	@RequestMapping(value = "/upload", method = RequestMethod.GET)
	public String upload(Model model) throws Exception {

		String srcPath = "C:/test/word.txt";
		String dstPath = "/store/test";
		
		//파일시스템 이용
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS", "hdfs://localhost:9000");
		fs = FileSystem.get(conf);
		
		//경로 생성 확인
		Path src = new Path(srcPath);
		Path dst = new Path(dstPath);
		if(!fs.exists(dst)) {
			fs.mkdirs(dst);
		}
		//파일 복사 (로컬 -> HDFS)
		fs.copyFromLocalFile(src, dst);
		
		//파일생성 후 확인
		String[] depth = srcPath.split("/");
		dst = new Path(dstPath+"/"+depth[depth.length-1]);
		String msg = "파일 생성 실패";
		if(fs.exists(dst)) {//파일이 생성 되었는가?
			msg = "파일생성 성공";
		}
		fs.close();
		model.addAttribute("msg",msg);
		model.addAttribute("link","http://localhost:9870/explorer.html#/store/test");
		
		return "home";
	}
	

	@RequestMapping(value = "/read", method = RequestMethod.GET)
	public String read(Model model) throws Exception {
		
		Path readPath = new Path("/store/test/word.txt");
		Configuration conf = new  Configuration();
		conf.set("fs.defaultFS", "hdfs://localhost:9000");
		fs = FileSystem.get(conf);
		
		if(fs.exists(readPath)) {
			FSDataInputStream in = fs.open(readPath); //파일열기
			BufferedInputStream bis = new BufferedInputStream(in); //읽기 빨리
			String out = IOUtils.toString(bis,"UTF-8");
			String result = out.replaceAll("\n", "<br/>"); //전처리
			model.addAttribute("content",result);
			//자원반납
			bis.close();
			in.close();
		}
		fs.close();
		
		return "home";
	}
	
	@RequestMapping(value = "/delete", method = RequestMethod.GET)
	public String delete(Model model) throws Exception {
		
		String msg = "삭제에 실패 했습니다";
		
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS", "hdfs://localhost:9000");
		fs = FileSystem.get(conf);
		
		Path delPath = new Path("/store");//삭제 경로
		boolean pathYN = fs.exists(delPath);
		
		if(pathYN) { //경로 확인
			if(fs.delete(delPath, true)) { //경로 삭제(false : 비어있는 폴더가 아니면 못지움)
				msg = "삭제에 성공 했습니다"; //삭제확인
			}
		}
		fs.close();
		model.addAttribute("msg",msg);
		model.addAttribute("link","http://localhost:9870/explorer.html#/");
		
		return "home";
	}
	
}
