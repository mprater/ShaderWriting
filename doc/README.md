# Documentation

The documentation for this repository's content is the
[Shader Writing in Open Shading Language](https://www.routledge.com/Shader-Writing-in-Open-Shading-Language-with-RenderManr-Examples/Prater/p/book/9781032421100)
book itself.

However, some practical information about how to make use of this repository is provided here.

# Requirements
* A [command-line interface](https://en.wikipedia.org/wiki/Command-line_interface)
and its associated [shell](https://en.wikipedia.org/wiki/Shell_(computing))
in which to enter commands.
* [make](https://www.gnu.org/software/make/)
* [python](https://www.python.org/)
* [git](https://git-scm.com/), while optional, is highly recommended in order to
[clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
this repository
(or your own [fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/about-forks)
of this repository)
and to provide source code
[version control](https://git-scm.com/video/what-is-version-control)
if you indend to develop your own shaders.
* [RenderMan<sup>&reg;</sup>](https://renderman.pixar.com/product)
was used to develop the shaders and the build system.
Other rendering systems can still make use of the OSL shading nodes with little or no change.

While a [Linux](https://en.wikipedia.org/wiki/Linux)
system was used to develop this repository's content, as long as your
[operating system](https://www.educative.io/answers/differences-between-windows-macos-and-linux-operating-systems)
has `make` and `python` commands, any necessary modifications to the Makefiles and python installation script should be minor or non-existent.

# Installation
To use the supplied repository content as is:

1. Get a [professional](https://renderman.pixar.com/store) (paid) or 
[non-commercial](https://renderman.pixar.com/store) (free)  license for 
[RenderMan<sup>&reg;</sup>](https://renderman.pixar.com/product).

1. [Install RenderMan<sup>&reg;</sup>](https://rmanwiki.pixar.com/display/REN/Installation+and+Licensing) and ensure it is functioning properly.

1. Set these [environment variables](https://en.wikipedia.org/wiki/Environment_variable) 
appropriately.
This is so the Makefiles used to build and install the shaders can find the OSL compiler that's provided by RenderMan<sup>&reg;</sup>:
    * PIXAR_ROOT
    * RMAN_VERSION

    For example, if your version of the RenderMan<sup>&reg;</sup> renderer is installed in
    `/opt/pixar/RenderManProServer-26.2`, then (for example) using
    [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) shell:

    ```bash
    export PIXAR_ROOT="/opt/pixar"
    export RMAN_VERSION="26.2"
    ```
    
    And while it's not required by the Makefiles, since RenderMan<sup>&reg;</sup> requires an RMANTREE environment variable that's set to the renderer's installation location, you can conveniently use these to define that as well:
    
    ```bash
    export RMANTREE="${PIXAR_ROOT}/RenderManProServer-${RMAN_VERSION}"
    ```

1. Download or [clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) this repository
(or your own [fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/about-forks)
of this repository).

1. Set this environment variable appropriately. It is required so the built shaders can be found by RenderMan<sup>&reg;</sup>:

    - RMAN_SHADERPATH

    For example, if you downloaded or cloned this repository to `${HOME}/ShaderWriting`, then using bash shell:

    ```bash
    export RMAN_SHADERPATH="${HOME}/ShaderWriting/build/${RMAN_VERSION}/shaders:${RMAN_SHADERPATH}"
    ```

1. `cd` into the dowloaded or cloned repository's directory. For example, `cd ${HOME}/ShaderWriting`

1. At this point, you can use the `make` or `make all` command (they are equivalent) to build the shaders.
You can also `cd osl` from the repository directory into the osl code directory and `make` the shaders there.
The osl/Makefile will only make shaders for .osl files that are more recent than their complied .oso file.
In this way, you can edit a source file and execute `make` from within the osl code directory and only the updated source file(s) will be built.

    `make clean` and `make help` can also be executed from either the top-level directory or the osl directory.
`make clean` removes the built shaders, and `make help` provides additional information about the make system and how it's controlled.


# Development

To modify the existing OSL shaders or to develop your own, `cd osl` from the top-level repository directory into the osl code directory.
This is where you will run `make` in order to build any modified or new shaders during their development.

To add a new shader to an existing shader category, add the shader's .osl source file to the desired category directory. It will then be built along with the other shaders from that category.

To create a new category of shader, create a new directory with the category's name in the osl code directory and add it to the [`osl/Makefile`](../osl/Makefile) `SUBDIRS` variable on line 32.
Once that's done, any .osl files in this new category directory will also be built when `make` is executed from the osl code directory location.

To build the entire set of shaders from scratch, run `make nuke` and then `make -j` from the top-level repository directory location rather than the osl code directory (the `-j` option simply tells `make` to use all available processor threads so the build runs as fast as possible).
This will build the shaders for the RenderMan<sup>&reg;</sup> version specified in the RMAN_VERSION environment variable.
Or, if you have multiple RenderMan<sup>&reg;</sup> versions installed and those have been listed in the top-level [`Makefile`](../Makefile) `rman_versions` variable on line 15,
you can ensure the shaders will be built for all those versions by unsetting the RMAN_VERSION environment variable only while the `make` command is running by using: `make -j RMAN_VERSION=`

If you [cloned](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository)
[this repository](https://github.com/mprater/ShaderWriting)
(or your own [fork](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/about-forks)
of this repository)
from [GitHub](https://docs.github.com/)
you'll have created a local
[git repository](https://git-scm.com/book/en/v2/Git-Basics-Getting-a-Git-Repository)
on your computer, so all the source code management tools of `git` will be available to you.
If you are not already famililar with the `git` command, it will be very worthwile to at least 
[learn the basics](https://git-scm.com/doc)
of adding new files and committing changes to existing ones.

At this point you're all set to start modifying, writing, and using your very own OSL shaders!
