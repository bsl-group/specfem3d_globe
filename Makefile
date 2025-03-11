#=====================================================================
#
#                       S p e c f e m 3 D  G l o b e
#                       ----------------------------
#
#     Main historical authors: Dimitri Komatitsch and Jeroen Tromp
#                        Princeton University, USA
#                and CNRS / University of Marseille, France
#                 (there are currently many more authors!)
# (c) Princeton University and CNRS / University of Marseille, April 2014
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License along
# with this program; if not, write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
#
#=====================================================================
#
# Makefile.  Generated from Makefile.in by configure.
#######################################

FC = ifort
FCFLAGS = -g
FC_DEFINE = -D
MPIFC = /apps/anvil/external/apps/intel/cluster.2019.5/compilers_and_libraries_2019.5.281/linux/mpi/intel64/bin/mpiifort
MPILIBS = 

FLAGS_CHECK = -xHost -fpe0 -ftz -assume buffered_io -assume byterecl -align sequence -std08 -diag-disable 6477 -implicitnone -gen-interfaces -warn all -O3 -check nobounds

FCFLAGS_f90 = -I${SETUP} -module ./obj -I./obj -I.  -I.

FC_MODEXT = mod
FC_MODDIR = ./obj

FCCOMPILE_CHECK = ${FC} ${FCFLAGS} $(FLAGS_CHECK)

MPIFCCOMPILE_CHECK = ${MPIFC} ${FCFLAGS} $(FLAGS_CHECK)

CC = icc
CFLAGS = -g -O2
CPPFLAGS = -I${SETUP} 

CXX = mpiicpc
CXXFLAGS = -I${SETUP} -g -O2

FCLINK = $(MPIFCCOMPILE_CHECK)

# all linker flags
LDFLAGS = 
MPILIBS += $(LDFLAGS) 

#######################################
####
#### MPI
####
#######################################

## MPI directories for CUDA / OpenCL
MPI_INCLUDES = 

MPI_CPPFLAGS = $(FC_DEFINE)WITH_MPI

#######################################
####
#### GPU
#### with configure: ./configure --with-cuda=cuda5 CUDA_FLAGS=.. CUDA_LIB=.. CUDA_INC=.. MPI_INC=.. ..
#### with configure: ./configure --with-opencl OCL_GPU_FLAGS=.. OCL_LIB=.. OCL_INC=.. MPI_INC=.. ..
#### with configure: ./configure --with-hip HIP_FLAGS=.. HIP_LIB=.. HIP_INC=.. MPI_INC=.. ..
####
#######################################

# Reduce GPU-register pressure by limited the number of thread spread
# (GPU for embedded devices are not powerful enough for big kernels)
# Must match mesh_constants_gpu.h::GPU_ELEM_PER_THREAD
GPU_ELEM_PER_THREAD := 1

##
## CUDA
##
#CUDA = yes
CUDA = no

#CUDA4 = yes
CUDA4 = no

#CUDA5 = yes
CUDA5 = no

#CUDA6 = yes
CUDA6 = no

#CUDA7 = yes
CUDA7 = no

#CUDA8 = yes
CUDA8 = no

#CUDA9 = yes
CUDA9 = no

#CUDA10 = yes
CUDA10 = no

#CUDA11 = yes
CUDA11 = no

#CUDA12 = yes
CUDA12 = no

# CUDA compilation with linking
#CUDA_PLUS = yes
CUDA_PLUS = no

# CUDA-aware MPI flag
#CUDA_MPI_FLAG = $(FC_DEFINE)WITH_CUDA_AWARE_MPI
CUDA_MPI_FLAG =

#FCFLAGS += $(CUDA_MPI_FLAG)

# default cuda libraries
# runtime library -lcudart needed, others are optional -lcuda -lcublas

CUDA_FLAGS = 
CUDA_INC = 
CUDA_LINK =   -lstdc++
CUDA_DEBUG = --cudart=shared

