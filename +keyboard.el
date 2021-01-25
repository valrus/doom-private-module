(setf mugur-qmk-path (expand-file-name "~/Code/qmk_firmware"))

;; template
;; ("layer"
;;   (( ) ( ) ( ) ( ) ( ) ( ) ( )     ( ) ( ) ( ) ( ) ( ) ( ) ( )
;;    ( ) ( ) ( ) ( ) ( ) ( ) ( )     ( ) ( ) ( ) ( ) ( ) ( ) ( )
;;    ( ) ( ) ( ) ( ) ( ) ( )             ( ) ( ) ( ) ( ) ( ) ( )
;;    ( ) ( ) ( ) ( ) ( ) ( ) ( )     ( ) ( ) ( ) ( ) ( ) ( ) ( )
;;    ( ) ( ) ( ) ( ) ( )                     ( ) ( ) ( ) ( ) ( )
;;                        ( ) ( )     ( ) ( )
;;                            ( )     ( )
;;                    ( ) ( ) ( )     ( ) ( ) ( )))

(defconst shared-layers
  '(("base"
     ((f19)   (1)        (2)       (3)   (4)  (5)   (num)     (num)    (6)   (7)   (8)       (9)        (0)         (---)
      (---)   (q)        (w)       (e)   (r)  (t)     (=)     (-)      (y)   (u)   (i)       (o)        (p)         (---)
      (cesc) (C a)      (M s)     (G d) (S f) (g)                     ("'") (S h) (G j)     (M k)      (C l)        (---)
      (---)   (z)        (x)       (c)   (v)  (b) (C-M-G)     (C-M-S) ("/")  (n)   (m)     (comma)     (dot)        (---)
      (act) (grave) ("[" actions) (num) (sym)                               (sym) (num) ("]" actions) (equal) (tg gaming)
                                             (f19) (home)     (prior) (f18)
                                                    (end)     (next)
                                  (G bspace) (cesc) (num)     (tg caps) (G enter) (S space)))

  ("symbols" (nil t nil) (32 255 32)
    (( ) (f1)  (f2)  (f3)      (f4)    (f5) ( )     ( )  (f6)      (f7)      (f8)  (f9)  (f10)  (delete)
     ( ) (!)   (^)  ("#")      (+)     (%)  (+)     (|)  (|)       (&)       (*)   ($)   ("?")       ( )
     ( ) (@)  (";")  (:)       (-)     (=)              ("`")     (left)    (down) (up) (right)      ( )
     ( ) (<)   ({)  ("[")     ("(")    (~)  ( )     ( ) ("\\")    (")")     ("]")  (})   (>)         ( )
     ( ) ( )   ( )   ( )  (tg symbols)                         (tg symbols)  ( )   ( )   ( )         ( )
                                       ( )  ( )     ( ) ( )
                                            ( )     ( )
                             (delete) (tab) ( )     ( ) (tab) (_)))

  ("actions" (t nil t) (255 32 255)
    ((f14) (bright-) (bright+)    ( )       ( )        ( ) ( )     (reset) ( )    ( )      ( )       ( )       ( )    (f18)
     (f13)    ( )     (ms_up)     ( )       ( )        ( ) ( )     ( )     ( )    ( )      ( )       ( )       ( )    (f17)
     (f12) (ms_left) (ms_down) (ms_right)   ( )        ( )                 ( ) (ms_left) (ms_down) (ms_up) (ms_right) (f16)
     (f11)    ( )       ( )       ( )       ( )    (reset) ( )     ( )     ( )    ( )      ( )       ( )       ( )    (f15)
     ( )      ( )       ( )    (ms_btn2) (ms_btn1)                             (ms_btn1) (ms_btn2)   ( )       ( )      ( )
                                           (rgb_mod) (rgb_hui)     (rgb_vai) (rgb_tog)
                                                     (rgb_hud)     (rgb_vad)
                                       (ms_btn3) (ms_btn4) ( )     (rgb_mod) (ms_btn4) (ms_btn3)))

  ("numeric" (t nil nil) (255 32 32)
    (( ) ( ) ( ) ( ) ( ) ( ) ( )     ( ) ( ) ( ) ( )  ( )  ( ) ( )
     ( ) (1) (2) (3) (4) (5) ( )     ( ) (6) (7) (8)  (9)  (0) ( )
     ( ) ( ) ( ) ( ) ( ) ( )             ( ) (4) (5)  (6)  ( ) ( )
     ( ) ( ) ( ) ( ) ( ) ( ) ( )     ( ) ( ) (1) (2)  (3)  ( ) ( )
     ( ) ( ) ( ) ( ) ( )                     (0) ( ) (dot) ( ) ( )
                         ( ) ( )     ( ) ( )
                             ( )     ( )
                     ( ) ( ) ( )     ( ) ( ) ( )))

  ("gaming" (t t t) (255 255 255)
    (( ) ( ) ( ) ( )   ( )   ( ) ( )     ( ) ( )   ( )   ( ) ( ) ( ) ( )
     ( ) ( ) (w) ( )   ( )   ( ) ( )     ( ) ( )   ( )   ( ) ( ) ( ) ( )
     ( ) (a) (s) (d)   ( )   ( )             ( )   (h)   (j) (k) (l) ( )
     (S) ( ) ( ) ( )   ( )   ( ) ( )     ( ) ( )   ( )   ( ) ( ) ( ) (S)
     ( ) ( ) ( ) ( ) (C)                     (C) ( ) ( ) ( ) ( )
                             ( ) ( )     ( ) ( )
                                 ( )     ( )
                (space) (escape) ( )     ( ) (enter) (space)))

  ("caps" (nil nil t) (32 32 255)
    (( )  ( )   ( )   ( )   ( )   ( )  ( )     ( )  ( )   ( )   ( )   ( )   ( )  ( )
     ( ) (S-q) (S-w) (S-e) (S-r) (S-t) ( )     ( ) (S-y) (S-u) (S-i) (S-o) (S-p) ( )
     ( ) (S-a) (S-s) (S-d) (S-f) (S-g)              ( )  (S-h) (S-j) (S-k) (S-l) ( )
     ( ) (S-z) (S-x) (S-c) (S-v) (S-b) ( )     ( )  ( )  (S-n) (S-m)  ( )   ( )  ( )
     ( )  ( )   ( )   ( )   ( )                           ( )   ( )   ( )   ( )  ( )
                                   ( ) ( )     ( ) ( )
                                       ( )     ( )
                               ( ) ( ) ( )     ( ) ( ) ( )))))

