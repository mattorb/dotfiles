# Matt's dot files
OS X, Fish, VS Code, Karabiner, Hammerspoon, git aliases, git helpers (fclone/fhub).

Goals/etc here: https://mattorb.com/dotfiles/

# Install
```
git clone http://github.com/mattorb/dotfiles
cd dotfiles
./setup.sh
```
or w/o git:
```
curl -sL https://github.com/mattorb/dotfiles/archive/master.tar.gz | tar xz && cd dotfiles-master && ./setup.sh
```

# Highlights
This is not an exhaustive list of what is here, but it covers some of the more interesting things.  For instance, numerous desktop and commandline tools are installed which are not mentioned below.

## The Hyper Key
Using [Karabiner](https://pqrs.org/osx/karabiner/), we redefine the <kbd>right-command</kbd> key to be a new meta key, called the <kbd>hyper</kbd> key.   

We also map the press and hold of the <kbd>hyper</kbd> key to <kbd>command</kbd>+<kbd>ctrl</kbd>+<kbd>alt</kbd>+<kbd>shift</kbd>. We leverage that for defining new global keyboard shortcuts because it has a very low chance of having application level key binding conflicts, so it is a clean slate of slots to bind behaviors on.

## MenuHammer and Launching Applications
Using [MenuHammer](https://github.com/FryJay/MenuHammer) enables a custom menu accessible from anywhere via <kbd>hyper</kbd>+<kbd>space</kbd>.   Many helpful actions, such as toggling wi-fi, executing a favorite script, or launching an application are only an alpha keypress or two away.

<kbd>hyper</kbd>+<kbd>space</kbd> Show Top Menu

<kbd>hyper</kbd>+<kbd>A</kbd> Show Applications Menu

<kbd>hyper</kbd>+<kbd>F</kbd> Show Finder Menu

Each of these takes a couple of key presses to navigate.   

Heavily used applications are bound to a dedicated hotkey which has a good pnemonic: 

<kbd>hyper</kbd>+<kbd>T</kbd> Launches Terminal

<kbd>hyper</kbd>+<kbd>S</kbd> Launches Slack

## Window Management
-- courtesy of [JR](https://github.com/jasonrudolph/keyboard/)

Press <kbd>hyper</kbd>+<kbd>W</kbd> for Window Management 

It pops up a cheatsheet of window resize/move commands, re-using <kbd>h</kbd>,<kbd>j</kbd>,<kbd>k</kbd>, or <kbd>l</kbd> for moving and resizing a window to left half, bottom half, top half, and right half of the screen. 

<kbd>i</kbd>, <kbd>o</kbd>,<kbd>,</kbd>, and <kbd>.</kbd> move and resize to the top left, top right, bottom left, and bottom right, respectively.

## Spaces and Full Screen Applications
I despise full screen *mode* for apps on OS X, but I love giving something the real estate and focus of occupying most/all of the screen . . . so what I am trying at the moment is binding certain apps to their own dedicated spaces and maximizing their windows by default.  i.e. - Slack and VS Code always execute with the window sized to the entire screen, but _not_ in *full screen mode*, in its own space.  This required some custom plist juggling.  See [here](prefs/osx/spaces.plist) for what is currently set up.

## Super Duper mode
-- courtesy of [JR](https://github.com/jasonrudolph/keyboard/)

Using [Hammerspoon](https://www.hammerspoon.org), we enable the simultaneous press of <kbd>s</kbd>+<kbd>d</kbd> to activate a mode which temporarily changes the function of other keys on the home row.

With the left hand, press and hold <kbd>s</kbd>+<kbd>d</kbd> to enter super duper mode.  Then use the right hand to press <kbd>h</kbd>,<kbd>j</kbd>,<kbd>k</kbd>, or <kbd>l</kbd> for moving the cursor left, down, up, or right.  Additionally, you can add <kbd>a</kbd> for <kbd>alt</kbd>, <kbd>f</kbd> of <kbd>command</kbd>, and <kbd>space</kbd> for <kbd>shift</kbd> using the left hand.

This is mostly following what Jason implemented [here](https://github.com/jasonrudolph/keyboard/), so please refer to that for more explanation and detail.  There are a few other useful key combos that come with super duper mode (like tab navigation with <kbd>i</kbd> and <kbd>o</kbd> for instance).

My [fork](https://github.com/mattorb/keyboard) introduces the following key changes from the original:
1. In super duper mode, emit 'nudging' mousewheel events with <kbd>n</kbd>,<kbd>m</kbd>,<kbd>,</kbd>,<kbd>.</kbd>.
2. In super duper mode, activate application menu with <kbd>g</kbd>
3. Adds 'Ah fudge' mode.    

## Ah Fudge Mode
I added an <kbd>a</kbd>h <kbd>f</kbd>udge mode analagous to super duper, but which maps <kbd>h</kbd>,<kbd>j</kbd>,<kbd>k</kbd>, or <kbd>l</kbd> to
<kbd>home</kbd>, <kbd>pgdn</kbd>, <kbd>pgup</kbd>, and <kbd>end</kbd>.   <kbd>i</kbd> switches to previous window, <kbd>o</kbd> switches to next window.

The cursor movement/navigation part of this is especially useful on a laptop keyboard, but also generally better for keeping your hands on the home row.  Some of the reasoning and thought behind what I adopted can be found [here](https://mattorb.com/level-up-shortcuts-hammerspoon-home-row/).

## Application level keyboard shortcut helpers

<kbd>hyper</kbd>+<kbd>o</kbd> to autocomplete search menu items in the current application

<kbd>hyper</kbd>+<kbd>p</kbd> for a cheatsheet of all menu items and their shortcut keys  (courtesy of KSheet hammerspoon spoon)

Key help in the shell (see below)

## Shell Enhancements
[Fish](https://www.fishshell.com) is my shell of choice for its clean and thoughtful syntax.

One thing I'm trying to get better at is using handy commandline shortcuts.  As part of that I added a keybinding:

<kbd>alt</kbd>+<kbd>K</kbd> will show commandline keyboard shortcut help in-line while in the Terminal.   

It keeps the cursor in-position in the commandline even after displaying a cheat sheet.  This means you can think 'What is that key that does x', press <kbd>alt</kbd>+<kbd>k</kbd> without losing your spot, see the help and then directly use that key all without leaving the commandline window as illustrated [here](https://mattorb.com/level-up-shortcuts-and-the-hyper-key/).

## FZF Command line  
[FZF](https://github.com/junegunn/fzf) is a command-line fuzzy finder that enables all sorts of interesting possibilities, including a lot of the features bound to keys in the *Shell Enhancements* section above.

I'm using it for numerous things like replacing history search, dir/file tab completion, and to drive some other situations where one or more items needs to be selected from a list. 

For example:

<kbd>ctrl</kbd>+<kbd>R</kbd> search history w/fzf+preview

<kbd>ctrl</kbd>+<kbd>F</kbd> inserts a file path (starts from token under by cursor)

<kbd>alt</kbd>+<kbd>O</kbd>	changes into subdirectories (starts from token by cursor)

<kbd>ctrl</kbd>+<kbd>O</kbd> open file using default editor

<kbd>ctrl</kbd>+<kbd>G</kbd> open file using system bound app (pdf/img/etc)


Tour [here](https://mattorb.com/the-many-faces-of-fzf/)

## Git Aliases and Helpers
**Numerous** helpful [Git Aliases](git/.gitaliases) are available, several which integrate with capabilities of fzf.

Scripts like [fstash](bin/fstash) for managing stashes, [fclone](fish/functions/fclone.fish), [fco](fish/functions/fco.fish) for checking out a branch and [fhub](fish/functions/fhub.fish) for cloning from and browsing to available private github repo's.  

History of building fhub and fclone here:  [part 1](https://mattorb.com/fuzzy-find-github-repository/), [part 2](https://mattorb.com/fuzzy-find-a-github-repository-part-deux/)

## Screen Recording / Presenting
I'm currently using [Gifox](https://gifox.io) for to record animated gifs of terminal sessions, combined with [KeyCastr](https://github.com/keycastr/keycastr) to overlay keypresses, and some custom fish scripts to minimize prompt and window title info. (see prompt_mini/prompt_main/title_empty in fish/functions/)

### Inspiration / Credits
I've tried to mention sources when something was derived, but a couple of large influences stand out in what's here:
* http://github.com/jasonrudolph/keyboard
* https://dotfiles.github.io
* Fish community wiki
* Hammerspoon community
* Karabiner community