#NVCC = nvcc
NVCC = icc

##
## GPU architecture
##
# CUDA architecture / code version
# Fermi   (not supported): -gencode=arch=compute_10,code=sm_10
# Tesla   (Tesla C2050, GeForce GTX 480): -gencode=arch=compute_20,code=sm_20
# Tesla   (cuda4, K10, Geforce GTX 650, GT 650m): -gencode=arch=compute_30,code=sm_30
# Kepler  (cuda5, K20) : -gencode=arch=compute_35,code=sm_35
# Kepler  (cuda6.5, K80): -gencode=arch=compute_37,code=sm_37
# Maxwell (cuda6.5+/cuda7, Quadro K2200): -gencode=arch=compute_50,code=sm_50
# Pascal  (cuda8,P100, GeForce GTX 1080, Titan): -gencode=arch=compute_60,code=sm_60
# Volta   (cuda9, V100): -gencode=arch=compute_70,code=sm_70
# Turing  (cuda10, T4, GeForce RTX 2080): -gencode=arch=compute_75,code=sm_75
# Ampere  (cuda11, A100, GeForce RTX 3080): -gencode=arch=compute_80,code=sm_80
# Hopper  (cuda12, H100): -gencode=arch=compute_90,code=sm_90
GENCODE_20 = -gencode=arch=compute_20,code=\"sm_20,compute_20\"
GENCODE_30 = -gencode=arch=compute_30,code=\"sm_30,compute_30\"
GENCODE_35 = -gencode=arch=compute_35,code=\"sm_35,compute_35\"
GENCODE_37 = -gencode=arch=compute_37,code=\"sm_37\"
GENCODE_50 = -gencode=arch=compute_50,code=\"sm_50,compute_50\"
GENCODE_52 = -gencode=arch=compute_52,code=\"sm_52,compute_52\"
GENCODE_60 = -gencode=arch=compute_60,code=\"sm_60,compute_60\"
GENCODE_70 = -gencode=arch=compute_70,code=\"sm_70,compute_70\"
GENCODE_75 = -gencode=arch=compute_75,code=\"sm_75,compute_75\"
GENCODE_80 = -gencode=arch=compute_80,code=\"sm_80,compute_80\"
GENCODE_90 = -gencode=arch=compute_90,code=\"sm_90,compute_90\"

# cuda preprocessor flag
# CUDA version 12.0
##GENCODE = $(GENCODE_90) $(FC_DEFINE)GPU_DEVICE_Hopper
# CUDA version 11.0
##GENCODE = $(GENCODE_80) $(FC_DEFINE)GPU_DEVICE_Ampere
# CUDA version 10.0
##GENCODE = $(GENCODE_75) $(FC_DEFINE)GPU_DEVICE_Turing
# CUDA version 9.0
##GENCODE = $(GENCODE_70) $(FC_DEFINE)GPU_DEVICE_Volta
# CUDA version 8.0
##GENCODE = $(GENCODE_60) $(FC_DEFINE)GPU_DEVICE_Pascal
# CUDA version 7.x
##GENCODE = $(GENCODE_52) $(FC_DEFINE)GPU_DEVICE_Maxwell
# CUDA version 6.5
##GENCODE = $(GENCODE_37) $(FC_DEFINE)GPU_DEVICE_K80
# CUDA version 5.x
##GENCODE = $(GENCODE_35) $(FC_DEFINE)GPU_DEVICE_K20
# CUDA version 4.x
##GENCODE = $(GENCODE_30)
## old CUDA toolkit versions < 5
#GENCODE = $(GENCODE_20)

# CUDA flags and linking
#NVCC_FLAGS_BASE = $(CUDA_FLAGS) $(CUDA_INC) $(CUDA_DEBUG) $(CUDA_MPI_FLAG) $(MPI_CPPFLAGS) $(MPI_INCLUDES)
##NVCC_FLAGS = $(NVCC_FLAGS_BASE) -dc $(GENCODE)
#NVCC_FLAGS = $(NVCC_FLAGS_BASE) -DUSE_OLDER_CUDA4_GPU $(GENCODE)

