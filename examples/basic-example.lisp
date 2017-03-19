(defparameter *screen-width* 800)
(defparameter *screen-height* 600)
(defparameter *string* "My words fly up, my thoughts/remain below: Words without/ thoughts never to heaven go.")
(defmacro with-window-renderer ((window renderer) &body body)
  `(sdl2:with-init (:everything)
     (sdl2:with-window (,window
                        :title "SDL2 Window"
                        :w *screen-width*
                        :h *screen-height*
                        :flags '(:shown))
       (sdl2:with-renderer (,renderer ,window :index -1 :flags '(:accelerated))
	 ,@body))))

 (defun main()
  (sdl2-ttf:init)
  (with-window-renderer (window renderer)
    (sdl2:set-render-draw-color renderer 0 0 0 255)
    (let* ((probe-font (sdl2-ttf:open-font "FallingSky.otf" 20)))
      (sdl2:with-event-loop (:method :poll)
	(:idle ()
	       (sdl2:set-render-draw-color renderer 0 0 0 255)
	       (sdl2:render-clear renderer)
	       (cnd:write-text 50 100 25 renderer probe-font *string*)
	       (sdl2:render-present renderer))
	(:quit ()
	       (when (> (sdl2-ttf:was-init) 0)
		 (sdl2-ttf:close-font probe-font)
		 (sdl2-ttf:quit))
	       t)))))
