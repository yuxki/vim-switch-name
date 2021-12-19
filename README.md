# vim-switch-name
## Contents
 - [Introduction](#introduction)
 - [Usage](#usage)
 - [Options](#options)
 - [ByFunction](#byfunction)

## Introduction
___switchname___ is Easy and Quick variable name case converting tool.

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
|Option|Case|Default|
|---|---|---|
|g:switchname_popup_upper_camel|SwitchnamePopupUpperCamel|1|
|g:switchname_popup_lower_camel|switchnamePopupLowerCamel|1|
|g:switchname_popup_upper_snake|SWITCHNAME_POPUP_UPPER_SNAKE|1|
|g:switchname_popup_lower_snake|switchname_popup_lower_snake|1|
|g:switchname_popup_upper_kebab|SWITCHNAME-POPUP-UPPER-KEBAB|1|
|g:switchname_popup_lower_kebab|switchname-popup-lower-kebab|1|

## Others
### ByFunction
```switchname#switch#SwitchNameOnCursor({case})``` switchs name on cursor by argument.
{case} argument has bellow options at version 1.0 and mapped Plugs.
|Argument|Mapped|Case|
|---|---|---|
switchname#switch#SwitchNameOnCursor("ToUpperCamel")<CR>|\<Plug>SwitchNameOnCursorToUpperCamel|UpperCamel|
switchname#switch#SwitchNameOnCursor("ToLowerCamel")<CR>|\<Plug>SwitchNameOnCursorToLowerCamel|lowerCamel|
switchname#switch#SwitchNameOnCursor("ToUpperSnake")<CR>|\<Plug>SwitchNameOnCursorToUpperSnake|UPPER_SNAKE|
switchname#switch#SwitchNameOnCursor("ToLowerSnake")<CR>|\<Plug>SwitchNameOnCursorToLowerSnake|lower_snake|
switchname#switch#SwitchNameOnCursor("ToUpperKebab")<CR>|\<Plug>SwitchNameOnCursorToUpperKebab|UPPER-KEBAB|
switchname#switch#SwitchNameOnCursor("ToLowerKebab")<CR>|\<Plug>SwitchNameOnCursorToLowerKebab|lower-kebab|
