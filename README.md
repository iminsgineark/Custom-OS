# Ark OS Bootloader

Welcome to **Ark OS**, a simple bootloader written in Assembly. This project demonstrates the fundamentals of creating a bootable floppy disk image that prints a welcome message to the screen when run on a virtual machine (QEMU).

## Project Overview

This project includes:
- A bootloader written in Assembly that prints "Welcome to Ark OS" to the screen using BIOS interrupts.
- A build system using `Makefile` that assembles the bootloader into a binary file and generates a floppy disk image.
- The use of QEMU to emulate the boot process and run the bootloader.

## Getting Started

### Prerequisites

To build and run this project, you will need the following tools installed on your system:

- **NASM**: A popular assembler for x86 architecture.
- **QEMU**: A machine emulator and virtualizer.
- **Make**: A build automation tool.

On Ubuntu/Debian, you can install the prerequisites with:

```bash
sudo apt update
sudo apt install nasm qemu-system-x86 make

