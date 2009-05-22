#!/bin/bash

cd `dirname $0`

# TODO: replace this with a pom file?

# Replace ../clojure(-contrib)? with your clojure install location

unzip -u ../clojure/clojure.jar -d target/dependency/
unzip -u ../clojure-contrib/clojure-contrib.jar -d target/dependency/
mkdir -p target/classes

java -cp src/:target/classes/:target/dependency -Dclojure.compile.path=target/classes \
 clojure.main -e "(compile 'cork.screw.deps)"

mkdir -p target/jar
cp -r target/dependency/* target/jar
cp -r target/classes/* target/jar
jar cf target/corkscrew.jar -C target/jar .

mkdir -p $HOME/.corkscrew
cp target/corkscrew.jar $HOME/.corkscrew

echo "Corkscrew compiled and installed in ~/.corkscrew."
echo "To use it, copy bin/corkscrew to your path."