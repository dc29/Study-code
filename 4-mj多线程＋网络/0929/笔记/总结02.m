一、大文件下载
1.方案：利用NSURLConnection和它的代理方法
1> 发送一个请求
// 1.URL
NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/resources/videos.zip"];
// 2.请求
NSURLRequest *request = [NSURLRequest requestWithURL:url];
// 3.下载(创建完conn对象后，会自动发起一个异步请求)
[NSURLConnection connectionWithRequest:request delegate:self];

2> 在代理方法中处理服务器返回的数据
/**
 在接收到服务器的响应时：
 1.创建一个空的文件
 2.用一个句柄对象关联这个空的文件，目的是：方便后面用句柄对象往文件后面写数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // 文件路径
    NSString *caches = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSString *filepath = [caches stringByAppendingPathComponent:@"videos.zip"];
    
    // 创建一个空的文件 到 沙盒中
    NSFileManager *mgr = [NSFileManager defaultManager];
    [mgr createFileAtPath:filepath contents:nil attributes:nil];
    
    // 创建一个用来写数据的文件句柄
    self.writeHandle = [NSFileHandle fileHandleForWritingAtPath:filepath];
}

/**
 在接收到服务器返回的文件数据时，利用句柄对象往文件的最后面追加数据
 */
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // 移动到文件的最后面
    [self.writeHandle seekToEndOfFile];
    
    // 将数据写入沙盒
    [self.writeHandle writeData:data];
}

/**
 在所有数据接收完毕时，关闭句柄对象
 */
- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // 关闭文件
    [self.writeHandle closeFile];
    self.writeHandle = nil;
}

2.注意点：千万不能用NSMutableData来拼接服务器返回的数据

二、NSURLConnection发送异步请求的方法
1.block形式 - 除开大文件下载以外的操作，都可以用这种形式
[NSURLConnection sendAsynchronousRequest:<#(NSURLRequest *)#> queue:<#(NSOperationQueue *)#> completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
    
}];

2.代理形式 - 一般用在大文件下载
// 1.URL
NSURL *url = [NSURL URLWithString:@"http://localhost:8080/MJServer/login?username=123&pwd=123"];
// 2.请求
NSURLRequest *request = [NSURLRequest requestWithURL:url];
// 3.下载(创建完conn对象后，会自动发起一个异步请求)
[NSURLConnection connectionWithRequest:request delegate:self];

三、NSURLSession
1.使用步骤
1> 获得NSURLSession对象
2> 利用NSURLSession对象创建对应的任务（Task）
3> 开始任务（[task resume]）

2.获得NSURLSession对象
1> [NSURLSession sharedSession]
2>
NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
self.session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:[NSOperationQueue mainQueue]];

3.任务类型
1> NSURLSessionDataTask
* 用途：用于非文件下载的GET\POST请求
NSURLSessionDataTask *task = [self.session dataTaskWithRequest:request];
NSURLSessionDataTask *task = [self.session dataTaskWithURL:url];
NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
    
}];

2> NSURLSessionDownloadTask
* 用途：用于文件下载（小文件、大文件）
NSURLSessionDownloadTask *task = [self.session downloadTaskWithRequest:request];
NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:url];
NSURLSessionDownloadTask *task = [self.session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
    
}];