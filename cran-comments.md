## Test environments
* local Windows 7 enterprise install, R 3.3.3
* rhub - Debian Linux, R-devel, GCC (debian-gcc-devl)
* rhub - macOS 10.11 El Capital, R-release (experimental) (macos-elcapitan-release)
* rhub - Ubuntu Linux 16.04 LTS, R-devel, GCC (ubuntu-gcc-devel)
* rhub - Windows Server 2008 R2 SP1, R-devel, 32/64 bit (windows-x86_64-devel)

## R CMD check results

Windows (local machine):
R CMD check results (Status: OK)

*	0 errors 0 warnings 0 notes

rhub 4 runs: (initial runs)

*	0 errors 0 warnings 1 note  
*	Note: 
**checking dependencies in R code. Namespaces in Imports field not imported from:
     jsonlite RApiDatetime zoo.
     All declared Imports should be used.**

My remark: I assume these are build time dependencies because I always
used the "::" notation. To fix, I suppressed the note by using namespace imports of the packages.

After suppression (submission):

*	0 errors 0 warnings 0 notes
