---
permalink: "/2017/cargo-cult-visual-studio"
title: "Cargo cult - the problem with copying existing code"
published_date: "2017-07-19 11:52:00 +0100"
layout: post.liquid
data:
  tags: "cargocult,visualstudio,msbuild"
  route: blog
---

A quick note to myself on how to identify build errors. This is also a timely
reminder that you should create code from scratch once in a while, rather than
copying an existing project. This is a form of cargo cult (I've linked to the
Wikipedia page in my references below, if you've never heard of the term
before)

The pain to get it working will be worthwhile, as you will have learnt
something new. In my case how to run MSBuild (Microsoft build toolchain) and
identify what version of SSIS (Microsoft flavoured ETL) my project was based
on.

I started to wire up my brand new SSIS project to TeamCity (JetBrains flavoured
CI). Immediately the build failed. Asking the team and no one else had seen the
error before.

Googling suggested that I try and run MSBuild on TeamCity. One problem, Devs
don't get direct access to the CI/CD infrastructure. So time to learn how to
run MSBuild locally.

In the start menu > `All Programs` > `VisualStudio 2015` > `VisualStudio Tools`
there's a handy shortcut called `MSBuild Command Prompt for VS2015` this will
setup a command prompt with the correct config to run MSBuild.

After copying over any dependencies for the build task (in my case the SSIS
DLLs from the TeamCity server), it was just a case of pointing MSBuild to my
build file.

```dosbatch
C:\Path\To\SSIS\Package\LOL>msbuild LOL.build
Microsoft (R) Build Engine version 14.0.25420.1
Copyright (C) Microsoft Corporation. All rights reserved.

Build started 19/07/2017 11:29:31.
Project "C:\Path\To\SSIS\Package\LOL\LOL.build" on node 1 (default targets).
SSISBuild:
  **************Building SSIS project: LOL.dtproj **************
  ------
  Loading project file 'LOL.dtproj'

*snipping verbosity*

  C:\Path\To\SSIS\Package\LOL\LOL.build(9,3): error : Error while loading
  package 'WAT.dtsx': The package failed to load due to error 0xC0011008 "Error
  loading from XML. This occurs when CPackage::LoadFromXML fails.\r

*snipping verbosity*

C:\Path\To\SSIS\Package\LOL\LOL.build(9,3): error :    at Microsoft.SqlServer.Dts.Runtime.Package.LoadFromXML(String packageXml, IDTSEvents events)\r

    0 Warning(s)
    2 Error(s) <-- not entirely sure why MSBuild felt the need to run twice,
                   but it did...

Time Elapsed 00:00:01.16
```

This was great, because this was exactly the error I got in TeamCity! Turns out
our existing SSIS projects target SQL Server 2012. The new project in
VisualStudio 2015 target SQL Server 2016 by default. So the error is literally
MSBuild saying, "The SSIS DLLs don't know what the hell this file!"

To downgrade the project, it was just the case of right clicking on the SSIS
project > `Configuration Properties` > `General` > `TargetServerVersion` and
switching to `SQL Server 2012`.

Then as if by magic...

```dosbatch
C:\Path\To\SSIS\Package\LOL>msbuild LOL.build
Microsoft (R) Build Engine version 14.0.25420.1
Copyright (C) Microsoft Corporation. All rights reserved.

Build started 19/07/2017 11:10:42.
Project "C:\Users\staama1\Source\Workspaces\ESPP\Tasks\SSIS\LOL\Main-Dev
\LOL\LOL.build" on node 1 (default targets).
SSISBuild:
  **************Building SSIS project: LOL.dtproj **************
  ------
  Loading project file 'LOL.dtproj'
  Setting output directory to 'bin\Development'
  Setting project ProtectionLevel to 'DontSaveSensitive'
  Loading ConnectionManager 'ADONET.Chronos.conmgr'
  Loading ConnectionManager 'OLEDB.Chronos.conmgr'
  Loading package 'WAT.dtsx'
  Changing protection level of package to 'DontSaveSensitive'
  Saving project to: 'bin\Development\LOL.ispac'
Done Building Project "C:\Users\staama1\Source\Workspaces\ESPP\Tasks\SSIS\OPF_REPSYS\Main-Dev\LOL\LOL.build" (default targets).


Build succeeded.
    0 Warning(s)
    0 Error(s)

Time Elapsed 00:00:01.43
```

## References

- [Cargo cult](https://en.wikipedia.org/wiki/Cargo_cult)
- [MSBuild walkthrough](https://docs.microsoft.com/en-gb/visualstudio/msbuild/walkthrough-using-msbuild)
- [Building MSBuild Project From Scratch](https://docs.microsoft.com/en-gb/visualstudio/msbuild/walkthrough-creating-an-msbuild-project-file-from-scratch)
