# How to pretty print json

For your `bash/zsh`

```
# pretty print json
alias ppj='python -m json.tool'
```

Then from command line

```
ppj <filename> | pbcopy
```

Then paste where ever your want.

Thanks to Dan Drzimotta for this tip!
