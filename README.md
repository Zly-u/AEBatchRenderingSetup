# Multi-Threaded Render Setup for After Effects

Made for simple rendering without a need of extra hand work and setting
up your general rendering pipelines.

### `!!!Made for sequence rendering only!!!`


### Curently includes:

- Preset based rendering (Writing down your preset names in the config
  file)
- Render Queue rendering (selecting Sequence render queue and Audio
  render queue indexes)
- Adjustable paths
- Adjustable memory usage and Image caching per thread


### The rendering consists out of 3 steps:

- Sequence Rendering
- Audio Rendering
- Video Compiling (e.g. combining sequence w/wo audio)

  **All of them are optional and can be run separately through different
  batch files!**

# Setting up

### Requirements:

- [FFMPEG](http://ffmpeg.org/download.html)
- Aerender.exe - it's in your AE already.

  **All the rendering parameters and variables can be changed in
  `_config.bat`!**

### Preparing the setup's components:

1. Add FFMPEG's folder, where its executable at, into `PATH` Enviroment
   variable in Windows.
   - If not possible, then add a full path to the program's
     executable(ffmpeg.exe) into the `_config.bat`'s variable called
     `PATH_TO_FFMPEG`

2. Add Aerender's folder, where its executable at, into `PATH`
   Enviroment variable in Windows.
   - If not possible, then add a full path to the program's
     executable(aerender.exe) into the config file's variable called
     `PATH_TO_AERENDER`

3. Done.

# Params info

**All the rendering parameters and variables can be changed in
`_config.bat`!**

- It has comments about every parameter in the file, pointing out this
  info in here just in case.

- Also, *do not add additional quotes or delete any from the examples in
  the config file, also don't add additional spaces at the beginning,
  and the end of `=` symbols, it's because BATCH sucks, but I used it so
  non-programmers bois on Windows could use this thing.*

---

### `THREADS`

**Description**: for the amount of threads to be used for the rendering
a sequence.
- You can use Env variable `%NUMBER_OF_PROCESSORS%` to set all of your
  threads for rendering.
- You can perform some arithmetical operations on the
  `%NUMBER_OF_PROCESSORS%` variable e.g. division
  `%NUMBER_OF_PROCESSORS%/2` to use half of your available threads.

---

### `IMAGE_CACHE_PERCENT` | _PER RENDER INSTANCE!_

**Description**: Image caching in percentage **[0-100]**.

---

### `MAX_MEMORY_PERCENT` | _PER RENDER INSTANCE!_

**Description**: Max memory usage in percentage **[0-100]**.
