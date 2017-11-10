cimport testOCV
from libcpp.string cimport string

cdef readMat(string s):
	cdef Mat inImg,compImg,outImg
	inImg = imread(s,1)
	cdef uint8_t* ptr_in
	cdef uint8_t* ptr_out
	cdef uint8_t* ptr_comp
	imshow("Image",inImg)
	imwrite("temp.jpg",inImg)
	compImg = imread("temp.jpg",1)
	outImg = zeros(inImg.rows,inImg.cols,CV_8UC3)
	for i in range(inImg.rows):
		ptr_in = inImg.ptr(i)
		ptr_out = outImg.ptr(i)
		ptr_comp = compImg.ptr(i)
		for j in range(0,inImg.cols):
			ptr_out[0] = abs(ptr_in[0]-ptr_comp[0]) * 10
			ptr_out[1] = abs(ptr_in[1]-ptr_comp[1]) * 10
			ptr_out[2] = abs(ptr_in[2]-ptr_comp[2]) * 10
			ptr_comp +=3 
			ptr_in += 3
			ptr_out += 3

	imshow("Error Level Analysis",outImg)
	waitKey(0)

def do(string s):
	readMat(s)