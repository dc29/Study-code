//
//  HMViewController.m
//  07-AFN02-文件上传
//
//  Created by apple on 14-9-23.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMViewController.h"
#import "AFNetworking.h"

@interface HMViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)upload;
@end

@implementation HMViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"请选择图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"相册", nil];
#warning otherButtonTitles这里面的按钮是一组， 在一起的; sheet必须在WINDOWS上;
    [sheet showInView:self.view.window];
}

#pragma mark - UIActionSheet
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    // 设置代理
    ipc.delegate = self;
    
    switch (buttonIndex) {
#warning 注意在CASE后面定义一个变量， 需要用{}扩住;
        case 0: { // 拍照
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return; // 如果照相机不给用;
            ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
            break;
        }
        case 1: { // 相册
            if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) return;
            ipc.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            break;
        }
        default:
            break;
    }
    
    // 显示控制器 ;
#warning 注意MODAL出来一个新控制器的时候， 原来的控制器就暂时在窗口中移除了;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 *  在选择完图片后调用
 *
 *  @param info   里面包含了图片信息
 */
// 不管拍照还是从照片里面选择图片回来， 都到这个代理方法;
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    // 销毁控制器 ; MODAL出来的必须DISMISS
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    // 获得图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    // 显示图片
    self.imageView.image = image;
}

- (void)upload1
{
    // 1.创建一个管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装参数(这个字典只能放非文件参数)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"123";
    params[@"age"] = @20;
    params[@"pwd"] = @"456";
    params[@"height"] = @1.55;
    
    // 2.发送一个请求
    NSString *url = @"http://localhost:8080/MJServer/upload";
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 在发送请求之前会自动调用这个block
        // 需要在这个block中添加文件参数到formData中
        
        /**
         FileURL : 需要上传的文件的URL路径
         name : 服务器那边接收文件用的参数名
         fileName : （告诉服务器）所上传文件的文件名
         mimeType : 所上传文件的文件类型
         */
        NSURL *url = [[NSBundle mainBundle] URLForResource:@"itcast" withExtension:@"txt"];
        [formData appendPartWithFileURL:url name:@"file" fileName:@"test.txt" mimeType:@"text/plain" error:nil]; // 确实知道URL用这个;
        
        /**
         FileData : 需要上传的文件的具体数据
         name : 服务器那边接收文件用的参数名
         fileName : （告诉服务器）所上传文件的文件名
         mimeType : 所上传文件的文件类型
         */
        //        UIImage *image = [UIImage imageNamed:@"minion_01"];
        //        NSData *fileData = UIImagePNGRepresentation(image);
        //        [formData appendPartWithFileData:fileData name:@"file" fileName:@"haha.png" mimeType:@"image/png"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"上传成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败");
    }];
}

- (IBAction)upload {
    if (self.imageView.image == nil) return;
    
    // 1.创建一个管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.封装参数(这个字典只能放非文件参数)
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"username"] = @"123";
    params[@"age"] = @20;
    params[@"pwd"] = @"456";
    params[@"height"] = @1.55;
    
    // 2.发送一个请求
    NSString *url = @"http://192.168.15.172:8080/MJServer/upload";
    [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        NSData *fileData = UIImageJPEGRepresentation(self.imageView.image, 1.0);
        [formData appendPartWithFileData:fileData name:@"file" fileName:@"haha.jpg" mimeType:@"image/jpeg"];

        // 不是用这个方法来设置文件参数
//        [formData appendPartWithFormData:fileData name:@"file"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"上传成功");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"上传失败");
    }];
    
    // 文件下载，文件比较大，断点续传技术：普遍所有的HTTP服务器都支持
    // 文件上传，文件比较大，断点续传技术：一般的HTTP服务器都不支持，常用的技术用的是Socket（TCP\IP、UDP）
}
@end
