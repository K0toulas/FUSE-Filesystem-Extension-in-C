# FUSE-Filesystem Extension in C

Developed as a core assignment for the Operating Systems course (ECE318), this project extends the Big Brother File System (BBFS) skeleton. It features:


* FUSE API Integration: Implementing numerous FUSE callbacks (getattr, read, write, readdir, etc.) to translate standard UNIX system calls into custom file system logic.
* Explicit Block Storage: Managing file data by saving blocks within a single designated backing file (e.g., blockstorage.txt as seen in bbfs.c), rather than relying on the 	underlying host file system's structure.
* Structured Logging: Utilizing a custom logging library (log.c/log.h) to meticulously log all FUSE operations and internal state for debugging and analysis.
* Filesystem Interface & Commands

---
The commands are standard UNIX shell commands that interact with the mounted directory. The custom logic for these operations is implemented within the FUSE callback 			functions defined in bbfs.c
	
  * **`./bbfs <rootdir> <mountdir>`**	Mounts the custom filesystem. <rootdir> is the storage folder, and <mountdir> is the access point.
  * **`fusermount -u <mountdir>`**	***CRITICAL***: Safely unmounts the filesystem, ensuring data integrity.
  * **`ls <dir>`**	Lists directory contents (Calls bbfs_readdir).
  * **`touch <file>`**	Creates a new file (Calls bbfs_create, bbfs_mknod).
  * **`echo ... > <file>`**	  Writes data to a file (Calls bbfs_write).
  * **`rm <file>`**	 Deletes a file (Calls bbfs_unlink).

  ---
  ### Build and Run Instructions

1.  **Clone the Repository:**
    ```bash
    git clone [https://github.com/K0toulas/FUSE-Filesystem-Extension-in-C]
    ```
2.  **Navigate and Compile:** (If you are not in the working directory)
    ```bash
    cd filesystem
    make
    ```
3.  **Prepare Directories: Create the two directories required for mounting.**
    ```bash
    mkdir rootdir mountdir
     ```
4. **Run the Application: Execute the compiled binary to mount the filesystem.**
	```bash
 	# Use -f flag to run in the foreground for real-time console logging
	./bbfs rootdir mountdir -f

5. **Test Operations: The filesystem is now accessible through mountdir.**
	```bash
	echo "Filesystem test data" > mountdir/sample.txt
	ls -l mountdir
	cat mountdir/sample.txt

6. **Unmount: ***Always unmount*** the filesystem before exiting the process.**
	```bash
 	fusermount -u mountdir
(See more inside the report)
