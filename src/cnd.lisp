;;;; cnd.lisp

(in-package #:cnd)


(defun text-renderer (renderer font string)
  (let* ((surface (sdl2-ttf:render-text-blended font
		   string
		   255
		   255
		   255
		   0)))
	 (let ((texture (sdl2:create-texture-from-surface renderer surface)))
	 (sdl2:free-surface surface)
	 texture)))

(defun wrap-text-box (text x y)
  (sdl2:make-rect
   x
   y
   (sdl2:texture-width text)
   (sdl2:texture-height text)))

(defun draw (x y load-font renderer string)
   (let* ((text (text-renderer renderer load-font string))
	  (destination-rect (wrap-text-box text x y)))
     (sdl2:set-render-draw-color renderer 255 255 255 0)
     (sdl2:render-copy renderer
		       text
		       :source-rect (cffi:null-pointer)
		       :dest-rect destination-rect)))	 

(defun write-text (x y s renderer font string)
  "Variable 's' is to scale how far apart the space between newline
text is on y intercept. Will have noeffect if no '/' in string."
  (let ((n (count '#\/ string)))
    (if (> n 0)
	(progn
	  (draw x y font renderer (car (ppcre:split "/" string)))
	  (draw x (+ y s) font renderer (cadr (ppcre:split "/" string)))
	  (if (> n 1)
	      (draw x (+ y (* s 2)) font renderer
		    (caddr (ppcre:split "/" string))))
	  (if (> n 2)
	      (draw x (+ y (* s 3)) font renderer
		    (cadddr (ppcre:split "/" string)))))
	(draw x y font renderer string)))) 