(defconst mugur-keymap-ergodox
  (mugur-keymap
   :keyboard "ergodox_ez"
   :name "valrus"
   :config '((tapping-term 150)
             (combo-term 100)
             (rgblight-animations nil)
             (rgb-matrix-keypresses t)
             (force-nkro t)
             (permissive-hold t)
             (no-action-macro t)
             (no-action-function t))
   :rules '((force-nkro t)
            (rgblight-enable nil)
            (rgb-matrix-enable t)
            (extraflags "-flto")
            (command-enable nil))

   :with-keys '((num (tg numeric))
                (cesc (C escape))
                (act (tg actions))
                (sym (osl symbols)))

   :layers shared-layers))

(defun mugur-generate-ergodox () (interactive) (mugur-generate mugur-keymap-ergodox))
(defun mugur-make-ergodox () (interactive) (mugur-make mugur-keymap-ergodox))
(defun mugur-flash-ergodox () (interactive) (mugur-flash mugur-keymap-ergodox))

(defconst mugur-atreus-layout
  '((horizontal . "
$16, $17, $18, $19, $20,           $23, $24, $25, $26, $27,
$30, $31, $32, $33, $34,           $35, $36, $37, $38, $39,
$42, $43, $44, $45, $46,           $49, $50, $51, $52, $53,
$56, $57, $58, $59, $71, $72, $75, $76, $60, $61, $62, $63")
    (vertical . "
$9,  $10, $11, $12, $13,           $47, $48, $49, $50, $51,
$16, $17, $18, $19, $20,           $53, $54, $55, $56, $57,
$22, $23, $24, $25, $26,           $60, $61, $62, $63, $64,
$29, $30, $31, $32, $36, $37, $75, $76, $67, $68, $69, $70")))

(defun mugur-light-related (layer-part)
  (or (mugur--leds-p layer-part) (mugur--layer-rgb-p layer-part)))

(defconst mugur-keymap-atreus
  (mugur-keymap
   :keyboard "atreus"
   :name "valrus"
   :layout 'mugur-atreus-layout
   :config '((tapping-term 180)
             (combo-term 100)
             (force-nkro t))
   :rules '((force-nkro t))

   :with-keys '((num (tg numeric))
                (cesc (C escape))
                (act (tg actions))
                (sym (osl symbols)))

   :layers (mapcar (lambda (layer) (remove-if 'mugur-light-related layer)) shared-layers)))

(defun mugur-generate-atreus () (interactive) (mugur-generate mugur-keymap-atreus))
(defun mugur-make-atreus () (interactive) (mugur-make mugur-keymap-atreus))
