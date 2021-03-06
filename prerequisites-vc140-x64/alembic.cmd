SET current=%cd%

if not exist "prereq" ^
mkdir prereq
cd prereq

if not exist "alembic/.git/config" ^
git clone git://github.com/alembic/alembic.git

cd alembic
git pull
cd ..

if not exist "build\alembic" ^
mkdir build\alembic
cd build\alembic

cmake  -G "Visual Studio 14 2015 Win64"^
    -DUSE_PYILMBASE=1 -DCMAKE_ARCHIVE_OUTPUT_DIRECTORY=alembic-stage -DCMAKE_INSTALL_PREFIX="%current%\local"^
	-DBOOST_INCLUDEDIR="%current%\local\include"^
	-DBOOST_LIBRARYDIR="%current%\local\lib"^
	-DBoost_INCLUDE_DIR="%current%\local\include"^
	-DBoost_LIBRARY_DIR="%current%\local\lib"^
    -DUSE_HDF5=OFF^
	-DHDF5_ROOT="%current%\local"^
	-DALEMBIC_PYILMBASE_PYIMATH_LIB="%current%\local\lib\libPyImath.lib"^
	-DILMBASE_ROOT="%current%\local"^
	-DALEMBIC_PYILMBASE_ROOT="%current%\local"^
	../../alembic

cmake --build . --target install --config Release -- /maxcpucount:8

cd %current%
