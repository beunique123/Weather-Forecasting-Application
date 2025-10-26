#!/bin/bash

#
# Copyright 2007-2020 the original author or authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# OS specific support (must be 'true' or 'false').
cygwin=false
darwin=false
mingw=false
case "`uname`" in
  CYGWIN*) cygwin=true ;;
  Darwin*) darwin=true ;;
  MINGW*)  mingw=true ;;
esac

# Determine if we are running in an interactive session
interactive=false
if [[ -t 0 && -t 1 ]] ; then
    interactive=true
fi

# Determine if we are running in Gitpod
gitpod=false
if [[ "$GITPOD_WORKSPACE_ID" != "" ]] ; then
    gitpod=true
fi

# Set MAVEN_HOME and EXEC to be used by the script.
MAVEN_HOME=
EXEC=$0

# For MinGW and Cygwin, ensure paths are in Unix format before anything else.
if $mingw || $cygwin ; then
  [ -n "$MAVEN_HOME" ] && MAVEN_HOME="`cygpath --unix "$MAVEN_HOME"`"
  [ -n "$JAVA_HOME" ] && JAVA_HOME="`cygpath --unix "$JAVA_HOME"`"
fi

# Set default values for command line arguments
export MAVEN_SKIP_RC=
export MAVEN_BATCH=

while [ $# -gt 0 ]; do
  case "$1" in
    --skip-rc)
      MAVEN_SKIP_RC=true
      ;;
    --batch-mode)
      MAVEN_BATCH=true
      ;;
    *)
      # Unknown option passed to the script, stop parsing here
      break
      ;;
  esac
  shift
done

# Check for the existence of M2_HOME (legacy variable)
if [ -z "$MAVEN_HOME" ]; then
  if [ -n "$M2_HOME" ]; then
    echo "The M2_HOME environment variable is deprecated. Please use MAVEN_HOME instead." >&2
    MAVEN_HOME="$M2_HOME"
  fi
fi

# If MAVEN_HOME is still not set, look for the 'maven.home' system property.
if [ -z "$MAVEN_HOME" ]; then
  MAVEN_HOME="`dirname "$EXEC"`"
fi

# Set path to maven.
if [ -n "$MAVEN_HOME" ]; then
  MVN_HOME="$MAVEN_HOME"
  if [ -n "$JAVA_HOME" ]; then
    if [ "$interactive" = "true" ]; then
        echo "JAVA_HOME=$JAVA_HOME" >&2
    fi
  fi
fi

# Ensure M2_HOME is unset
unset M2_HOME

# Set local repository location
if [ -z "$MAVEN_LOCAL_REPOSITORY" ]; then
    MAVEN_LOCAL_REPOSITORY="$HOME/.m2/repository"
fi

# Define Java commands
if [ -z "$JAVA_HOME" ]; then
    JAVA_CMD="java"
else
    JAVA_CMD="$JAVA_HOME/bin/java"
fi

# Define the Maven command
MVN_CMD="$JAVA_CMD -classpath "$MVN_HOME"/boot/*:"$MVN_HOME"/lib/*"

# Set path to the Maven executable
if [ -z "$MVN_EXEC" ]; then
    MVN_EXEC="$MVN_HOME/bin/mvn"
fi

# Execute Maven
if [ -z "$MAVEN_BATCH" ] ; then
    if $gitpod ; then
        MAVEN_BATCH=true
    fi
fi

if [ -n "$MAVEN_BATCH" ] ; then
    MVN_CMD="$MVN_CMD -B"
fi

if [ -n "$MAVEN_SKIP_RC" ] ; then
    MVN_CMD="$MVN_CMD -s $MVN_HOME/conf/settings.xml"
fi

if [ -n "$MAVEN_LOCAL_REPOSITORY" ] ; then
    MVN_CMD="$MVN_CMD -Dmaven.repo.local=$MAVEN_LOCAL_REPOSITORY"
fi

exec "$MVN_EXEC" "$@"
