---
title: Building a static site generator
date: 2022-05-05
author: Lawrence Logoh
---

# What I'm currently using
[A badly written bash script that depends on pup and pandoc](https://github.com/lawrencelogoh/lawrencelogoh.github.io/blob/921d8d1012f73c6298b7d5412404b0f7b2a33ed/build).

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
 
# Dependencies
Luckily, there are only two dependencies.
yq and pandoc
  
Keep in mind this is for linux/BSD environments.
My main system is alpine linux so it's guaranteed to work on that.
  

# How it used to work
[The script then](https://github.com/lawrencelogoh/lawrencelogoh.github.io/blob/921d8d1012f73c6298b7d5412404b0f7b2a33ed/build).

The program was split into 4 functions.

- genhtml
- genblogindex
- genothers
- genrss

## genhtml

What this did was look in the blog/posts directory for md files and then use pandoc to compile them to html.

## genblogindex

This looked in the blog directory for html files.
It adds them to a list that gets sorted.
It loops through the list and adds a link of a post to the index.md after getting the title and date from the html files.

## genothers

What this did is compile the index files for the root directory and other sub-directories.

## genrss


This loops through the list of sorted html files first.
Second, it gets the title, date and the article tag from each html file and creates a "post" for each html file. 

## The problem
After defining the functions, this is how calling them looked like.

```bash
rm -f ./blog/*.html
genhtml
genblogindex
genhtml # shouldn't be doing this twice
genothers
genrss
```

After deleting the html of all the blog posts I compile them again.
Then I create the **index.md** file.
I then have to compile it again because it didn't compile the latest version.
Then it does the other pages and finally the rss file.

My main problem with this was calling **genhtml** twice.
The **genothers** function also bothered me because I'd have to add another line for every section.
I also did not like the dependency on pup. 

I knew it should be possible to do it without pup but I didn't have the desire to look into it.
So I decided to rewrite/improve the script so it works in a way I'm more comfortable with.

# How it works now
[The script now](https://github.com/lawrencelogoh/lawrencelogoh.github.io/blob/9c27fe701fb522f936147f5ad5fbd01a02f7ad13/build)

Now the number of functions is down to three instead of four.
Also, this script assumes the  folder structure below for certain directories.

```
├── _directory
│   ├── _src
│ 	│   └── post.md
│   └── post.html
```
## genblogindex
What this does is, it first loops through all the files in the **blog/src** directory except the index.md file.
Second, it gets the title, date and filename, creates a markdown link and adds the link to a list.

_NOTE: I know it doesn't do anything with the date. I used it as a key in an associative array. I haven't figured out how to sort the keys yet, but when I do they'll be used and I won't have to have dates in the post filenames._

## gensite
Before the definition of this function, there is a list of directories I want this to use that I define. If I want to add directory I can just add it there, or even add all directories programmatically instead.


For every directory in the list first deletes all the html files in it.
Then it loops through the markdown files in the **src** directory and compiles them to html in the directory itself.

## genrss
This does exactly what it used to do.
The difference is instead of using pup to get data from the html files.
It gets title and date from the markdown files with head and yq and it uses awk to get the html for the post.


# Conclusion
I'm pretty happy with how it works now.
The one problem I have is, I have to still name the files with the dates so they get sorted well.
I can live with that right now, but I'll improve that in the future without using something like pup.

Ideally I'd also like to reduce the dependencies to pandoc and common UNIX utilities.
It could also be fun writing a small script to compile markdown to html.
But this works for now.
