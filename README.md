# vim-switch-name
## Contents
 - [Introduction](#introduction)
 - [Usage](#usage)
 - [Options](#options)

## Introduction
#### "switchname" is Easy and Quick variable name case converting tool.
![Demo1](assets/switchname_demo.gif?raw=true)

## Usage
oint cursor at "name" and run this command.
```
 :SwitchName
```
Then, the popup like bellow example is displayed. Press a number key next to
converted "name".
```
 +-----------------+
 | --switchname-- X|
 | 0: SampleName   |
 | 1: sampleName   |
 | 2: SAMPLE_NAME  |
 | 3: sample_name  |
 | 4: SAMPLE-NAME  |
 | 5: sample-name  |
 +-----------------+
```
If press non-number key is pressed, popup is closed.

Note: A "name" is words matched by '[a-zA-Z_\-0-9]\+\C' in this plugin.

## Options
There are options to visible(1) and hide(0) cases on the popup. If there are
cases that you don't use much, hide(0) them in .vimrc and restart Vim.
|option|case e.g.|default|
|---|---|---|
|g:switchname_popup_upper_camel|'SwitchnamePopupUpperCamel'|visible(1)|
|g:switchname_popup_lower_camel|'switchnamePopupLowerCamel'|visible(1)|
|g:switchname_popup_upper_snake|'SWITCHNAME_POPUP_UPPER_SNAKE'|visible(1)|
|g:switchname_popup_lower_snake|'switchname_popup_lower_snake'|visible(1)|
|g:switchname_popup_upper_kebab|'SWITCHNAME-POPUP-UPPER-KEBAB'|visible(1)|
|g:switchname_popup_lower_kebab|'switchname-popup-lower-kebab'|visible(1)|
