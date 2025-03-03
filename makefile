#-------------------------------------------------------------------------------
# 1. CUDAHOME is the full path to the location where CUDA toolkit is installed,
#    for example CUDAHOME = /usr/local/cuda-12.1 when cuda 12.1 is installed.
# 2. libutil.a, libmrcfile.a are in LibSrc folder where the source code is
#    also provided in Util and Mrcfile. To recompile them, run "make clean"
#    followed by "make all" in Util first and then Mrcfile next.
#-------------------------------------------------------------------------------
CUDAHOME = $(HOME)/szheng/nvidia/cuda-12.1
PRJHOME = $(shell pwd)
CUDAINC = $(CUDAHOME)/include
CUDALIB = $(CUDAHOME)/lib64
PRJINC = $(PRJHOME)/LibSrc/Include
PRJLIB = $(PRJHOME)/LibSrc/Lib
#-------------------
CUSRCS = ./Util/GAddImages.cu \
	 ./Util/GFFT1D.cu \
	 ./Util/GFFT2D.cu \
	 ./Util/GFFTUtil2D.cu \
	 ./Util/GNormalize2D.cu \
	 ./Util/GRoundEdge.cu \
	 ./Util/GRoundEdge1D.cu \
	 ./Util/GThreshold2D.cu \
	 ./Util/GStretch.cu \
	 ./Util/GXcf2D.cu \
	 ./Util/GRotate2D.cu \
	 ./Util/GShiftRotate2D.cu \
	 ./Util/GRemoveSpikes2D.cu \
	 ./Util/GBinImage2D.cu \
	 ./Util/GCC1D.cu \
	 ./Util/GCC2D.cu \
	 ./Util/GRealCC2D.cu \
	 ./Util/GCalcMoment2D.cu \
	 ./Util/GFindMinMax2D.cu \
	 ./Util/GFourierCrop2D.cu \
	 ./Util/GMutualMask2D.cu \
	 ./Util/GPositivity2D.cu \
	 ./Util/GCorrLinearInterp.cu \
	 ./FindCtf/GCalcCTF1D.cu \
	 ./FindCtf/GCalcCTF2D.cu \
	 ./FindCtf/GCalcSpectrum.cu \
	 ./FindCtf/GCC1D.cu \
	 ./FindCtf/GCC2D.cu \
	 ./FindCtf/GRadialAvg.cu \
	 ./FindCtf/GRemoveMean.cu \
	 ./FindCtf/GRmBackground2D.cu \
	 ./FindCtf/GRoundEdge.cu \
	 ./FindCtf/GLowpass2D.cu \
	 ./CommonLine/GFunctions.cu \
	 ./CommonLine/GCalcCommonRegion.cu \
	 ./CommonLine/GGenCommonLine.cu \
	 ./CommonLine/GRemoveMean.cu \
	 ./CommonLine/GInterpolateLineSet.cu \
	 ./ProjAlign/GReproj.cu \
	 ./ProjAlign/GProjXcf.cu \
	 ./DoseWeight/GDoseWeightImage.cu \
	 ./Recon/GRWeight.cu \
	 ./Recon/GBackProj.cu \
	 ./Recon/GForProj.cu \
	 ./Recon/GDiffProj.cu \
	 ./Recon/GWeightProjs.cu \
	 ./Massnorm/GFlipInt2D.cu \
	 ./Massnorm/GPositivity.cu \
	 ./Correct/GCorrPatchShift.cu \
	 ./PatchAlign/GAddImages.cu \
	 ./PatchAlign/GRandom2D.cu \
	 ./PatchAlign/GExtractPatch.cu \
	 ./PatchAlign/GCommonArea.cu \
	 ./PatchAlign/GGenXcfImage.cu \
	 ./PatchAlign/GPartialCopy.cu \
	 ./PatchAlign/GNormByStd2D.cu
