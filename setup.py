from distutils.core import setup
from distutils.extension import Extension
from Cython.Distutils import build_ext
from Cython.Build import cythonize
import subprocess

proc_libs = subprocess.check_output("pkg-config --libs opencv".split())
proc_incs = subprocess.check_output("pkg-config --cflags opencv".split())
libs = [lib for lib in str(proc_libs).split()]

setup(
  cmdclass = {'build_ext': build_ext},
  ext_modules = cythonize(Extension("testOCV",
    sources = ["testOCV.pyx"],
    language = "c++",
    include_dirs=["/usr/local/include/opencv2"],
    extra_link_args=libs
    )
  )
)