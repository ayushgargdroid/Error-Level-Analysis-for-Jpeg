cimport testOCV
import numpy as np
cimport numpy as np
from libcpp.string cimport string
from libc.string cimport memcpy

cdef matToNp(Mat m):
	cdef uint8_t* ptr_in
	for i in range(m.rows):
		ptr_in = m.ptr(i)
		row = np.uint8([[[ptr_in[0],ptr_in[1],ptr_in[2]]]])
		ptr_in += 3
		for j in range(1,m.cols):
			t = np.uint8([[[ptr_in[0],ptr_in[1],ptr_in[2]]]])
			row = np.append(row,t,axis=1)
			ptr_in += 3
		print row.shape
		if i is 0:
			image = np.uint8(row)
		else:
			image = np.append(image,row,axis=0)
	print image.shape

cdef Mat npToMat(np.ndarray ary):
    cdef np.ndarray[np.uint8_t, ndim=3, mode ='c'] np_buff = np.ascontiguousarray(ary, dtype=np.uint8)
    cdef unsigned int* im_buff = <unsigned int*> np_buff.data
    cdef int r = ary.shape[0]
    cdef int c = ary.shape[1]
    cdef Mat m
    m.create(r, c, CV_8UC3)
    memcpy(m.data, im_buff, r*c*3)
	return m

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
	writeMat("Result.jpg",outImg)
	matToNp(inImg)