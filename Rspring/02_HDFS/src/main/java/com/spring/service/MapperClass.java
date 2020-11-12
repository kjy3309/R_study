package com.spring.service;

import java.io.IOException;

import org.apache.hadoop.classification.InterfaceAudience.Private;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;

public class MapperClass extends Mapper<LongWritable, Text, Text, IntWritable> {
	
	// spliter 로 한줄씩 들어온다.
	// 한줄 단위로 열어서 key 와 value 로 나눈다.
	// key 1 형식으로 반환한다.
	
	private Text word = new Text();
	private IntWritable freq = new IntWritable(1);
	
	@Override
	protected void map(LongWritable key, Text value, Context context)
			throws IOException, InterruptedException {
		// key 는 라인번호, value 는 한 줄 값, context 내보낼 map
		String line = value.toString();
		System.out.println(line);
		String[] words = line.split(" "); // 공백단위로 끊음
		for(String w : words) { // map 에 저장
			word.set(w);
			context.write(word,freq);
		}
			
			
	}
	
	
}