;;;; cnd.asd

(asdf:defsystem #:cnd
  :description "Handy text writer built on top of sdl2"
  :author "Iseman Johnson <johnsoni@gmail.com>"
  :license "MIT"
  :serial t
  :pathname "src"
  :depends-on (:sdl2 :sdl2-ttf :cl-ppcre)
  :components ((:file "package")
               (:file "cnd")))

