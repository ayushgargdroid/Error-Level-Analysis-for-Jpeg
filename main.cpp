//g++ main.cpp `pkg-config opencv --cflags --libs` 

#include <opencv2/highgui/highgui.hpp>
#include <iostream>

using namespace std;
using namespace cv;

int main(){
	int scale = 10, quality = 90;
	cv::Mat inImg, compImg, outImg;
	std::vector<int> parameters;
	string imgLoc;
	cout<<"Enter Location"<<endl;
	getline(cin,imgLoc);
	inImg = cv::imread(imgLoc);
	cv::imshow("Input Image",inImg);
	parameters.push_back(CV_IMWRITE_JPEG_QUALITY);
   	parameters.push_back(quality);
   	cv::imwrite("temp.jpg",inImg);
   	compImg = cv::imread("temp.jpg");
   	outImg = cv::Mat::zeros(inImg.rows,inImg.cols,CV_8UC3);
   	for(int i=0;i<inImg.rows;i++){
   		uchar* ptr_in = inImg.ptr<uchar>(i);
   		uchar* ptr_comp = compImg.ptr<uchar>(i);
   		uchar* ptr_out = outImg.ptr<uchar>(i);
   		for(int j=0;j<inImg.cols;j++){
   			ptr_out[0] = abs(ptr_in[0]-ptr_comp[0]) * scale;
   			ptr_out[1] = abs(ptr_in[1]-ptr_comp[1]) * scale;
   			ptr_out[2] = abs(ptr_in[2]-ptr_comp[2]) * scale;

   			ptr_in+=3;
   			ptr_comp+=3;
   			ptr_out+=3;
   		}
   	}
   	cv::imshow("Error Level Analysis",outImg);
	while(char(cv::waitKey(0))!='q');
}