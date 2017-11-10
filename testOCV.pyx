cimport testOCV
from libcpp.string cimport string
from libc.string cimport memcpy

cdef Mat readMat(string s):
	cdef Mat m = imread(s,1)
	return m

cdef showMat(string s,Mat m):
	imshow(s,m)
	waitKey(0)

cdef writeMat(string s,Mat m):
	imwrite(s,m)

cdef Mat computeDiff(Mat m1,Mat m2):
	cdef Mat m3 = zeros(m1.rows,m1.cols,CV_8UC3)
	cdef uint8_t* ptr_in
	cdef uint8_t* ptr_out
	cdef uint8_t* ptr_comp
	for i in range(m1.rows):
		ptr_in = m1.ptr(i)
		ptr_out = m3.ptr(i)
		ptr_comp = m2.ptr(i)
		for j in range(0,m1.cols):
			ptr_out[0] = abs(ptr_in[0]-ptr_comp[0]) * 10
			ptr_out[1] = abs(ptr_in[1]-ptr_comp[1]) * 10
			ptr_out[2] = abs(ptr_in[2]-ptr_comp[2]) * 10
			ptr_comp +=3 
			ptr_in += 3
			ptr_out += 3

	return m3

def process(string s):
	cdef Mat inImg,outImg,compImg
	inImg = readMat(s)
	writeMat("temp.jpg",inImg)
	showMat("Image",inImg)
	compImg = readMat("temp.jpg")
	outImg = computeDiff(inImg,compImg)
	showMat("Error Level Analysis",outImg)