#NVCCLINK_BASE = $(NVCC) $(CUDA_INC) $(MPI_INCLUDES)
##NVCCLINK = $(NVCCLINK_BASE) -dlink $(GENCODE)
#NVCCLINK = $(NVCCLINK_BASE) -DUSE_OLDER_CUDA4_GPU $(GENCODE)

NVCC_FLAGS =
NVCCLINK = $(NVCC) $(NVCC_FLAGS)

##
## OpenCL
##
#OCL = yes
OCL = no

OCL_CPU_FLAGS =  $(CUDA_MPI_FLAG) $(MPI_CPPFLAGS) $(MPI_INCLUDES)
OCL_GPU_FLAGS = 

OCL_INC = 
OCL_LINK =  

##
## HIP
##
#HIP = yes
HIP = no

# GPU architecture / code version
# see: https://llvm.org/docs/AMDGPUUsage.html
# Radeon Instinct MI8:   --amdgpu-target=gfx803
# Radeon Instinct MI25:	 --amdgpu-target=gfx900
# Radeon Instinct MI50:  --amdgpu-target=gfx906
# Radeon Instinct MI100: --amdgpu-target=gfx908
# Radeon Instinct MI210/250/250X: --amdgpu-target=gfx90a
GENCODE_AMD_MI8 = --amdgpu-target=gfx803
GENCODE_AMD_MI25 = --amdgpu-target=gfx900
GENCODE_AMD_MI50 = --amdgpu-target=gfx906
GENCODE_AMD_MI100 = --amdgpu-target=gfx908
GENCODE_AMD_MI250 = --amdgpu-target=gfx90a

# default targets
# AMD default MI50 & MI100
##GENCODE_HIP = $(GENCODE_AMD_MI50) $(GENCODE_AMD_MI100)
##HIP_CFLAG_ENDING = -x hip      # HIP compilation of src/gpu/*.c files
# NVIDIA default Tesla
##GENCODE_HIP = $(GENCODE_30)
##HIP_CFLAG_ENDING = -x cu    # CUDA compilation or src/gpu/*.c files

# specific targets
##GENCODE_HIP = $(GENCODE_AMD_MI8) $(FC_DEFINE)GPU_DEVICE_MI8         # --with-hip=MI8 ..
##GENCODE_HIP = $(GENCODE_AMD_MI25) $(FC_DEFINE)GPU_DEVICE_MI25      # --with-hip=MI25 ..
##GENCODE_HIP = $(GENCODE_AMD_MI50) $(FC_DEFINE)GPU_DEVICE_MI50      # --with-hip=MI50 ..
##GENCODE_HIP = $(GENCODE_AMD_MI100) $(FC_DEFINE)GPU_DEVICE_MI100   # --with-hip=MI100 ..
##GENCODE_HIP = $(GENCODE_AMD_MI250) $(FC_DEFINE)GPU_DEVICE_MI250   # --with-hip=MI250 ..

##GENCODE_HIP = $(GENCODE_35)         # --with-hip=cuda5 ..
##GENCODE_HIP = $(GENCODE_37)         # --with-hip=cuda6 ..
##GENCODE_HIP = $(GENCODE_52)         # --with-hip=cuda7 ..
##GENCODE_HIP = $(GENCODE_60)         # --with-hip=cuda8 ..
##GENCODE_HIP = $(GENCODE_70)         # --with-hip=cuda9 ..
##GENCODE_HIP = $(GENCODE_75)         # --with-hip=cuda10 ..
##GENCODE_HIP = $(GENCODE_80)         # --with-hip=cuda11 ..
##GENCODE_HIP = $(GENCODE_90)         # --with-hip=cuda12 ..

