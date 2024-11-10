#
#   Copyright 2022 LAIKA. Modifications from Shader Writing in OSL by Mitch J Prater 2024.
# 
#   Licensed under the Apache License Version 2.0 http://apache.org/licenses/LICENSE-2.0,
#   or the MIT license http://opensource.org/licenses/MIT, at your option.
# 
#   This program may not be copied, modified, or distributed except according to those terms.
#

#
# Which RenderMan software version(s) are built if one
# isn't specified in the RMAN_VERSION environment variable?
# Used to build multiple RenderMan versions by listing them here.
#
rman_versions := 25.2 26.2

# SUBDIRS directories will be made using their own Makefile.
SUBDIRS := osl

# Different version builds cannot be run in parallel.
.NOTPARALLEL:

# CURDIR is set by the make system itself: it is not part of the environment.
# It is the preferred means of acquiring the location where make was invoked:
# https://www.gnu.org/software/make/manual/make.html#Recursion
SRCDIR ?= $(CURDIR)
export SRCDIR

PYTHONDIR ?= $(SRCDIR)/python3
export PYTHONDIR

# Build destination. This is where the built files end up.
BUILDDIR ?= $(SRCDIR)/build
export BUILDDIR

#
# Default goal: the target of 'make'.
#
.DEFAULT_GOAL = all

# The default target's prerequisites.
all : $(BUILDDIR) subdirs

# Targets that depend on $(BUILDDIR)
subdirs : $(BUILDDIR)

# Targets whose time stamps we want to ignore.
.PHONY : all info clean subdirs clean_subdirs $(rman_versions)

#------------------------------------------------------------------
# Makefile functionaliy.
#	Make all contents and install it in the BUILDDIR.
#	Sub-directories are made using their own Makefile.
#------------------------------------------------------------------
# Ensure the destination directory exists.
$(BUILDDIR) :
	mkdir -p $(BUILDDIR)

#
# If the RMAN_VERSION environment variable is undefined, then for each member
# of $(rman_versions), define that version as RMAN_VERSION and run make.
# That's all this ifndef section does.
#
ifndef RMAN_VERSION
    .PHONY : $(rman_versions)
    $(rman_versions) :
		@ echo "---------------------------------------------------------------"
		@ echo "PRMan Version: $@"
		@ $(MAKE) clean_subdirs RMAN_VERSION=$@
		@ $(MAKE) --no-print-directory $(MAKECMDGOALS) RMAN_VERSION=$@

    all clean : $(rman_versions)
else

#
# The actual work of building and cleaning are done by the sub-directories.
#
CLEAN_SUBDIRS = $(addprefix clean_, $(SUBDIRS))

.PHONY : $(SUBDIRS) $(CLEAN_SUBDIRS) nuke

subdirs: $(SUBDIRS)
$(SUBDIRS):
	$(MAKE) -C $@

# Cleans the subdirectories.
clean_subdirs : $(CLEAN_SUBDIRS)
$(CLEAN_SUBDIRS):
	$(MAKE) -C $(subst clean_,,$@) clean_local

# Top-level clean also removes the rman version build directory.
clean : clean_subdirs
	@ echo "make clean."
	@ -rm -rf $(BUILDDIR)/$(RMAN_VERSION)

endif

# Also remove the entire build directory.
nuke : clean_subdirs
	@ echo "Removing entire build directory."
	@ -rm -rf $(SRCDIR)/build

#
# Helpful rule.
#
help :
	@ echo "--------------------------------------------------------------------------------"
	@ echo "Environment variables."
	@ echo ""
	@ echo "PIXAR_ROOT must be set to the location of the RenderMan installation, such as"
	@ echo "/opt/pixar"
	@ echo ""
	@ echo "RMAN_VERSION may also be set to the RenderMan version you wish to make, such as"
	@ echo "26.2"
	@ echo ""
	@ echo "If RMAN_VERSION is not set, the rman_versions variable specified"
	@ echo "in this Makefile will be used to build all the versions it lists."
	@ echo ""
	@ echo "Current settings."
	@ echo ""
	@ echo "RMAN_VERSION:  $(RMAN_VERSION)"
	@ echo "rman_versions: $(rman_versions)"
	@ echo "PIXAR_ROOT: $(PIXAR_ROOT)"
	@ echo "SRCDIR:     $(SRCDIR)"
	@ echo "PYTHONDIR:  $(PYTHONDIR)"
	@ echo "BUILDDIR:   $(BUILDDIR)"
	@ echo "SUBDIRS:    $(SUBDIRS)"
	@ echo "--------------------------------------------------------------------------------"
