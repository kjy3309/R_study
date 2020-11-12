package com.spring.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataInputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.LocalFileSystem;
import org.apache.hadoop.fs.Path;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.spring.utils.HttpConnUtil;

@Service
public class HadoopFileSerivce {
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Value("#{config['hdfs.host']}") String hdfsHost;
	@Value("#{config['server.host']}") String webHost;
	
	FileSystem fs = null;
	
	public String fileList(String path) {
		
		logger.info("path : "+webHost+path);
		// 서버에 요청을 할거..
		HttpConnUtil conn = new HttpConnUtil();
		ArrayList<String> urls = new ArrayList<String>();
		urls.add(webHost+"/webhdfs/v1/"+path);
		
		return conn.sendMsg(urls, null, "op=LISTSTATUS", "GET");
	}

	public String mkdir(String path) throws Exception {
		String msg = path+" 폴더 생성 실패";
		
		// hdfs 를 사용하기 위한 환경 설정
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS", hdfsHost);
		fs = FileSystem.get(conf);
		
		// 경로 설정 및 생성
		Path mkdirPath = new Path(path);
		if(!fs.exists(mkdirPath)) {
			logger.info("기존 폴더 없으므로 생성");
			if(fs.mkdirs(mkdirPath)) {
				msg = path+" 폴더 생성 성공";
			}
		}else {
			msg = path+" 폴더는 이미 존재합니다.";
		}
		
		fs.close();
		return msg;
	}

	public String delDir(String path) throws Exception {
		String msg = path+" 삭제 실패";
		
		// hdfs 를 사용하기 위한 환경 설정
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS", hdfsHost);
		fs = FileSystem.get(conf);
		
		// 경로 설정 및 생성
		Path delPath = new Path(path);
		
		boolean success = fs.delete(delPath, true); // false 면 비어있지 않은 녀석은 지울 수 없다.
		
		if(success) {
			msg = path+" 삭제 성공";
		}
		
		fs.close();
		
		return msg;
	}

	public String copyFromLocal(String srcPath, String dstPath) throws Exception {
		String msg = "파일 업로드에 실패했습니다.";
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS", hdfsHost);
		fs = FileSystem.get(conf); // HDFS
		
		// LocalFileSystem local = FileSystem.getLocal(conf);//FS
				
		Path src = new Path(srcPath);
		Path dst = new Path(dstPath);
		
		fs.copyFromLocalFile(src, dst);
		
		if(fs.exists(dst)) {
			msg = "파일 업로드에 성공했습니다.";
		}
		
		fs.close();
		return msg;
	}

	public String readFile(String path) throws Exception {
		String result = "";
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS", hdfsHost);
		fs = FileSystem.get(conf);
		
		Path rPath = new Path(path);
		if(fs.exists(rPath)) { // 파일이 존재해야 읽는다.
			// 1. 파일을 열어서 읽는다.
			FSDataInputStream inputStream = fs.open(rPath);
			BufferedInputStream bis = new BufferedInputStream(inputStream);
			// 2. 읽은 파일을 밖으로 내보낸다.
			String out = IOUtils.toString(bis, "UTF-8");
			//System.out.println(out);
			// 줄바꿈 문자 : \n, \r\n
			result = out.replaceAll("\n", "<br>").replaceAll("\r\n", "<br>");
			System.out.println(result);
			// 3. 다쓴 자원은 반납한다.
			bis.close();
			inputStream.close();
		}
		
		fs.close();
		return result;
	}

	public void copyToLocal(String path, HttpServletResponse resp) throws Exception {
		Configuration conf = new Configuration();
		conf.set("fs.defaultFS", hdfsHost);
		
		fs = FileSystem.get(conf);
		
		// 가져올 경로 설정
		Path src = new Path(path);
		FSDataInputStream inputStream = fs.open(src);
		BufferedInputStream bis = new BufferedInputStream(inputStream);
		
		// response 에 읽어온 스트림 넣어서 전달
		// 1. response 설정
		String fileName = path.substring(path.lastIndexOf("/")+1, path.length());
		resp.setContentType("application/octet-stream");
		resp.setHeader("content-Disposition", "attachment; filename=\""+fileName+"\"");
		resp.setHeader("Access-Control-Allow-Origin", "*");
		// 2. response 에서 stream 가져오기
		BufferedOutputStream bos = new BufferedOutputStream(resp.getOutputStream());
		
		// 3. response stream 에 가져온 stream 집어넣기
		int data = 0;
		byte[] arr = new byte[1024];
		while(bis.read(arr) != -1) {
			bos.write(arr);
			arr = new byte[1024];
		}
		bos.flush();
		bos.close();
		
		bis.close();
		inputStream.close();
		fs.close();
	}
	
	
}
