
(in-package #:ghub/doc-tools)

(defgeneric describe/markdown (object stream)
  (:method ((object class) (stream stream))
    ;; note that this could be more effectively mangaed if it was
    ;; implemented as a part of a pretty-printer framework with a
    ;; pretty-printer-depth value (e.g. for headings or list level)
    (labels ((format-iterate (it)
	       (declare (type list it))
	       (cond
		 (it (format stream "~{    * `~S`~%~}" it))
		 (t (format stream "   * (None)~%"))))
	     (format-iterate-classes (it)
	       (format-iterate (mapcar #'class-name it)))
	     (format-iterate-slots (it)
	       (format-iterate (mapcar #'slot-definition-name it))))
      (let (#+NIL (dsub (class-direct-subclasses  object))
	    (dsl (class-direct-slots object))
	    (esl (class-slots object)))
	(format stream "**`~S`** [~S]~%"
		(class-name object)
		(type-of object))
	(format stream "* Direct Superclasses~%")
	(format-iterate-classes
	 (class-direct-superclasses object))
	(format stream "* Direct Subclasses~%")
	(format-iterate-classes
	 (class-direct-subclasses  object))
	(format stream "* Direct Slots~%")
	(format-iterate-slots dsl)
	(format stream "* Inherited Slots~%")
	(format-iterate-slots (set-difference esl dsl
					      :key #'slot-definition-name
					      :test #'eq
					      ))
	))))

#|

(with-output-to-string (s)
  (describe/markdown (find-class 'asdf:component)
		     s))

(describe/markdown (find-class 'asdf:component)
		    *standard-output*)

|#

#| e.g template

`ASDF:SOURCE-FILE` [STANDARD-CLASS]

* Direct Superclasses
    * ASDF:COMPONENT

* Direct Subclasses
    * ASDF:STATIC-FILE
    * ASDF:JAVA-SOURCE-FILE
    * ASDF:C-SOURCE-FILE

    * ASDF:CL-SOURCE-FILE

* Direct Slots
    * TYPE

* Effective Slots
    * ASDF::DESCRIPTION
    ...


|#
