FUSE Filesystem Extension in C (BBFS)

This repository showcases a complete C programming project implemented as a custom, user-space filesystem utilizing the FUSE (Filesystem in Userspace) framework.

Developed as a core assignment for the Operating Systems course (ECE318), the project extends the Big Brother File System (BBFS) skeleton. It demonstrates advanced systems programming concepts and direct kernel interaction:

    FUSE API Integration: Implementing numerous FUSE callbacks (getattr, read, write, readdir, etc.) to translate standard UNIX system calls into custom file system logic.

    Explicit Block Storage: Managing file data by saving blocks within a single designated backing file (blockstorage.txt), rather than relying on the underlying host file system's structure.

    Structured Logging: Utilizing a custom logging library (log.c/log.h) to meticulously log all FUSE operations and internal state for debugging and analysis.

    Cryptographic Libraries: The build process links against libssl and libcrypto, indicating the integration of security features like hashing or encryption for data integrity/confidentiality.

File System Operations

This is not a traditional CLI application; the commands are standard UNIX shell commands that interact with the mounted directory. The custom logic for these operations is implemented within the FUSE callback functions defined in bbfs.c.

Operation
	

Standard UNIX Commands
	

BBFS Implementation & Location

Mount
	

./bbfs <rootdir> <mountdir>
	

Mounts the custom file system. The <rootdir> is the storage folder, and <mountdir> is the access point.

Teardown
	

fusermount -u <mountdir>
	

Safely unmounts the file system, ensuring data integrity before exit.

File Access
	

ls, cat, touch, rm, mkdir
	

Handled by FUSE callbacks (e.g., bbfs_getattr, bbfs_read, bbfs_write).

Storage
	

(Implicit)
	

All file data is stored and retrieved from the blockstorage.txt file located inside the <rootdir>.
Build and Run Instructions

This project requires a Linux environment with the FUSE development package installed (e.g., libfuse-dev on Debian/Ubuntu).

    Clone the Repository:

    git clone [your-repository-url]

    Navigate and Compile: Use the provided Makefile to compile the source files (bbfs.c, log.c) and link with FUSE, SSL, and Crypto libraries.

    cd [project-folder-name]
    make

    Prepare Directories: Create the necessary directories.

    mkdir rootdir mountdir

        rootdir: This is the backing storage location where BBFS will create blockstorage.txt.

        mountdir: This is the empty directory where the file system will be accessible.

    Run and Mount the Filesystem: Execute the compiled binary to mount the file system.

    # The -f flag keeps it in the foreground and outputs logs to the terminal
    ./bbfs rootdir mountdir -f

    To run in the background, remove the -f flag:

    ./bbfs rootdir mountdir

    Test Operations: Interact with the file system using standard commands via the mountdir.

    echo "This is a test file." > mountdir/test.txt
    ls -l mountdir
    cat mountdir/test.txt

    Unmount: CRITICAL: Always unmount before terminating the process.

    fusermount -u mountdir
