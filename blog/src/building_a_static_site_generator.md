---
title: Building a static site generator[WIP]
date: 2022-04-03
author: Lawrence Logoh
---

# What I'm currently using
[A badly written bash script that depends on pup and pandoc](https://github.com/lawrencelogoh/lawrencelogoh.github.io/blob/master/build).

I don't mind the pandoc dependency too much as I have it on all my systems anyway.
But the script is really messy and I'd rather have something cleaner.

# Why not just use "x"?

Most of the static site generators I've seen like Hugo and Jekyll seem too complicated for me.
I'm not saying I can't use them, I just felt some friction and thought it would be cool to build my own.

# Requirements 
- Must have as little dependencies as possible.
- Must work on UNIX/UNIX-like systems
- Must generate and RSS file with all blog posts
- Must arrange blog posts by date

# Language choice

My initial instinct was to use python, since I already used bash but I think I'll go with bash again.
I'll try to limit the programs I use in it to what you'll find on a standard Linux/BSD install.
 
