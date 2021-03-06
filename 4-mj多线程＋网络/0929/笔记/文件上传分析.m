一、文件上传的步骤
1.设置请求头
* 目的：告诉服务器请求体里面的内容并非普通的参数，而是包含了文件参数
[request setValue:@"multipart/form-data; boundary=heima" forHTTPHeaderField:@"Content-Type"];

2.设置请求体
* 作用：存放参数（文件参数和非文件参数）
1> 非文件参数
[body appendData:HMEncode(@"--heima\r\n")];
[body appendData:HMEncode(@"Content-Disposition: form-data; name=\"username\"\r\n")];

[body appendData:HMEncode(@"\r\n")];
[body appendData:HMEncode(@"张三")];
[body appendData:HMEncode(@"\r\n")];

2> 文件参数
[body appendData:HMEncode(@"--heima\r\n")];
[body appendData:HMEncode(@"Content-Disposition: form-data; name=\"file\"; filename=\"test123.png\"\r\n")];
[body appendData:HMEncode(@"Content-Type: image/png\r\n")];

[body appendData:HMEncode(@"\r\n")];
[body appendData:imageData];
[body appendData:HMEncode(@"\r\n")];

3> 结束标记 ：参数结束的标记
[body appendData:HMEncode(@"--heima--\r\n")];

二、文件的MIMEType
1.百度搜索

2.查找服务器下面的某个xml文件
apache-tomcat-6.0.41\conf\web.xml

3.加载文件时通过Reponse获得
- (NSString *)MIMEType:(NSURL *)url
{
    // 1.创建一个请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    // 2.发送请求（返回响应）
    NSURLResponse *response = nil;
    [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    // 3.获得MIMEType
    return response.MIMEType;
}

4.通过C语言函数
+ (NSString *)mimeTypeForFileAtPath:(NSString *)path
{
	if (![[NSFileManager alloc] init] fileExistsAtPath:path]) {
		return nil;
	}
    
	CFStringRef UTI = UTTypeCreatePreferredIdentifierForTag(kUTTagClassFilenameExtension, (CFStringRef)[path pathExtension], NULL);
    CFStringRef MIMEType = UTTypeCopyPreferredTagWithClass (UTI, kUTTagClassMIMEType);
    CFRelease(UTI);
	if (!MIMEType) {
		return @"application/octet-stream";
	}
    return NSMakeCollectable(MIMEType);
}