HIP_FLAGS = 
HIP_INC =  $(CUDA_MPI_FLAG) $(MPI_CPPFLAGS) $(MPI_INCLUDES)

#HIPCC = 
HIPCC = icc

#HIP_CFLAGS = $(HIP_FLAGS) $(HIP_INC) $(GENCODE_HIP)
#HIP_LINK = 

HIP_CFLAGS =
HIP_LINK =

## linking with hipcc instead of mpif90
## openMPI
#MPI_LIB_PATH = -L$(shell ${MPIFC} --showme:libdirs)
#MPI_LIBS += $(shell ${MPIFC} --showme:libs)
#MPI_LIBS += $(shell mpicxx --showme:libs)
#SET_MPI_LIB = ${MPI_LIB_PATH} $(shell echo ${MPI_LIBS} | sed -e 's/\b\([a-z]\+\)[ ,\n]\1/\1/g'|sed 's/[^ ]* */-l&/g')
#FCLINK = $(HIPCC) $(SET_MPI_LIB)
## mpich
# from: mpif90 -link_info
#FCLINK = $(HIPCC) -L/usr/lib/x86_64-linux-gnu -lmpichfort -lmpich -lgfortran -lm -shared-libgcc


# GPU flags
# allows for compilation of CUDA and OpenCL kernels together
ifeq ($(OCL), yes)
  ifeq ($(CUDA), yes)
    GPU_CUDA_AND_OCL = yes
  endif
endif

# checks if any GPU flag set
ifeq ($(OCL), no)
  ifeq ($(CUDA), no)
		ifeq ($(HIP), no)
			NO_GPU = yes
		endif
  endif
endif
ifneq ($(NO_GPU), yes)
  HAS_GPU = yes  # not used any further, but could to allow only specific subdirs included
endif

#######################################
####
#### MIC
#### with configure: ./configure --with-mic
####
#######################################

# native compilation
#MIC = yes
MIC = no

#MIC_FLAGS = -mmic #-qopt-report2 -qopt-report-phase=vec

#FCFLAGS += $(MIC_FLAGS)
#CPPFLAGS += $(MIC_FLAGS)

#######################################
####
#### LIBXSMM
#### with configure: ./configure --with-xsmm LIBXSMM_INC=/opt/libxsmm/include \
####                                         LIBXSMM_LIBS=/opt/libxsmm/lib \
####                                         BLAS_LIBS=/opt/local/lib/lapack
####
#######################################

#XSMM = yes
XSMM = no

#FCFLAGS += $(FC_DEFINE)USE_XSMM -I
#MPILIBS += -L -lxsmmf -lxsmm -lxsmmext -L -lblas

##
## C++ Parallel STL support
## for sorting and creating ibool addressing
## with configure: ./configure --with-parallel-stl PSTL_LIB="-L/opt/local/lib" \
##                                                 CXXFLAGS="-O2 -std=c++17 -I/opt/local/include"
##
#PARALLEL_STL = yes
PARALLEL_STL = no

#PARALLEL_STL_DEF = $(FC_DEFINE)USE_PARALLEL_STL_SORTING
PARALLEL_STL_DEF =

#PARALLEL_STL_LIBS +=  -lstdc++ -ltbb
PARALLEL_STL_LIBS +=


#FCFLAGS += $(PARALLEL_STL_DEF)
#MPILIBS += $(PARALLEL_STL_LIBS)

#######################################
####
#### OpenMP
#### with configure: ./configure --enable-openmp OMP_FCFLAGS=".." OMP_LIB=..
####
#######################################

#OPENMP = yes
OPENMP = no

#FCFLAGS += $(FC_DEFINE)USE_OPENMP -qopenmp  #$(FC_DEFINE)USE_OPENMP_ATOMIC_INSTEAD_OF_CRITICAL

#OMP_LIBS = $(OMP_LIB)
OMP_LIBS =

