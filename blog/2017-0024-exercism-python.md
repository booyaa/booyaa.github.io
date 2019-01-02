---
permalink: "/2017/exercism-python"
title: Setting up exercism python track with Visual Studio Code
published_date: "2017-07-04 17:08:41 +0100"
layout: post.liquid
data:
  route: blog
  tags: "python, exercism, pylint, pytest, pep8, vscode"
---
Here's a fairly good setup for getting the python track of exercism working
with virtual env and Visual Studio Code.

## virtual env

create one, and install the following packages:

```
pip install pylint autopep8 # always
pip install pytest pytest-cache # minimum
pip install pytest-pep8 pdb # bonus
```

## visual studio code

### Don Jayanmanne’s Python extension


### unit testing (using virtualenv/pyvenv)

Configure using `Run All Unit Tests`  which will add

```
settings.json
{
    "python.unitTest.pyTestArgs": [
        "."
    ],
    "python.unitTest.pyTestEnabled": true
}
```

### ignore certain pylint warnings

```
settings.json
{
    "python.linting.pylintArgs": [
        "--disable=C0111" 
    ]
}
```


### setup command line tools

### first time setup

- install command line tools so you can launch code using `code .`
- activate your virtual env
- nav to your exercism execise path (don’t open the main python folder, code can only handle a single exercise.
- code .
- verify virtual environment is being used trigger command pallet and run `Python: Select Interpreter Workspace` (this doesn’t work at the moment since downgrading to 3.5.2
- check that intellisense and linting are working

### setup unit tests

useful http://exercism.io/languages/python/tests

## Questions
- how do i get code to run unit tests on save
- enable pdb on unit test failure
