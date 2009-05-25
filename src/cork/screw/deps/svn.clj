(ns cork.screw.deps.svn
  (:use [clojure.contrib.shell-out]
        [clojure.contrib.java-utils :only [file]]
        [cork.screw.utils :only [extract-jar]]))

(defmethod cork.screw.deps/fetch-dependency :svn
  [[name version type url]]
  (let [dir (file (str cork.screw.deps/corkscrew-dir
                       "svn/" name "/" version "/"))]
    (when (or cork.screw.deps/*force-fetch*
              (not (.exists dir)))
      (.mkdirs (.getParentFile dir))
      (with-sh-dir (.getParent dir)
                   (sh "svn" "checkout" "-r" version url version)))
    dir))
