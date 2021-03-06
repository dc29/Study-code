一、发送请求的2个对象
1.发送GET请求：ASIHttpRequest

2.发送POST请求：ASIFormDataRequest
* 设置参数
// 同一个key只对应1个参数值，适用于普通“单值参数”
- (void)setPostValue:(id <NSObject>)value forKey:(NSString *)key
// 同一个key（同一个参数名），会对应多个参数值，适用于“多值参数”
- (void)addPostValue:(id <NSObject>)value forKey:(NSString *)key

二、发送请求
1.同步请求
* startSynchronous

2.异步请求
* startAsynchronous

三、监听请求的过程
1.如何监听请求过程
1> 为代理，遵守ASIHTTPRequestDelegate协议，实现协议中的代理方法
request.delegate = self;
- (void)requestStarted:(ASIHTTPRequest *)request;
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders;
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data;
- (void)requestFinished:(ASIHTTPRequest *)request;
- (void)requestFailed:(ASIHTTPRequest *)request;

2> 成为代理，不遵守ASIHTTPRequestDelegate协议，自定义代理方法
request.delegate = self;
[request setDidStartSelector:@selector(start:)];
[request setDidFinishSelector:@selector(finish:)];

3> 设置block
[request setStartedBlock:^{
    NSLog(@"setStartedBlock");
}];
[request setHeadersReceivedBlock:^(NSDictionary *responseHeaders) {
    NSLog(@"setHeadersReceivedBlock--%@", responseHeaders);
}];
[request setDataReceivedBlock:^(NSData *data) {
    NSLog(@"setDataReceivedBlock--%@", data);
}];
[request setCompletionBlock:^{
    NSLog(@"setCompletionBlock");
}];
[request setFailedBlock:^{
    NSLog(@"setFailedBlock");
}];

2.监听的使用注意
* 如果同时设置了block和实现了代理方法，请求过程中，block和代理方法都会调用
* 一般的调用顺序：代理方法 > block

3.如果实现了下面的代理方法，那么responseData\responseString就没有值
- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data;

四、文件下载
1.一般的下载
1> 设置文件下载的保存路径
request.downloadDestinationPath = filepath;

2> 设置进度监听的代理(要想成为进度监听代理，最好遵守ASIProgressDelegate协议)
request.downloadProgressDelegate = self.progressView;

2.断点下载（断点续传）
1> 设置文件下载的临时路径
request.temporaryFileDownloadPath = tempFilepath;

2> 设置支持断点续传
request.allowResumeForFileDownloads = YES;

五、文件上传（设置文件参数）
1.如果知道文件路径，最好就用这个方法（因为简单）
// ASI内部会自动识别文件的MIMEType
[request setFile:file forKey:@"file"];
[request addFile:file forKey:@"file"];
[request setFile:file withFileName:@"basic.pptx" andContentType:@"application/vnd.openxmlformats-officedocument.presentationml.presentation" forKey:@"file"];
// .....

2.如果文件数据是动态产生的，就用这个方法(比如刚拍照完获得的图片数据)
[request setData:data withFileName:@"test.png" andContentType:@"image/png" forKey:@"file"];

六、ASIHttpRequest的常见用法
1.请求超时
@property (atomic, assign) NSTimeInterval timeOutSeconds;

2.获得错误信息
@property (atomic, retain) NSError *error;

3.获得响应数据
// 状态码
@property (atomic, assign,readonly) int responseStatusCode;
// 状态信息
@property (atomic, retain,readonly) NSString *responseStatusMessage;
// 服务器返回的具体数据（NSString格式）
- (NSString *)responseString;
// 服务器返回的具体数据（NSData格式）
- (NSData *)responseData;