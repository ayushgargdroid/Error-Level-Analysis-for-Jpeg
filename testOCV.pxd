from libcpp.string cimport string
from libc.stdint cimport uint8_t

cdef extern from "opencv2/core/core.hpp":
	cdef int CV_WINDOW_AUTOSIZE
	cdef int CV_8UC3

cdef extern from "opencv2/core/core.hpp" namespace "cv":
	cdef cppclass Mat:
		Mat() except +
		void create(int,int,int)
		void* data
		int rows
		int cols
		uint8_t* ptr(int)
		int channels()

cdef extern from "opencv2/core/mat.hpp" namespace "cv::Mat":
	Mat zeros(int,int,int)

cdef extern from "opencv2/imgcodecs/imgcodecs.hpp" namespace "cv":
	Mat imread(const string,int)
	Mat imwrite(const string,Mat)

cdef extern from "opencv2/highgui/highgui.hpp" namespace "cv":
	void imshow(const string,Mat)
	int waitKey(int delay)


