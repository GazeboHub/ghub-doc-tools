;; -*- lisp -*-

(in-package #:cl-user)

#-asdf
(require #:asdf)

(defpackage #:ghub-doc-tools-system
  (:use #:asdf #:cl))

(in-package #:ghub-doc-tools-system)

;; refer to http://www.alu.org/mop/index.html

(defsystem #:ghub-doc-tools
  :depends-on (#+NIL #:lupine-aux #:closer-mop)
  :components
  ((:file "package")
   (:file "markdown-util"
    :depends-on ("package"))
   ))
