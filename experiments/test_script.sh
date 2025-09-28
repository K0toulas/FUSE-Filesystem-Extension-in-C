#!/bin/bash

# Set directories
ROOTDIR="example/rootdir"
MOUNTDIR="example/mountdir"
BBFS="filesystem/bbfs"

#### INITIAL SETUP ####
# create rootdir mountdir if nonexistent
mkdir -p "${ROOTDIR}/"
mkdir -p "${MOUNTDIR}/"

# Make sure bbfs is unmounted
fusermount -u "${MOUNTDIR}/" 2>/dev/null || true

# Empty the rootdir directory if not empty
if [ "$(ls -A "${ROOTDIR}/")" ]; then
    echo "Root directory is not empty, emptying it..."
    rm -rf "${ROOTDIR:?}/"*
else
    echo "Root directory is already empty."
fi

# Mount bbfs
"${BBFS}" "${ROOTDIR}/" "${MOUNTDIR}/"

echo "bbfs mounted ${ROOTDIR} at ${MOUNTDIR}"

#### TEST A ####
# Copy testA files to mountdir
cp -r "experiments/testA/"* "${MOUNTDIR}"
echo "Copied testA files to mountdir"

# Do ls -alR and wc for hashes amount
ls -alR example/
wc -l example/rootdir/blockstorage.txt
echo "Original files size: $(du -sk --apparent-size "${MOUNTDIR}/"* | awk '{sum += $1} END {print sum " KBs"}')"
echo "Blockdata.bin size: $(du -k example/rootdir/blockdata.bin | cut -f1) KBs"
echo "Hash count: $(wc -l < example/rootdir/blockstorage.txt)"
read -n 1 -s -r -p "Press any key to proceed to test A (deletion of file1.txt)..."

# Remove file1.txt for deletion demonstration
rm "${MOUNTDIR}/file1.txt"
echo "Removed file1.txt from mountdir"
# ls -alR again and wc
ls -alR example/
wc -l example/rootdir/blockstorage.txt
echo "Original files size: $(du -sk --apparent-size "${MOUNTDIR}/"* | awk '{sum += $1} END {print sum " KBs"}')"
echo "Blockdata.bin size: $(du -k example/rootdir/blockdata.bin | cut -f1) KBs"
echo "Hash count: $(wc -l < example/rootdir/blockstorage.txt)"
read -n 1 -s -r -p "Press any key to proceed to test B..."

# Unmount bbfs
fusermount -u "${MOUNTDIR}/"
echo "bbfs unmounted from ${MOUNTDIR}"

# Empty the rootdir directory
rm -rf "${ROOTDIR:?}/"*
echo "Root directory emptied"

#### TEST B ####
# Mount bbfs again
"${BBFS}" "${ROOTDIR}/" "${MOUNTDIR}/"
echo "bbfs mounted ${ROOTDIR} at ${MOUNTDIR}"

# Copy testB files to mountdir
cp -r "experiments/testB/"* "${MOUNTDIR}/"
echo "Copied testB files to mountdir"

# Do ls -alR
ls -alR example/
wc -l example/rootdir/blockstorage.txt
echo "Original files size: $(du -sk --apparent-size "${MOUNTDIR}/"* | awk '{sum += $1} END {print sum " KBs"}')"
echo "Blockdata.bin size: $(du -k example/rootdir/blockdata.bin | cut -f1) KBs"
echo "Hash count: $(wc -l < example/rootdir/blockstorage.txt)"
read -n 1 -s -r -p "Press any key to proceed to test C..."

# Unmount bbfs
fusermount -u "${MOUNTDIR}/"

echo "bbfs unmounted from ${MOUNTDIR}"

# Empty the rootdir directory
rm -rf "${ROOTDIR:?}/"*
echo "Root directory emptied"

#### TEST C ####
# Mount bbfs again
"${BBFS}" "${ROOTDIR}/" "${MOUNTDIR}/"
echo "bbfs mounted ${ROOTDIR} at ${MOUNTDIR}"

# Copy testB files to mountdir
cp -r "experiments/testC/"* "${MOUNTDIR}/"
echo "Copied testC files to mountdir"

# Do ls -alR and wc
ls -alR example/
wc -l example/rootdir/blockstorage.txt
echo "Original files size: $(du -sk --apparent-size "${MOUNTDIR}/"* | awk '{sum += $1} END {print sum " KBs"}')"
echo "Blockdata.bin size: $(du -k example/rootdir/blockdata.bin | cut -f1) KBs"
echo "Hash count: $(wc -l < example/rootdir/blockstorage.txt)"
read -n 1 -s -r -p "Press any key to proceed to test D..."

# Unmount bbfs
fusermount -u "${MOUNTDIR}/"

echo "bbfs unmounted from ${MOUNTDIR}"

# Empty the rootdir directory
rm -rf "${ROOTDIR:?}/"*
echo "Root directory emptied"

#### TEST D ####
# Mount bbfs again
"${BBFS}" "${ROOTDIR}/" "${MOUNTDIR}/"
echo "bbfs mounted ${ROOTDIR}/ at ${MOUNTDIR}/"

# Copy testB files to mountdir
cp -r "experiments/testD/"* "${MOUNTDIR}/"
echo "Copied testD files to mountdir"

# Do ls -alR and wc
ls -alR example/
wc -l example/rootdir/blockstorage.txt
echo "Original files size: $(du -sk --apparent-size "${MOUNTDIR}/"* | awk '{sum += $1} END {print sum " KBs"}')"
echo "Blockdata.bin size: $(du -k example/rootdir/blockdata.bin | cut -f1) KBs"
echo "Hash count: $(wc -l < example/rootdir/blockstorage.txt)"
read -n 1 -s -r -p "Press any key to finish testing..."

# Unmount bbfs
fusermount -u "${MOUNTDIR}/"

echo "bbfs unmounted from ${MOUNTDIR}/"

# Empty the rootdir directory
rm -rf "${ROOTDIR:?}/"*
echo "Root directory emptied"