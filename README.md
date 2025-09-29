# FUSE Filesystem Extension in C

This project extends the [Big Brother File System (BBFS)](https://github.com/jpf/fuse-tutorial) by adding **block-level deduplication** and persistence.

---

##  Features
- **FUSE API Integration**: Implemented key callbacks (`getattr`, `read`, `write`, `unlink`) to handle standard UNIX file operations.
- **Block-Level Deduplication**: Splits files into 4KB blocks, computes SHA-1 hashes, and stores only unique blocks to minimize storage use.
- **Custom Storage Management**: Uses `blockstorage.txt` (hash metadata) and `blockdata.bin` (unique data blocks) for efficient data access.
- **Non-Volatile Persistence**: Files remain intact after unmount/remount cycles.
- **Logging**: Custom logging (`log.c`, `log.h`) tracks FUSE operations and internal states for debugging.

---

##  Filesystem Operations
Standard UNIX shell commands work seamlessly with the mounted directory:
The custom logic for these operations is implemented within the FUSE callback functions defined in bbfs.c
	
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
---
#### Testing 
* Test A: Compression & deletion
* Test B: Identical files deduplication
* Test C: Unique block storage
* Test D: Large file support (>64KB)
* Persistence Test: Files survive unmount/remount




