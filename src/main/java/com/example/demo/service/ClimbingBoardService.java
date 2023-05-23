package com.example.demo.service;

import java.io.*;
import java.util.*;

import org.springframework.beans.factory.annotation.*;
import org.springframework.stereotype.*;
import org.springframework.web.multipart.*;

import com.example.demo.domain.*;
import com.example.demo.mapper.*;

import software.amazon.awssdk.core.sync.*;
import software.amazon.awssdk.services.s3.*;
import software.amazon.awssdk.services.s3.model.*;


@Service
public class ClimbingBoardService {
	
	@Autowired
	private S3Client s3;
	
	@Value("${aws.s3.bucketName}")
	private String bucketName;
	
	@Autowired
	private ClimbingBoardMapper mapper;
	
	@Autowired
	private ClimbingTodayMapper Todaymapper;

	public boolean addClimbingBoard(ClimbingBoard climbingBoard) {
		int cnt = mapper.insert(climbingBoard);
		return cnt == 1;
	}

	public List<ClimbingBoard> listBoard() {
		
		return mapper.selectList();
	}

	public ClimbingBoard getClimbingBoard(Integer id) {
		
		return mapper.selectById(id);
	}
	

	public boolean addClimbingToday(ClimbingToday climbingToday, MultipartFile[] files) throws Exception {
		for(MultipartFile file : files) {
			if(file.getSize() > 0) {
				String objectKey = "today/" + climbingToday.getId() + "/" + file.getOriginalFilename();
				PutObjectRequest por = PutObjectRequest.builder()
						.acl(ObjectCannedACL.PUBLIC_READ)
						.bucket(bucketName)
						.key(objectKey)
						.build();
				RequestBody rb = RequestBody.fromInputStream(file.getInputStream(), file.getSize());
				
				s3.putObject(por, rb);
				
				Todaymapper.insertFileName(climbingToday.getId(), file.getOriginalFilename());
				
			}
		}
		int cnt = Todaymapper.insert(climbingToday);
		return cnt == 1;
	}

	public List<ClimbingToday> listToday() {

		return Todaymapper.selectList();
	}

	public ClimbingToday getClimbingToday(Integer id) {

		return Todaymapper.selectById(id);
	}



}