#######################################
####
#### VTK
#### with configure: ./configure --enable-vtk ..
####
#######################################

#VTK = yes
VTK = no

#CPPFLAGS += 
#LDFLAGS += 
#MPILIBS += 

#######################################
####
#### ADIOS
#### with configure: ./configure --with-adios ADIOS_CONFIG=..
####
#######################################

#ADIOS = yes
ADIOS = no

#ADIOS_DEF = $(FC_DEFINE)USE_ADIOS
ADIOS_DEF =

#FCFLAGS +=  $(ADIOS_DEF)
#MPILIBS += 

#######################################
####
#### ADIOS2
#### with configure: ./configure --with-adios2 ADIOS2_CONFIG=..
####
#######################################

#ADIOS2 = yes
ADIOS2 = no

#ADIOS2_DEF = $(FC_DEFINE)USE_ADIOS2
ADIOS2_DEF =

#FCFLAGS +=  $(ADIOS2_DEF)
#MPILIBS += 

#CPPFLAGS += 
#MPILIBS += 

#MPICC = /apps/anvil/external/apps/intel/cluster.2019.5/compilers_and_libraries_2019.5.281/linux/mpi/intel64/bin/mpiicc
MPICC = $(CC)

#######################################
####
#### ASDF
#### with configure: ./configure --with-asdf ASDF_LIBS=..
####
#######################################

#ASDF = yes
ASDF = no

#FCFLAGS += @ASDF_FCFLAGS@
#MPILIBS +=  -lasdf -lhdf5hl_fortran -lhdf5_hl -lhdf5 -lstdc++

#######################################
####
#### FORCE_VECTORIZATION
#### with configure: ./configure --with-vec ..
####
#######################################

#FORCE_VECTORIZATION = yes
FORCE_VECTORIZATION = no

#######################################
####
#### NetCDF
#### with configure: ./configure --with-netcdf NETCDF_LIBS=.. NETCDF_FCFLAGS=.. NETCDF_INC=..
####
#######################################

#NETCDF = yes
NETCDF = no

# adds compiler flag
#FCFLAGS +=  
#MPILIBS += 

#######################################
####
#### CEM
#### with configure: ./configure --with-cem CEM_LIBS=.. CEM_FCFLAGS=..
####
#######################################
# (requires Netcdf support)

#CEM = yes
CEM = no

# adds compiler flag
#FCFLAGS += ${FC_DEFINE}USE_CEM 
#MPILIBS += 

#######################################
####
#### IRIS EMC models
#### with configure: ./configure --with-emc EMC_LIBS=.. EMC_FCFLAGS=..
####
#######################################
# (requires Netcdf support)

#EMC = yes
EMC = no

# adds compiler flag
#FCFLAGS += ${FC_DEFINE}USE_EMC 
#MPILIBS += 

#######################################
####
#### PETSc
#### with configure: ./configure --with-petsc PETSC_FCFLAGS=.. PETSC_INC=.. PETSC_LIB=..
####
#######################################

#PETSC = yes
PETSC = no

# adds compiler flag
#FCFLAGS +=  $(FC_DEFINE)USE_PETSC
#LDFLAGS += 
#MPILIBS += 

#######################################
####
#### HDF5 (parallel)
#### with configure: ./configure --with-hdf5 HDF5_LIBS=.. HDF5_FCFLAGS=.. HDF5_INC=..
####
#######################################

#HDF5 = yes
HDF5 = no

# adds compiler flag
#FCFLAGS +=   $(FC_DEFINE)USE_HDF5
#LDFLAGS +=  -lhdf5_fortran -lhdf5hl_fortran    # -lhdf5_hl -lhdf5 -lstdc++

#######################################
## static compilation
#######################################
# requires OUTPUT_FILES/values_from_mesher.h for compilation of the solver
# needs to recompile executables for different simulation setups
# turned off by default

#STATIC_COMPILATION = yes
STATIC_COMPILATION = no

