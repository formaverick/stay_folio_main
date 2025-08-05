package com.hotel.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

@Configuration
@PropertySource("classpath:application.properties")
public class AwsConfig {
	//S3와 통신하기 위한 AmazonS3 Bean을 생성
	
	@Value("${cloud.aws.credentials.access-key}")
	private String accessKey;

	@Value("${cloud.aws.credentials.secret-key}")
	private String secretKey;

	@Value("${cloud.aws.region.static}")
	private String region;

	@Bean
	public AmazonS3 amazonS3() {
		// AWS 인증 정보 생성
		BasicAWSCredentials credentials = new BasicAWSCredentials(accessKey, secretKey);
		
		// AmazonS3 클라이언트 생성 및 반환
		return AmazonS3ClientBuilder.standard().withRegion(Regions.fromName(region))
				.withCredentials(new AWSStaticCredentialsProvider(credentials)).build();
	}
}
