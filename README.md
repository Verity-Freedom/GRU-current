[РУССКОЕ ЧИТАЙМЕНЯ](https://github.com/Chara-Freedom/GRU-current/blob/main/README-RU.md)

# GRU
**Global Rolling Updater current** (GRU) is an automatic update system, a set of specifications, and general deployment principles. A well-known project that uses GRU is [Tor Portable](https://github.com/Chara-Freedom/Tor-Portable).

1. A program that adheres to GRU stores itself in an archive via a permanent link. Archive formats for GRU must be widely known and cross-platform, such as .zip. Depending on the specific implementation, the method of preserving the link may vary; one of them is to keep the archive name unchanged (IPNS).
2. The current version of the program should be specified via a special file (let's call it VERSION_1.0) inside the archive and in the directory with archives. It is strictly forbidden to add spaces to the name of this file so as not to interfere with parsing; parsing may also be affected by whether the file is empty or contains information. Auto-update is implemented by comparing the VERSION file inside the archive and in the web directory with archives — it can be added to the code of any program, and it will connect to the main updater.
3. The program, hosted on the GRU system, does not store the version history at the current link, instead always pointing to the latest one. This makes it convenient to hide previous versions and impossible to download them accidentally. In the case of IPNS, previous versions may remain in the file system.
4. The update itself follows this pattern: 1) move the directory to the current one; 2) check connection with the site and abort the update if there is none; 3) delete all files and directories in the folder, copying user files; 4) download the archive; 5) unpack the archive; 6) delete the archive and all temporary files. The implementations on Windows and Linux differ: Linux stores the executable script in RAM and makes it possible to hot-delete it, unlike Windows. Therefore, on Windows, it is necessary to create several scripts that run in parallel.
5. On Linux, the reference deterministic deployment is to use portable libraries via `./ld-linux-x86-64.so.2 --library-path .`, which allows any program to run in an identical environment, regardless of the distribution. GRU allows for lightning-fast updates of both the program itself and portable libraries, which should be used to unify the user experience when necessary.

This concludes the description of the GRU current specifications.

## Features of GRU
1. Versatility. No separate programs need to be installed to comply with all specifications. The principles of the system can be compatible with a variety of file storage systems (IPNS and Dropbox have been tested). IPNS requires the use of [republisher](https://github.com/Chara-Freedom/GRU-current/blob/main/ipns-republisher.sh) along with the portable [Kubo](https://github.com/ipfs/kubo) version, Dropbox — changing its parameter from dl=0 to dl=1; IPNS has no hidden censorship, allows rollbacks and is open-source, Dropbox may be easier to configure.
2. The rolling release architecture ensures that the user will only receive the latest version of the application, avoiding outdated links.
3. Support for updates starting with Windows 7 and on any Linux systems. Any update file is extremely small in size and generates an already unpacked program with a single click, avoiding restrictions on transferring large files.
4. Preservation of execution bits and any metadata in unpacked files, unlike, for example, git-clone.
5. Ability to transfer any type of information, including constantly updated collections of images and music.