ifeq ($(STATIC_COMPILATION), yes)
  FCFLAGS += ${FC_DEFINE}USE_STATIC_COMPILATION
endif

#######################################
####
#### directories
####
#######################################

## compilation directories
# B : build directory
B = .
# E : executables directory
E = $B/bin
# O : objects directory
O = $B/obj
# S_TOP : source file root directory
S_TOP = .
# L : libraries directory
L = $B/lib
# setup file directory
SETUP = $B/setup
# output file directory
OUTPUT = $B/OUTPUT_FILES


#######################################
####
#### targets
####
#######################################

# code subdirectories
SUBDIRS = \
	auxiliaries \
	create_header_file \
	gpu \
	meshfem3D \
	shared \
	specfem3D \
	tomography \
	tomography/postprocess_sensitivity_kernels \
	$(EMPTY_MACRO)

# full gravity tool
SUBDIRS += gindex3D

#ifeq ($(HAS_GPU),yes)
#  SUBDIRS := gpu $(SUBDIRS)
#endif

# default targets
DEFAULT = \
	xcreate_header_file \
	xmeshfem3D \
	xspecfem3D \
	xcombine_AVS_DX \
	xcombine_surf_data \
	xcombine_surf_data_vtk \
	xcombine_surf_data_vtu \
	xcombine_vol_data \
	xcombine_vol_data_vtk \
	xcombine_vol_data_vtu \
	xconvolve_source_timefunction \
	xcreate_movie_AVS_DX \
	xcreate_movie_GMT_global \
	xwrite_profile \
	$(EMPTY_MACRO)

ifeq ($(ADIOS), yes)
DEFAULT += 	\
	xcombine_vol_data_adios \
	xcombine_vol_data_vtk_adios \
	xcombine_vol_data_vtu_adios \
	$(EMPTY_MACRO)
endif

#ifeq ($(ADIOS2), yes)
#DEFAULT += 	\
#	xcombine_vol_data_adios2 \
#	xcombine_vol_data_vtk_adios2 \
#	$(EMPTY_MACRO)
#endif

# full gravity tool
DEFAULT += 	xgindex3D


all: default aux movies postprocess tomography

default: $(DEFAULT)

