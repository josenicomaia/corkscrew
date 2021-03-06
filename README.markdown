# Corkscrew

http://github.com/technomancy/corkscrew

Corkscrew is a build tool for Clojure. It's definitely very
proof-of-concept at this stage. You define a project.clj file in your
project root, and Corkscrew will provide you with tools to build and
manage your project.

It currently requires that Maven be installed to work. This
requirement should be removed in future versions.

## Project File

Here's a sample project file:

    {:name "my-sample"
     :version "1.0"
     :namespaces '(my-sample)
     :dependencies [["rome" "0.9"]]
     :source-dependencies [["clojure-contrib" "r663" :svn
                            "http://clojure-contrib.googlecode.com/svn/trunk"]
                           ["enlive" "95b2558943f50bb9962fe7d500ede353f1b578f0"
                            :git "git://github.com/cgrand/enlive.git"]]}

Dependencies refer to projects hosted in Maven repositories. You
provide the name (aka artifactId) and version, and optionally the
group ID, though this will default to the name if not provided.

You may also specify source dependencies on Clojure projects that are
fetched directly from version-control repositories. You need to
provide the name of the project, the version you want, the SCM it's
managed with (currently only Subversion and Git are supported, but
it's easy to add others), and the repository URL.

TODO: Dependencies on source projects that require AOT are not implemented.

## Install

Running the "install" script should compile Corkscrew and install it.

## Usage

    $ corkscrew deps [project-dir]

Attempts to unpack each of the project's dependencies into the
target/dependency directory. If they aren't cached locally, this will
try to fetch them from the Internet.

    $ corkscrew repl [project-dir-or-jar]

Starts a REPL with the project's classpath and dependencies set up.

    $ corkscrew pom [project-dir]

Write the pom.xml file to the project root. Intended for debugging.

## Planned Features

    $ corkscrew compile [project-dir] [output-jar]

Compiles your source code into the target/classes/ directory. Creates
a jar file containing bytecode. If your project is an application (has
a "main" function, not a library), then this jar will be executable.

    $ corkscrew build-standalone [project-dir] [output-jar]

Builds the project as a jar that contains all its dependencies,
including Clojure itself.

    $ corkscrew install [project-dir-or-jar]

Installs the project's jar into your local maven repository.

    $ corkscrew publish [project-dir-or-jar] [repository]

Uploads the jar and metadata to a remote repository.

## Contributing

Patches welcome; send pull requests or email to technomancy at
gmail. In particular I want to remove the need for maven to run in a
subprocess, but I can't make head or tail of its Java API.

## License

by Phil Hagelberg, (C) 2009

Licensed under the same terms as Clojure.
