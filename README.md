# Symbolic PathFinder (SPF)
![build SPF](https://github.com/gaurangkudale/SPF/actions/workflows/main.yml/badge.svg)

This JPF extension provides symbolic execution for Java bytecode. It performs a non-standard interpretation of byte-codes. It allows symbolic execution on methods with arguments of basic types (int, long, double, boolean, etc.). It also supports symbolic strings, arrays, and user-defined data structures.

<br>

## IMPORTANT Disclaimer
<div style="border: 2px solid #ccc; padding: 10px; margin: 10px 0;">
  <h3>This branch is under active development to support Java 11 in SPF. It is experimental and may contain unstable features. Use it at your own risk.</h3>
</div>

## General Information about SPF
All the latest developments, changes, documentation can be found on our
[wiki](https://github.com/SymbolicPathFinder/jpf-symbc/wiki) page.

<br>

## Directory Structure of SPF
**The current directory structure is as follows.**

```{bash}
     SPF (Gradle Root Project)
        ---| jpf-core (Git-Submodule + Gradle Sub-Project)
        ---| jpf-symbc (Gradle Sub-Project)
```

As of August 2022, we migrated our build workflow to `Gradle`. While migrating the SPF to `Gradle`, we have introduced `Gradle Multi-Project build` and `GitHub Submodule` to SPF.

* **Gradle Multi-Project Build:** A multi-project build in Gradle consists of one root project, and one or more subprojects. In our case, `jpf-core` and `jpf-symbc` are two subprojects. More information can be found at the official documentation of [Gradle Multi-Project Build](https://docs.gradle.org/current/userguide/multi_project_builds.html).
 
* **Git-Submodule:** Git submodules allow you to keep a Git repository as a subdirectory of another Git repository. Git submodules are simply a reference to another repository at a particular snapshot in time. Git submodules enable a Git repository  to incorporate and track version history of external code. Git submodules are a powerful way to leverage Git as an external dependency management tool. More information can be found in its official documentation of [Git-Submodule](https://git-scm.com/docs/git-submodule).
 
<br>

## Quick Start Guide

SPF requires: **Java 11** and **Gradle 8.4**.

### 1. Get the latest SPF version
```{bash}
git clone --recurse-submodules git@github.com:SymbolicPathFinder/jpf-symbc.git SPF
```

If cloning from the `gradle-build` branch then specify that branch in the clone command
```{bash}
git clone -b gradle-build --recurse-submodules git@github.com:SymbolicPathFinder/jpf-symbc.git SPF
```

<details>
<summary>Console Output</summary>

```
yannic@Yannics-MacBook-Pro Desktop % git clone --recurse-submodules git@github.com:SymbolicPathFinder/jpf-symbc.git
Cloning into 'SPF'...
remote: Enumerating objects: 2438, done.
remote: Counting objects: 100% (611/611), done.
remote: Compressing objects: 100% (217/217), done.
remote: Total 2438 (delta 320), reused 585 (delta 306), pack-reused 1827
Receiving objects: 100% (2438/2438), 67.00 MiB | 2.89 MiB/s, done.
Resolving deltas: 100% (1257/1257), done.
Updating files: 100% (1042/1042), done.
Submodule 'jpf-core' (https://github.com/javapathfinder/jpf-core) registered for path 'jpf-core'
Cloning into '/Users/yannic/Desktop/SPF/jpf-core'...
remote: Enumerating objects: 3892, done.
remote: Counting objects: 100% (357/357), done.
remote: Compressing objects: 100% (208/208), done.
remote: Total 3892 (delta 114), reused 260 (delta 68), pack-reused 3535
Receiving objects: 100% (3892/3892), 2.27 MiB | 2.54 MiB/s, done.
Resolving deltas: 100% (1874/1874), done.
Submodule path 'jpf-core': checked out '45a4450cd0bd1193df5419f7c9d9b89807d00db6'
```
</details>

### 2. Build jpf-core
```{bash}
cd SPF
gradle :jpf-core:buildJars
```
If using a gradle version > 8.4, you can point gradle to the Java 11 home on your machine. You need to specify that for all gradle commands blow. For example:

```{bash}
gradle :jpf-core:buildJars -Dorg.gradle.java.home=/usr/lib/jvm/java-8-openjdk-amd64
```
<details>
<summary>Console Output</summary>

```{bash}
yannic@Yannics-MacBook-Pro SPF % gradle :jpf-core:buildJars
jpf-core
jpf-symbc

> Task :jpf-core:compileJava
Note: Some input files use unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.

> Task :jpf-core:compileTestJava
Note: Some input files use or override a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: Some input files use unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.

Deprecated Gradle features were used in this build, making it incompatible with Gradle 9.0.

You can use '--warning-mode all' to show the individual deprecation warnings and determine if they come from your own scripts or plugins.

For more on this, please refer to https://docs.gradle.org/8.4/userguide/command_line_interface.html#sec:command_line_warnings in the Gradle documentation.

BUILD SUCCESSFUL in 4s
16 actionable tasks: 16 executed
```
</details>

### 3. Build jpf-symbc
```{bash}
gradle :jpf-symbc:buildJars
```
<details>
<summary>Console Output</summary>

```
yannic@Yannics-MacBook-Pro SPF % gradle :jpf-symbc:buildJars
jpf-core
jpf-symbc

> Task :jpf-symbc:compileJava
Note: Some input files use or override a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: Some input files use unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.

> Task :jpf-symbc:compileExamplesJava
Note: Some input files use or override a deprecated API.
Note: Recompile with -Xlint:deprecation for details.
Note: Some input files use unchecked or unsafe operations.
Note: Recompile with -Xlint:unchecked for details.

> Task :jpf-symbc:compilePeersJava
Note: /Users/aosenxiong/spf/jpf-symbc/jpf-symbc/src/peers/gov/nasa/jpf/symbc/JPF_gov_nasa_jpf_symbc_Debug.java uses or overrides a deprecated API.
Note: Recompile with -Xlint:deprecation for details.

> Task :jpf-symbc:compileTestJava
Note: Some input files use or override a deprecated API.
Note: Recompile with -Xlint:deprecation for details.

Deprecated Gradle features were used in this build, making it incompatible with Gradle 9.0.

You can use '--warning-mode all' to show the individual deprecation warnings and determine if they come from your own scripts or plugins.

For more on this, please refer to https://docs.gradle.org/8.4/userguide/command_line_interface.html#sec:command_line_warnings in the Gradle documentation.

BUILD SUCCESSFUL in 2s
```
</details>

### 4. Run Simple Example from the command line
*Inside the jpf-symbc folder, run the following command:*

```{bash}
cd jpf-symbc
java -Xmx1024m -ea -jar ../jpf-core/build/RunJPF.jar ./src/examples/demo/NumericExample.jpf
```

<details>
<summary>Console Output</summary>

```
yannic@Yannics-MacBook-Pro jpf-symbc % java -Xmx1024m -ea -jar ../jpf-core/build/RunJPF.jar ./src/examples/demo/NumericExample.jpf
symbolic.min_int=-2147483648
symbolic.min_long=-9223372036854775808
symbolic.min_short=-32768
symbolic.min_byte=-128
symbolic.min_char=0
symbolic.max_int=2147483647
symbolic.max_long=9223372036854775807
symbolic.max_short=32767
symbolic.max_byte=127
symbolic.max_char=65535
symbolic.min_double=4.9E-324
symbolic.max_double=1.7976931348623157E308
JavaPathfinder core system v8.0 (rev c25d564ee76089e11adaa171137b2d7a2905e943) - (C) 2005-2014 United States Government. All rights reserved.


====================================================== system under test
demo.NumericExample.main()

====================================================== search started: 26/11/22 12:28 PM
Property Violated: PC is constraint # = 1
((a_1_SYMINT[-2147483648] + b_2_SYMINT[-2147483646]) - CONST_2) == CONST_0
Property Violated: result is  "java.lang.ArithmeticException: div by 0..."
****************************

====================================================== error 1
gov.nasa.jpf.vm.NoUncaughtExceptionsProperty
java.lang.ArithmeticException: div by 0
	at demo.NumericExample.test(NumericExample.java:26)
	at demo.NumericExample.main(NumericExample.java:34)


====================================================== snapshot #1
thread java.lang.Thread:{id:0,name:main,status:RUNNING,priority:5,isDaemon:false,lockCount:0,suspendCount:0}
  call stack:
	at demo.NumericExample.test(NumericExample.java:26)
	at demo.NumericExample.main(NumericExample.java:34)


====================================================== Method Summaries
Inputs: a_1_SYMINT,b_2_SYMINT

demo.NumericExample.test(-2147483648,-2147483646)  --> "java.lang.ArithmeticException: div by 0..."

====================================================== Method Summaries (HTML)
<h1>Test Cases Generated by Symbolic JavaPath Finder for demo.NumericExample.test (Path Coverage) </h1>
<table border=1>
<tr><td>a_1_SYMINT</td><td>b_2_SYMINT</td><td>RETURN</td></tr>
<tr><td>-2147483648</td><td>-2147483646</td><td>"java.lang.ArithmeticException: div by 0..."</td></tr>
</table>

====================================================== results
error #1: gov.nasa.jpf.vm.NoUncaughtExceptionsProperty "java.lang.ArithmeticException: div by 0  at demo.N..."

====================================================== statistics
elapsed time:       00:00:00
states:             new=3,visited=0,backtracked=3,end=0
search:             maxDepth=2,constraints=0
choice generators:  thread=1 (signal=0,lock=1,sharedRef=0,threadApi=0,reschedule=0), data=1
heap:               new=466,released=4,maxLive=0,gcCycles=1
instructions:       6308
max memory:         245MB
loaded code:        classes=85,methods=1648

====================================================== search finished: 26/11/22 12:28 PM
```
</details>


<!-- ### 6. Use SPF inside Eclipse
TODO -->

<br>