CUCPPS = $(patsubst %.cu, %.cpp, $(CUSRCS))
#------------------------------------------
SRCS = ./Util/CNextItem.cpp \
	./Util/CSplitItems.cpp \
	./Util/CSimpleFuncs.cpp \
	./Util/CParseArgs.cpp \
	./Util/CFileName.cpp \
	./Util/CRemoveSpikes1D.cpp \
	./Util/CPad2D.cpp \
	./Util/CPeak2D.cpp \
	./Util/CTRDecompose2D.cpp \
	./Util/CSaveTempMrc.cpp \
	./Util/CStrLinkedList.cpp \
	./Util/CReadDataFile.cpp \
	./MrcUtil/CTomoStack.cpp \
	./MrcUtil/CAlignParam.cpp \
	./MrcUtil/CLocalAlignParam.cpp \
	./MrcUtil/CPatchShifts.cpp \
	./MrcUtil/CSaveAlnFile.cpp \
	./MrcUtil/CLoadAlnFile.cpp \
	./MrcUtil/CLoadAngFile.cpp \
	./MrcUtil/CRemoveDarkFrames.cpp \
	./MrcUtil/CCalcStackStats.cpp \
	./MrcUtil/CDarkFrames.cpp \
	./MrcUtil/CLoadStack.cpp \
	./MrcUtil/CLoadMain.cpp \
	./MrcUtil/CSaveStack.cpp \
	./MrcUtil/CGenCentralSlices.cpp \
	./MrcUtil/CCropVolume.cpp \
	./ImodUtil/CSaveXF.cpp \
	./ImodUtil/CSaveTilts.cpp \
	./ImodUtil/CSaveCsv.cpp \
	./ImodUtil/CSaveXtilts.cpp \
	./ImodUtil/CImodUtil.cpp \
	./FindCtf/CCtfResults.cpp \
	./FindCtf/CCtfTheory.cpp \
	./FindCtf/CFindCtf1D.cpp \
	./FindCtf/CFindCtf2D.cpp \
	./FindCtf/CFindCtfBase.cpp \
	./FindCtf/CFindCtfHelp.cpp \
	./FindCtf/CFindDefocus1D.cpp \
	./FindCtf/CFindDefocus2D.cpp \
	./FindCtf/CGenAvgSpectrum.cpp \
	./FindCtf/CSpectrumImage.cpp \
	./FindCtf/CSaveCtfResults.cpp \
	./FindCtf/CFindCtfMain.cpp \
	./ProjAlign/CCentralXcf.cpp \
	./ProjAlign/CParam.cpp \
	./ProjAlign/CRemoveSpikes.cpp \
	./ProjAlign/CCalcReproj.cpp \
	./ProjAlign/CProjAlignMain.cpp \
	./StreAlign/CStretchXcf.cpp \
	./StreAlign/CStretchCC2D.cpp \
	./StreAlign/CStretchAlign.cpp \
	./StreAlign/CStreAlignMain.cpp \
	./CommonLine/CCommonLineMain.cpp \
	./CommonLine/CFindTiltAxis.cpp \
	./CommonLine/CRefineTiltAxis.cpp \
	./CommonLine/CGenLines.cpp \
	./CommonLine/CCalcScore.cpp \
	./CommonLine/CPossibleLines.cpp \
	./CommonLine/CLineSet.cpp \
	./CommonLine/CSumLines.cpp \
	./CommonLine/CCommonLineParam.cpp \
	./Massnorm/CLinearNorm.cpp \
	./Massnorm/CPositivity.cpp \
	./Massnorm/CFlipInt3D.cpp \
	./Correct/CCorrectUtil.cpp \
	./Correct/CBinStack.cpp \
	./Correct/CCorrProj.cpp \
	./Correct/CCorrTomoStack.cpp \
	./Correct/CFourierCropImage.cpp \
	./Correct/CCorrLinearInterp.cpp \
	./DoseWeight/CWeightTomoStack.cpp \
	./Recon/CTomoWbp.cpp \
	./Recon/CTomoSart.cpp \
	./Recon/CDoBaseRecon.cpp \
	./Recon/CDoSartRecon.cpp \
	./Recon/CDoWbpRecon.cpp \
	./TiltOffset/CTiltOffsetMain.cpp \
	./PatchAlign/CFitPatchShifts.cpp \
	./PatchAlign/CExtTomoStack.cpp \
	./PatchAlign/CLocalAlign.cpp \
	./PatchAlign/CDetectFeatures.cpp \
	./PatchAlign/CRoiTargets.cpp \
	./PatchAlign/CPatchTargets.cpp \
	./PatchAlign/CPatchAlignMain.cpp \
	./CInput.cpp \
	./CFFTBuffer.cpp \
	./CProcessThread.cpp \
	./CAreTomoMain.cpp \
	$(CUCPPS)
OBJS = $(patsubst %.cpp, %.o, $(SRCS))
#-------------------------------------
CC = g++ -std=c++11
CFLAG = -c -g -pthread -m64
NVCC = $(CUDAHOME)/bin/nvcc -std=c++11
CUFLAG = -Xptxas -dlcm=ca -O2 \
	-gencode arch=compute_75,code=sm_75 \
	-gencode arch=compute_70,code=sm_70 \
	-gencode arch=compute_61,code=sm_61 \
	-gencode arch=compute_60,code=sm_60 \
	-gencode arch=compute_53,code=sm_53 \
	-gencode arch=compute_52,code=sm_52 
#------------------------------------------
cuda: $(CUCPPS)

compile: $(OBJS)

exe: $(OBJS)
	@g++ -g -pthread -m64 $(OBJS) \
	$(PRJLIB)/libmrcfile.a \
	$(PRJLIB)/libutil.a \
	-L$(CUDALIB) -L/usr/lib64 \
	-lcufft -lcudart -lcuda -lc -lm -lpthread \
	-no-pie \
	-o AreTomo2
	@echo AreTomo2 has been generated.

%.o: %.cu
	@$(NVCC) -c $(CUFLAG) -I$(PRJINC) -I$(CUDAINC) $< -o $@
	@echo $< has been compiled.

%.o: %.cpp
	@$(CC) $(CFLAG) -I$(PRJINC) -I$(CUDAINC) \
		$< -o $@
	@echo $< has been compiled.

clean:
	@rm -f $(OBJS) $(CUCPPS) *.h~ makefile~ AreTomo2
	
