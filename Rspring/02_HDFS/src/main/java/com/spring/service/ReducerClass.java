package com.spring.service;

import java.io.IOException;
import java.util.Iterator;

import org.apache.hadoop.io.IntWritable;
import org.apache.hadoop.mapreduce.Reducer;

public class ReducerClass extends Reducer {

	@Override
	protected void reduce(Object key, Iterable values, Context context) throws IOException, InterruptedException {
		int sum = 0;//같은 단어들의 합산값
		//key = word
		Iterator<IntWritable> valIter = values.iterator();//[1,1,1,1,1]
		
		while(valIter.hasNext()) {
			sum += valIter.next().get();//sum += 1;
		}
		
		context.write(key, new IntWritable(sum));	
	}
	

}
