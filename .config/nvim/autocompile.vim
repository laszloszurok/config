" dwm
autocmd BufWritePost ~/source/suckless-builds/dwm/config.def.h !cd ~/source/suckless-builds/dwm/; sudo make clean install
autocmd BufWritePost ~/source/suckless-builds/dwm/dwm.c !cd ~/source/suckless-builds/dwm/; sudo make clean install
autocmd BufWritePost ~/source/suckless-builds/dwm/colors.h !cd ~/source/suckless-builds/dwm/; sudo make clean install

" dwmblocks
autocmd BufWritePost ~/source/suckless-builds/dwmblocks/blocks.h !cd ~/source/suckless-builds/dwmblocks/; sudo make clean install && { killall -q dwmblocks; setsid dwmblocks & }
autocmd BufWritePost ~/source/suckless-builds/dwmblocks/dwmblocks.c !cd ~/source/suckless-builds/dwmblocks/; sudo make clean install && { killall -q dwmblocks; setsid dwmblocks & }

" dmenu
autocmd BufWritePost ~/source/suckless-builds/dmenu/config.def.h !cd ~/source/suckless-builds/dmenu/; sudo make clean install
autocmd BufWritePost ~/source/suckless-builds/dmenu/dmenu.c !cd ~/source/suckless-builds/dmenu/; sudo make clean install
autocmd BufWritePost ~/source/suckless-builds/dmenu/colors.h !cd ~/source/suckless-builds/dmenu/; sudo make clean install

" st
autocmd BufWritePost ~/source/suckless-builds/st/config.def.h !cd ~/source/suckless-builds/st/; sudo make clean install
autocmd BufWritePost ~/source/suckless-builds/st/st.c !cd ~/source/suckless-builds/st/; sudo make clean install

" slock
autocmd BufWritePost ~/source/suckless-builds/slock/config.def.h !cd ~/source/suckless-builds/slock/; sudo make clean install
autocmd BufWritePost ~/source/suckless-builds/slock/slock.c !cd ~/source/suckless-builds/slock/; sudo make clean install
