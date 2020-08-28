(setf mugur-qmk-path (expand-file-name "~/qmk_firmware"))

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

(mugur-keymap
  :tapping-term 150
  :rgblight-animations nil

  ;; :combos '((left right escape)
  ;;           (x y (C-x "pressed both x and y at once")))

  :with-keys '((num (tg numeric))
               (cesc (C escape))
               (act (tg actions))
               (symtab (lt symbols tab)))

  :layers
  '(("base"
     ((f19)   (1)    (2)   (3)    (4)    (5)   (num)     (num)    (6)   (7)      (8)    (9)     (0)         (---)
      (---)   (q)    (w)   (e)    (r)    (t)     (=)     (-)      (y)   (u)      (i)    (o)     (p)         (---)
      (cesc) (C a)  (M s) (G d)  (S f)   (g)                     ("'") (C h)    (M j)  (G k)    (l)         (---)
      (---)   (z)    (x)   (c)    (v)    (b) (C-M-G)     (C-M-S) ("/")  (n)      (m)  (comma)  (dot)        (---)
      (act) (grave) ("[") (num) (symtab)                              (symtab)  (num)  ("]")  (equal) (tg gaming)
                                       (f19) (home)     (prior) (f18)
                                              (end)     (next)
                            (G bspace) (cesc) (num)     (tg caps) (G enter) (S space)))


  ("symbols" (1 0 0)
    (( ) (f1)  (f2)  (f3)  (f4)  (f5)    ( )     ( )    (f6)   (f7)   (f8)  (f9)   (f10) (delete)
     ( ) ("!") ("^") ("#") ("+") ("%") ("+")     ("|") ("|")  ("&")  ("*")  ("$")  ("?")      ( )
     ( ) ("@") (";") (":")  (-)  ("=")                 ("`")  (left) (down) (up)  (right)     ( )
     ( ) ("<") ("{") ("[") ("(") ("~")   ( )     ( )   ("\\") (")")  ("]")  ("}")  (">")      ( )
     ( )  ( )   ( )   ( )   ( )                                ( )    ( )    ( )    ( )       ( )
                                     ( ) ( )     ( ) ( )
                                         ( )     ( )
                          (delete) ("(") ( )     ( ) (")") ("_")))

  ("actions" (0 1 0)
    ((f14) (bright-) (bright+)    ( )     ( ) ( ) ( )     ( ) ( )    ( )      ( )       ( )       ( )    (f18)
     (f13)    ( )     (ms_up)     ( )     ( ) ( ) ( )     ( ) ( )    ( )      ( )       ( )       ( )    (f17)
     (f12) (ms_left) (ms_down) (ms_right) ( ) ( )             ( ) (ms_left) (ms_down) (ms_up) (ms_right) (f16)
     (f11)    ( )       ( )       ( )     ( ) ( ) ( )     ( ) ( )    ( )      ( )       ( )       ( )    (f15)
     ( )      ( )       ( )       ( )     ( )                     (ms_btn1) (ms_btn2)   ( )       ( )      ( )
                                  (rgb_mod) (rgb_hui)     (rgb_vai) (rgb_tog)
                                            (rgb_hud)     (rgb_vad)
                              (ms_btn2) (ms_btn4) ( )     (rgb_mod) (ms_btn5) (ms_btn2)))

  ("numeric" (0 0 1)
    (( ) ( ) ( ) ( ) ( ) ( ) ( )     ( ) ( ) ( ) ( )  ( )  ( ) ( )
     ( ) (1) (2) (3) (4) (5) ( )     ( ) (6) (7) (8)  (9)  (0) ( )
     ( ) ( ) ( ) ( ) ( ) ( )             ( ) (4) (5)  (6)  ( ) ( )
     ( ) ( ) ( ) ( ) ( ) ( ) ( )     ( ) ( ) (1) (2)  (3)  ( ) ( )
     ( ) ( ) ( ) ( ) ( )                     (0) ( ) (dot) ( ) ( )
                         ( ) ( )     ( ) ( )
                             ( )     ( )
                     ( ) ( ) ( )     ( ) ( ) ( )))

  ("gaming" (1 1 1)
    (( ) ( ) ( ) ( )   ( )   ( ) ( )     ( ) ( )   ( )   ( ) ( ) ( ) ( )
     ( ) ( ) (w) ( )   ( )   ( ) ( )     ( ) ( )   ( )   ( ) ( ) ( ) ( )
     ( ) (a) (s) (d)   ( )   ( )             ( )   (h)   (j) (k) (l) ( )
     ( ) ( ) ( ) ( )   ( )   ( ) ( )     ( ) ( )   ( )   ( ) ( ) ( ) ( )
     ( ) ( ) ( ) ( ) (C)                     (C) ( ) ( ) ( ) ( )
                             ( ) ( )     ( ) ( )
                                 ( )     ( )
                (space) (escape) ( )     ( ) (enter) (space)))

  ("caps"
    (( )  ( )   ( )   ( )   ( )   ( )  ( )     ( )  ( )   ( )   ( )   ( )   ( )  ( )
     ( ) (S-q) (S-w) (S-e) (S-r) (S-t) ( )     ( ) (S-y) (S-u) (S-i) (S-o) (S-p) ( )
     ( ) (S-a) (S-s) (S-d) (S-f) (S-g)              ( )  (S-h) (S-j) (S-k) (S-l) ( )
     ( ) (S-z) (S-x) (S-c) (S-v) (S-b) ( )     ( )  ( )  (S-n) (S-m)  ( )   ( )  ( )
     ( )  ( )   ( )   ( )   ( )                           ( )   ( )   ( )   ( )  ( )
                                   ( ) ( )     ( ) ( )
                                       ( )     ( )
                               ( ) ( ) ( )     ( ) ( ) ( )))))
