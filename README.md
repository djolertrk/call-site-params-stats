# LLVM call-site-params-stats
This is based on LLVM project and it checks the quality of the described (target-) instructions in terms of DWARF for call-site-params/entry-values feature.

The idea is to find instructions that are frequently used, but not described for the call-site-param value (DW_AT_GNU_call_site_value). This could be very useful for the users of some downstream targets as well.

On a very high level, the Debug Entry Values feature implementation ended up performing describing (in terms of DWARF ops) target instructions that load a value into registers that are used to transfer function parameters. Debuggers use that information to print @entry value within debuggers (and we allow debuggers to try to evaluate DW_OP_entry_value expressions within location lists). This improves debugging user experience when debugging optimized code.


## Usage
This is based on the LLVM Trunk (HEAD at 8b7b84e99d). Please take a look at https://llvm.org/docs/GettingStarted.html for details about the LLVM Project.

Merging this changes into the LLVM Codebase allows us to find the frequently used instructions that could be candidates for the call-site-param value description. The more call-site-params we describe, the better Debugging Experience we have!

Assuming the call-site-param was built (using the instructions from https://llvm.org/docs/CMake.html, we pikck binutils-gdb project as a test-bed. We will build the binutils for the X86_64 target.

Download the binutils from https://www.gnu.org/software/gdb/current/:

    $ git clone git://sourceware.org/git/binutils-gdb.git

Set up the experimental build:

    $ export CC=$path_to_the_project_build/bin/clang
    $ export CXX=$path_to_the_project_build/bin/clang++
    $ mkdir build && cd build
    $ ../binutils-gdb/configure CFLAGS="-g -O2" CXXFLAGS="-g -O2" --enable-werror=no && make
  
With the call-site-params-stats/get_summary.py we collect the data the compiler reported:

    $ ~/path_to_the_project/call-site-params-stats/get_summary.py
    =================================================================================
              		Describing DW_AT_call_site_value EFFICIENCY
    =================================================================================
    INSTRUCTION	(freq)  	   #MISS      	    #HIT     	  MISS PERCENTAGE
    ---------------------------------------------------------------------------------
    KILL                (0%)	     702	       0		  100%
    ADD32ri             (0%)	       1	       0		  100%
    ADD32ri8            (0%)	     165	       0		  100%
    ADD32rm             (0%)	       7	       1		   87%
    ADD32rr             (0%)	      48	       0		  100%
    ADD64ri32           (0%)	      42	       0		  100%
    ADD64ri8            (0%)	     950	       0		  100%
    ADD64rm             (0%)	     207	      57		   78%
    ADD64rr             (0%)	     546	       0		  100%
    AND32ri             (0%)	       6	       0		  100%
    AND32ri8            (0%)	     177	       0		  100%
    AND32rm             (0%)	       2	       0		  100%
    AND64ri8            (0%)	       5	       0		  100%
    AND64rr             (0%)	      11	       0		  100%
    BSWAP32r            (0%)	       1	       0		  100%
    CMOV32rm            (0%)	       0	       1		    0%
    CMOV32rr            (0%)	      75	       0		  100%
    CMOV64rm            (0%)	       0	       2		    0%
    CMOV64rr            (0%)	     544	       0		  100%
    CVTSS2SDrr          (0%)	       1	       0		  100%
    CVTTSD2SIrr         (0%)	       5	       0		  100%
    DIVSDrm             (0%)	       5	       0		  100%
    DIVSDrr             (0%)	       6	       0		  100%
    IDIV32m             (0%)	       1	       0		  100%
    IDIV32r             (0%)	       1	       0		  100%
    IMUL32rm            (0%)	       5	       1		   83%
    IMUL32rr            (0%)	       5	       0		  100%
    IMUL32rri           (0%)	       8	       0		  100%
    IMUL64rm            (0%)	       4	       4		   50%
    IMUL64rmi8          (0%)	       0	       1		    0%
    IMUL64rr            (0%)	      38	       0		  100%
    IMUL64rri32         (0%)	      19	       0		  100%
    IMUL64rri8          (0%)	      17	       0		  100%
    LEA64_32r           (0%)	       0	     639		    0%
    LEA64r              (5%)	     559	   11782		    4%
    MOV32ri             (30%)	       0	   64988		    0%
    MOV32rm             (1%)	    2771	     833		   76%
    MOV32rr             (3%)	       0	    6937		    0%
    MOV64ri             (0%)	       0	       6		    0%
    MOV64ri32           (0%)	       0	      50		    0%
    MOV64rm             (11%)	   19498	    5345		   78%
    MOV64rr             (36%)	       0	   76474		    0%
    MOV8rr              (0%)	       4	       0		  100%
    MOVSDrm_alt         (0%)	       4	       2		   66%
    MOVSX32rm16         (0%)	      31	       2		   93%
    MOVSX32rm8          (0%)	     120	       1		   99%
    MOVSX32rr16         (0%)	      20	       0		  100%
    MOVSX32rr8          (0%)	      64	       0		  100
    MOVSX64rm16         (0%)	      16	       0		  100%
    MOVSX64rm32         (0%)	     181	      20		   90%
    MOVSX64rm8          (0%)	       4	       0		  100%
    MOVSX64rr16         (0%)	       3	       0		  100%
    MOVSX64rr32         (0%)	       0	     408		    0%
    MOVSX64rr8          (0%)	       8	       0		  100%
    MOVZX32rm16         (0%)	     194	       5		   97%
    MOVZX32rm8          (0%)	     226	      14		   94%
    MOVZX32rr16         (0%)	      21	       0		  100%
    MOVZX32rr8          (0%)	     109	       0		  100%
    MOVZX32rr8_NOREX    (0%)	       3	       0		  100%
    NEG32r              (0%)	      10	       0		  100%
    NEG64r              (0%)	       7	       0		  100%
    NOT32r              (0%)	       1	       0		  100%
    NOT64r              (0%)	       1	       0		  100%
    OR32ri              (0%)	      16	       0		  100%
    OR32ri8             (0%)	      32	       0		  100%
    OR32rr              (0%)	      35	       0		  100%
    OR64ri8             (0%)	       4	       0		  100%
    OR64rm              (0%)	       4	       0		  100%
    OR64rr              (0%)	      16	       0		  100%
    SAR32r1             (0%)	       6	       0		  100%
    SAR32ri             (0%)	       8	       0		  100%
    SAR64rCL            (0%)	       1	       0		  100%
    SAR64ri             (0%)	      68	       0		  100%
    SBB32ri8            (0%)	       2	       0		  100%
    SETCCr              (0%)	     233	       0		  100%
    SHL32rCL            (0%)	      13	       0		  100%
    SHL32ri             (0%)	      30	       0		  100%
    SHL64ri             (0%)	     307	       0		  100%
    SHR32ri             (0%)	      20	       0		  100%
    SHR64r1             (0%)	      10	       0		  100%
    SHR64rCL            (0%)	       9	       0		  100%
    SHR64ri             (0%)	      34	       0		  100%
    SUB32rm             (0%)	      14	       1		   93%
    SUB32rr             (0%)	     124	       0		  100%
    SUB64ri8            (0%)	       2	       0		  100%
    SUB64rm             (0%)	      43	       9		   82%
    SUB64rr             (0%)	     168	       0		  100%
    XOR32ri8            (0%)	       5	       0		  100%
    XOR32rr             (6%)	       0	   13568		    0%
    XOR64ri8            (0%)	      43	       0		  100%
    ---------------------------------------------------------------------------------
    TOTAL MISS PERCENTAGE: 13%
    =================================================================================
 
 E.g. by looking at the report, the MOV64rm, ADD64rr, ADD64ri8 (and so on) are good candidates for the description.
