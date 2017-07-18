extends: post.liquid
title: SSIS Variable Dispenser Template
date: 17 Jul 2017 16:00:00 +0100
path: 2017/variable-dispenser
tags: ssis, bids, template
---

I don't write enough SSIS script blob tasks to commit this to memory. This is the safest way to access variables without inadvertantly locking them after a crash.

```C#
public void Main()
{
	Variables vars = null;

	try
	{
		Dts.VariableDispenser.LockForWrite("User::strWritable");
		Dts.VariableDispenser.LockForRead("User::strReadable");


		Dts.VariableDispenser.GetVariables(ref vars);
		vars["User::strWritable"].Value = vars["User::strReadable"].Value.ToString();

		Dts.TaskResult = (int)ScriptResults.Success;
	}
	catch (Exception)
	{
		Dts.TaskResult = (int)ScriptResults.Failure;
	}
	finally
	{
		vars.Unlock();
	}
}
```
