# Installing Boost and B2 on Linux

**Date:** 2025-09-19

---

### User
I'm installing the Boost C++ libraries. Where or how can I install B2 on Linux?

### Assistant
On Linux, **B2** (formerly called `bjam`) is Boost’s own build tool. You need it in order to compile most of Boost (at least the parts that aren’t header-only).

Here’s how you can install or build it depending on your setup:

---

#### Option 1: Use your package manager (if available)

On many distros, B2 is packaged separately:

- **Debian/Ubuntu**:
  ```bash
  sudo apt update
  sudo apt install b2
  ```
  (On older releases, it might still be called `libboost-build`.)

- **Fedora**:
  ```bash
  sudo dnf install boost-build
  ```

- **Arch Linux**:
  ```bash
  sudo pacman -S boost
  ```
  (This pulls in B2 as part of Boost.)

Check whether you have it by running:
```bash
b2 --version
```

---

#### Option 2: Build it from the Boost source tree

If your distro doesn’t provide `b2` separately or you want the version bundled with the Boost source you downloaded:

1. Download and extract Boost:
   ```bash
   wget https://boostorg.jfrog.io/artifactory/main/release/1.86.0/source/boost_1_86_0.tar.bz2
   tar xf boost_1_86_0.tar.bz2
   cd boost_1_86_0
   ```

2. Run the bootstrap script, which builds B2 for you:
   ```bash
   ./bootstrap.sh
   ```

   This creates a `b2` executable in the Boost root directory.

3. Optionally install it system-wide:
   ```bash
   sudo ./b2 install
   ```
   This installs headers and libraries as well as `b2` (usually under `/usr/local/bin/b2`).

If you only want `b2` itself, you can copy it manually:
```bash
sudo cp ./b2 /usr/local/bin/
```

---

#### Quick sanity check
After installation, verify with:
```bash
b2 --version
```

---

👉 Do you want just `b2` itself (to build Boost or other projects), or are you planning to install the entire Boost library system-wide?

---

### User
I have the latest Boost 1.89 downloaded. Let's install it.

### Assistant
Perfect 👍 Since you already have Boost **1.89** downloaded as a tarball, we’ll build and install it along with `b2`. Here’s a step-by-step guide:

---

#### 1. Extract the archive
```bash
tar xf boost_1_89_0.tar.bz2
cd boost_1_89_0
```

---

#### 2. Build `b2`
Run the bootstrap script (this will create the `b2` build tool):

```bash
./bootstrap.sh
```

- If you want to specify an install prefix (instead of `/usr/local`), do it here:
  ```bash
  ./bootstrap.sh --prefix=/opt/boost-1.89
  ```

This will generate:
- `b2` (the build tool, in the Boost root directory)
- `project-config.jam`

---

#### 3. Build and install Boost
Now use `b2` to build and install Boost:

```bash
./b2
sudo ./b2 install
```

- By default, this installs headers to `/usr/local/include/boost` and libraries to `/usr/local/lib`.
- If you specified `--prefix`, they go under that path instead.

---

#### 4. Verify the installation
Check that `b2` is installed system-wide:
```bash
b2 --version
```

Check that Boost headers are visible:
```bash
ls /usr/local/include/boost | head
```

---

#### 5. (Optional) Set up environment variables
If you installed under a custom prefix, you may want to update `LD_LIBRARY_PATH` so the linker can find Boost libraries:

```bash
export LD_LIBRARY_PATH=/opt/boost-1.89/lib:$LD_LIBRARY_PATH
```

You can add that line to `~/.bashrc` to make it permanent.

---

👉 Do you want me to give you a **minimal install (headers only)** or a **full build (all compiled libraries)**? Some projects only need headers, so we can skip compiling ~30–60 minutes worth of C++ code if you don’t need the heavy parts.
