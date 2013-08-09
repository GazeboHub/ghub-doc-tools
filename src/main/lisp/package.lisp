
(in-package #:cl-user)

(defpackage #:ghub/doc-tools
  (:use #+NIL  #:lupine/aux #:c2mop #:cl)
  #+(or CMU SBCL)
  (:shadowing-import-from
   #+sbcl #:sb-pcl
   #+cmu #:pcl
   #:validate-superclass)
  (:shadowing-import-from
   #:c2mop
   #:defmethod
   #:defgeneric
   #:standard-generic-function
   )
  (:export
   #:describe/markdown
   ))
