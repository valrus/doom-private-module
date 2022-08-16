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


(defconst
  key-shortcuts
  '((num (tg numeric))
    (gam (tg gaming))
    (gbsp (G bspace))
    (cesc (C escape))
    (act (tg actions))
    (sym (osl symbols))
    (unsym (tg symbols))))

(defconst shared-layers
  '(("base"
     ((---)     (1)   (2)   (3)    (4)    (5)   (---)     (---)   (6)   (7)   (8)     (9)     (0)   (---)
      (f15)     (q)   (w)   (f)    (p)    (b)   (---)     (---)   (j)   (l)   (u)     (y)     ("'") (f16)
      (cesc)    (C a) (M r) (G s)  (S t)  (g)                     (m)   (S n) (G e)   (M i)   (C o) (---)
      (tg caps) (z)   (x)   (c)    (d)    (v)   (---)     (---)   ("/") (k)   (h)     (comma) (dot) (---)
      (gam)     (num) (sym) (gbsp) (cesc)                               (gret) (sspc) (sym)   (num) (act)
                                        (prior) (hypr)    (meh) (next)
                                                (---)     (---)
                                    (---) (---) (---)     (---) (---) (---)))

  ("symbols"
    (( ) (f1)  (f2)  (f3) (f4)    (f5) ( )     ( )  (f6)      (f7)      (f8)  (f9)  (f10)  (delete)
     ( ) (!)   (^)  ("#") (+)     (%)  ( )     (|)  (|)       (&)       (*)   ($)   ("?")       ( )
     ( ) (@)  (";")  (:)  (-)     (=)              ("`")     (left)    (down) (up) (right)      ( )
     ( ) (<)   ({)  ("[") ("(")    (~)  ( )     ( ) ("\\")    (")")     ("]")  (})   (>)         ( )
     ( ) ( )   ( )   ( )  (unsym)                         (unsym)  ( )   ( )   ( )         ( )
                                       ( )  ( )     ( ) ( )
                                            ( )     ( )
                             (delete) (tab) ( )     ( ) (tab) (_)))

  ("actions"
    ((f14) (bright-) (bright+)    ( )       ( )        ( ) ( )     (reset) ( )    ( )      ( )       ( )       ( )    (f18)
     (f13)    ( )     (ms_up)     ( )       ( )        ( ) ( )     ( )     ( )    ( )      ( )       ( )       ( )    (f17)
     (f12) (ms_left) (ms_down) (ms_right)   ( )        ( )                 ( ) (ms_left) (ms_down) (ms_up) (ms_right) (f16)
     (f11)    ( )       ( )       ( )       ( )    (reset) ( )     ( )     ( )    ( )      ( )       ( )       ( )    (f15)
     ( )      ( )       ( )    (ms_btn2) (ms_btn1)                             (ms_btn1) (ms_btn2)   ( )       ( )      ( )
                                           (rgb_mod) (rgb_hui)     (rgb_vai) (rgb_tog)
                                                     (rgb_hud)     (rgb_vad)
                                       (ms_btn3) (ms_btn4) ( )     (rgb_mod) (ms_btn4) (ms_btn3)))

  ("numeric"
    (( )     ( ) ( ) ( ) ( ) ( ) ( )     ( ) ( ) ( ) ( )  ( )  ( ) ( )
     ( )     (1) (2) (3) (4) (5) ( )     ( ) (6) (7) (8)  (9)  (0) ( )
     (prior) ( ) ( ) ( ) ( ) ( )             ( ) (4) (5)  (6)  ( ) (prior)
     (next)  ( ) ( ) ( ) ( ) ( ) ( )     ( ) ( ) (1) (2)  (3)  ( ) (next)
     ( )     ( ) ( ) ( ) ( )                     (0) ( ) (dot) ( ) ( )
                         ( ) ( )     ( ) ( )
                             ( )     ( )
                     ( ) ( ) ( )     ( ) ( ) ( )))

  ("gaming"
    ((escape)  ( ) ( )   ( )      ( )    ( ) ( )     ( ) ( )   ( )   ( ) ( ) ( ) ( )
      (tab)    ( ) (w)   ( )      ( )    ( ) ( )     ( ) ( )   ( )   ( ) ( ) ( ) ( )
       (C)     (a) (s)   (d)      ( )    ( )             ( )   (h)   (j) (k) (l) ( )
       (S)     ( ) ( )   ( )      ( )    ( ) ( )     ( ) ( )   ( )   ( ) ( ) ( ) (S)
       ( )     ( ) ( ) (bspace) (delete)                     (C) ( ) ( ) ( ) ( )
                                         ( ) ( )     ( ) ( )
                                             ( )     ( )
                             (space) (enter) ( )     ( ) (enter) (space)))

  ("caps"
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
                (gam (tg gaming))
                (gbsp (G bspace))
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
   :config '((ignore-mod-tap-interrupt t)
             (tapping-term 180)
             (combo-term 100)
             (force-nkro t))
   :rules '((force-nkro t))

   :with-keys '((num (tg numeric))
                (cesc (C escape))
                (act (tg actions))
                (sym (osl symbols)))

   :layers shared-layers))

(defun mugur-generate-atreus () (interactive) (mugur-generate mugur-keymap-atreus))
(defun mugur-make-atreus () (interactive) (mugur-make mugur-keymap-atreus))

(defconst mugur-kyria-layout
  '((horizontal . "
$15, $16, $17, $18, $19, $20,                       $23, $24, $25, $26, $27, $28,
$29, $30, $31, $32, $33, $34,                       $35, $36, $37, $38, $39, $40,
$41, $42, $43, $44, $45, $46, $65, $66,   $67, $68, $49, $50, $51, $52, $53, $54,
               $55, $58, $59, $71, $72,   $75, $76, $60, $61, $64")
    (vertical . "
 $8,  $9, $10, $11, $12, $13,                       $47, $48, $49, $50, $51, $52,
$15, $16, $17, $18, $19, $20,                       $53, $54, $55, $56, $57, $58,
$21, $22, $23, $24, $25, $26, $33, $34,   $71, $72, $60, $61, $62, $63, $64, $65,
               $28, $31, $32, $36, $37,   $75, $76, $66, $67, $70")))

(defconst mugur-keymap-kyria
  (mugur-keymap
   :keyboard "kyria"
   :name "valrus"
   :layout 'mugur-kyria-layout
   :include "valrus.h"
   :config '((ignore-mod-tap-interrupt t)
             (rgblight-animations)
             (oled-display-128x64)
             (tapping-term 150)
             (combo-term 100)
             (force-nkro t))
   :rules '((force-nkro t)
            (encoder-enable t)
            (rgblight-enable t)
            (rgb-matrix-enable nil)
            (oled-driver-enable t)
            (src "valrus_encoder.c")
            (src "valrus_oled.c"))

   :with-keys '((num (tg numeric))
                (cesc (C escape))
                (act (tg actions))
                (sym (osl symbols)))

   :layers shared-layers))

(defun mugur-generate-kyria () (interactive) (mugur-generate mugur-keymap-kyria))
(defun mugur-make-kyria () (interactive) (mugur-make mugur-keymap-kyria))