ifdef CLEAN
clean:
	@echo "cleaning by CLEAN"
	-rm -f $(foreach dir, $(CLEAN), $($(dir)_OBJECTS) $($(dir)_MODULES) $($(dir)_SHARED_OBJECTS) $($(dir)_TARGETS))
	-rm -f ${E}/*__genmod.*
	-rm -f ${O}/*__genmod.*
	-rm -f ${O}/*.smod
	-rm -f ${O}/*.lst
else
clean:
	@echo "cleaning all"
	-rm -f $(foreach dir, $(SUBDIRS), $($(dir)_OBJECTS) $($(dir)_MODULES) $($(dir)_TARGETS))
	-rm -f ${E}/*__genmod.*
	-rm -f ${O}/*__genmod.*
	-rm -f ${O}/*.smod
	-rm -f ${O}/*.lst
endif

realclean: clean
	-rm -rf $E/* $O/*

# unit testing
# If the first argument is "test"...
ifeq (test,$(findstring test,firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  TEST_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # turn them into do-nothing targets
  $(eval $(TEST_ARGS):;@:)
endif

tests:
	@echo "testing in directory: ${S_TOP}/tests/"
	cd ${S_TOP}/tests; ./run_all_tests.sh $(TEST_ARGS)
	@echo ""

help:
	@echo "usage: make [executable]"
	@echo ""
	@echo "supported main executables:"
	@echo "    xmeshfem3D"
	@echo "    xspecfem3D"
	@echo ""
	@echo "defaults:"
	@echo "    xcreate_header_file"
	@echo "    xmeshfem3D"
	@echo "    xspecfem3D"
	@echo "    xcombine_AVS_DX"
	@echo "    xcombine_surf_data"
	@echo "    xcombine_surf_data_vtk"
	@echo "    xcombine_vol_data"
	@echo "    xcombine_vol_data_vtk"
	@echo "    xconvolve_source_timefunction"
	@echo "    xcreate_movie_AVS_DX"
	@echo "    xcreate_movie_GMT_global"
	@echo "    xwrite_profile"
	@echo ""
	@echo "additional executables:"
	@echo "- auxiliary executables: [make aux]"
	@echo "    xcombine_vol_data"
	@echo "    xcombine_vol_data_vtk"
	@echo "    xcombine_vol_data_vtu"
ifeq ($(ADIOS), yes)
	@echo "    xcombine_vol_data_adios"
	@echo "    xcombine_vol_data_vtk_adios"
	@echo "    xcombine_vol_data_vtu_adios"
endif
ifeq ($(ADIOS2), yes)
	@echo "    xcombine_vol_data_adios2"
	@echo "    xcombine_vol_data_vtk_adios2"
	@echo "    xcombine_vol_data_vtu_adios2"
endif
	@echo "    xcombine_surf_data"
	@echo "    xcombine_surf_data_vtk"
	@echo "    xcombine_surf_data_vtu"
	@echo "    xcombine_AVS_DX"
	@echo "    xconvolve_source_timefunction"
	@echo "    xwrite_profile"
	@echo ""
	@echo "- movie executables: [make movies]"
	@echo "    xcreate_movie_AVS_DX"
	@echo "    xcreate_movie_GMT_global"
	@echo "    xcombine_paraview_strain_data"
	@echo ""
	@echo "- sensitivity kernel postprocessing tools: [make postprocess]"
	@echo "    xaddition_sem"
	@echo "    xclip_sem"
	@echo "    xcombine_sem"
	@echo "    xcreate_cross_section"
	@echo "    xdifference_sem"
	@echo "    xinterpolate_model"
	@echo "    xsmooth_sem"
	@echo "    xsmooth_laplacian_sem"
ifeq ($(ADIOS), yes)
	@echo "    xconvert_model_file_adios"
endif
ifeq ($(ADIOS2), yes)
	@echo "    xconvert_model_file_adios2"
endif
	@echo ""
	@echo "- tomography tools: [make tomography]"
	@echo "    xadd_model_iso"
	@echo "    xadd_model_tiso"
	@echo "    xadd_model_tiso_cg"
	@echo "    xadd_model_tiso_iso"
	@echo "    xsum_kernels"
	@echo "    xsum_preconditioned_kernels"
	@echo ""
	@echo "for unit testing:"
	@echo "    tests"
	@echo ""
	@echo "for full-gravity simulations:"
	@echo "    xgindex3D"
	@echo ""

.PHONY: all default clean realclean help tests

#######################################

# Get dependencies and rules for building stuff
include $(patsubst %, ${S_TOP}/src/%/rules.mk, $(SUBDIRS))

#######################################

##
## Shortcuts
##

# Shortcut for: <prog>/<xprog> -> bin/<xprog>
define target_shortcut
$(patsubst $E/%, %, $(1)): $(1)
.PHONY: $(patsubst $E/%, %, $(1))
$(patsubst $E/x%, %, $(1)): $(1)
.PHONY: $(patsubst $E/x%, %, $(1))
endef

# Shortcut for: dir -> src/dir/<targets in here>
define shortcut
$(1): $($(1)_TARGETS)
.PHONY: $(1)
$$(foreach target, $$(filter $E/%,$$($(1)_TARGETS)), $$(eval $$(call target_shortcut,$$(target))))
endef

$(foreach dir, $(SUBDIRS), $(eval $(call shortcut,$(dir))))

# testing
test : tests

# Other old shortcuts
mesh: $E/xmeshfem3D
spec: $E/xspecfem3D

.PHONY: mesh spec

