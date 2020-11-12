package com.spring.service;

import org.apache.hadoop.conf.Configured;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Job;
import org.apache.hadoop.mapreduce.lib.input.FileInputFormat;
import org.apache.hadoop.mapreduce.lib.output.FileOutputFormat;
import org.apache.hadoop.mapreduce.lib.output.TextOutputFormat;
import org.apache.hadoop.util.Tool;

import net.minidev.json.writer.CollectionMapper.MapClass;

public class WordCounter extends Configured implements Tool {

	@Override
	public int run(String[] args) throws Exception {
		// 1. Job 등록
		Job job = Job.getInstance();
		job.setJarByClass(this.getClass());
		job.setJobName("WordCounter");
		// 2. 입출력 주소 args[]
		FileInputFormat.addInputPath(job, new Path(args[0]));
		FileOutputFormat.setOutputPath(job, new Path(args[1]));
		// 3. 키와 값의 출력 형태 지정
		job.setOutputKeyClass(Text.class);
		job.setOutputValueClass(IntWritable.class);
		// 4. 입출력 포맷 지정
		job.setOutputFormatClass(TextOutputFormat.class);
		// 5. 맵 리듀스 작업에 사용될 클래스 지정
		job.setMapperClass(MapperClass.class);
		job.setCombinerClass(ReducerClass.class);
		job.setReducerClass(ReducerClass.class);
		// 6. 잡 종료 여부 확인
		int success = job.waitForCompletion(true) ? 1 : 0;
		// 7. 잡의 성공 / 실패 여부 확인
		if(job.isSuccessful()) {
			System.out.println("잡 성공");
		}else {
			System.out.println("잡 실패");
		}
		System.out.println(job.getStatus());
		job.close();
		// 8. 자원 반납
		return success;
	}

}