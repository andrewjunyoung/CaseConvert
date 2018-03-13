[![Release](0.1.0)]()

CaseComplete: Instant case conversion
=====================================

Current Version: 0.1.1

Makes switching between commonly used cases used in programming painless and
fast.

By v1.0.0 aims to support two-way conversion between the following cases:
* camelCase
* UpperCamelCase
* UPPER\_SNAKE\_CASE
* lower\_snake\_case
* Mixed\_Case\_Underscores
* Mixed-Case-Hyphens
* kebab-case

and one way conversion between the above and
* compoundwords
* ALLCAPS

Representation
--------------

Every case is simplified to a capitalization convention, and a delimiter. For
the sake of brevity for the user and easy entry for programmers not familiar
with jargon, we simplify naming of conventions into

`<caps_convention><delim>`

For example, snake\_case is better represented by the name indicating that the
first and all later words begin with a lower case letter, delimited by \_.

xx\_

lowerCamelCase is better represented by the name indicating that the first word
begins with a lower case character, and all later words begin with an upper
case character, with no delimeter.

xX

The rules are better summarized below:

| Delimiter | Caps Convention     | Common Name    | Short Name |
|:---------:|:-------------------:|:--------------:|:----------:|
| NULL      | lower\_Then\_Upper  | camelCase      | xX         |
| NULL      | Upper\_then\_lower  | -              | Xx         |
| NULL      | Upper\_Then\_Upper  | UpperCamelCase | XX         |
| NULL      | all\_lower          | -              | x, xx      |
| NULL      | ALL\_UPPER          | -              | X          |
| -         | lower\_Then\_Upper  | -              | xX-        |
| -         | Upper\_then\_lower  | -              | Xx-        |
| -         | Upper\_Then\_Upper  | -              | XX-        |
| -         | all\_lower          | kebab-case     | x-, xx-    |
| -         | ALL\_UPPER          | -              | X-         |
| _         | lower\_Then\_Upper  | -              | xX\_       |
| _         | Upper\_then\_lower  | -              | Xx\_       |
| _         | Upper\_Then\_Upper  | -              | XX\_       |
| _         | all\_lower          | snake\_case    | x\_, xx\_  |
| _         | ALL\_UPPER          | snake\_case    | X\_        |

Installation
------------
### Pathogen Install
1. Change directory into your local .vim/bundle dir.
2. git clone https://github.com/chiedojohn/vim-case-convert.git

Usage
-----
To convert a selection of text in visual mode, type the conversion in the
following form, where src is the short name for your start case, and dst is the
short name for the case you want your text to be converted to:

```
:Conv <src> <dst>
```

For example, to convert from camelCase into snake\_case, type:

```
:Conv xX xx_
```

To convert the whole document, as long as you are not inside a visual
block, the above command will still work.

To convert the entire file rather than on a case-by-case basis, add a '!', thus
calling the function via `:Conv! <src> <dst>`. For example,

```
:Conv! xX x_x
```

Note that this plugin makes no distinction between text and code, so any
comments or plain text will be affected by a file level refactor.

License
-------
I release this under the MIT License.
