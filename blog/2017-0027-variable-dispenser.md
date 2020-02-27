---
permalink: "/2017/variable-dispenser"
title: SSIS Variable Dispenser Template
published_date: "2017-07-17 16:00:00 +0100"
layout: post.liquid
data:
  tags: "ssis, bids, template"
  route: blog
---

I don't write enough SSIS script blob tasks to commit this to memory. This is the safest way to access variables without inadvertantly locking them after a crash.

```C#
public void Main() {
  Variables vars = null;

  try {
    Dts.VariableDispenser.LockForWrite("User::strWritable");
    Dts.VariableDispenser.LockForRead("User::strReadable");

    Dts.VariableDispenser.GetVariables(ref vars);
    vars["User::strWritable"].Value = vars["User::strReadable"].Value.ToString();

    Dts.TaskResult = (int) ScriptResults.Success;
  }
  catch(Exception) {
    Dts.TaskResult = (int) ScriptResults.Failure;
  }
  finally {
    vars.Unlock();
  }
}
```
