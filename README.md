# nvim

### My own vanilla neovim config from scratch

## FOR WINDOWS USERS

### You'll have issues with treesitter and telescope-fzf, follow the steps below to remedy that

## Treesitter

#### Go to <https://www.msys2.org/> and download the "msys2-x86_64-XXXXXX.exe" file

#### Install it, open the terminal and run the following commands

        pacman -Syu
        pacman -S base-devel mingw-w64-ucrt-x86_64-toolchain --needed

#### When asked, choose "mingw-w64-ucrt-x86_64-gcc" (as of this writting, it is number 3, three)

#### After it's done, you may close the terminal, now you have to add msys2 to your PATH

        Open Windows' Run: Win+R and copy paste the line below

        sysdm.cpl

        With, System Properties opened
        Click on "Advanced Tab"
        Click on "Environment Variables..."
        In the "Environment Variables" window opened look for "Path" in "System Variables" section
        Click on edit and in the new window paste the following line:

        C:\msys64\ucrt64\bin

        Press OK on everything, close and reopen your terminal.
        Done. Treesitter will start working.

## Telescope-fzf

### For telescope it's easier, just copy paste all the lines below in your terminal

        cd ~\AppData\Local\nvim-data\lazy\telescope-fzf-native.nvim
        make clean
        cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release
        cmake --build build --config Release
        cmake --install build --prefix build
