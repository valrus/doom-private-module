(mugur-keymap
  :tapping-term 150
  :rgblight-animations nil

  ;; :combos '((left right escape)
  ;;           (x y (C-x "pressed both x and y at once")))

  :with-keys '((num (tg numeric))
               (cesc (C escape))
               (act (tg actions))
               (symtab (lt symbols tab))
               (bright+ (brightness_up))
               (bright- (brightness_down)))

  :layers
  '(("base"
     ((f19)   (1)    (2)   (3)    (4)    (5)  (num)   (num)    (6)   (7)      (8)    (9)     (0)         (---)
      (---)   (q)    (w)   (e)    (r)    (t)    (=)   (minus)  (y)   (u)      (i)    (o)     (p)         (---)
      (cesc) (C a)  (M s) (G d)  (S f)   (g)                  ("'") (C h)    (M j)  (G k)    (l)         (---)
      (---)   (z)    (x)   (c)    (v)    (b) (hypr)   (meh)   ("/")  (n)      (m)  (comma)  (dot)        (---)
      (act) (grave) ("[") (num) (symtab)                            (symtab) (num)  ("]")  (equal) (tg gaming)
                                       (f19) (home)   (pgup) (f18)
                                              (end)   (pgdown)
                            (G bspace) (cesc) (num)   (capslock) (G enter) (S space)))


  ("symbols"
    (( ) (f1)  (f2)  (f3)  (f4)  (f5)    ( )   ( )    (f6)   (f7)   (f8)  (f9)   (f10) (delete)
     ( ) ("!") ("^") ("#") ("+") ("%") ("+")   ("|") ("|")  ("&")  ("*")  ("$")  ("?")      ( )
     ( ) ("@") (";") (":")  (-)  ("=")               ("`")  (left) (down) (up)  (right)     ( )
     ( ) ("<") ("{") ("[") ("(") ("~")   ( )   ( )   ("\\") (")")  ("]")  ("}")  (">")      ( )
     ( )  ( )   ( )   ( )   ( )                              ( )    ( )    ( )    ( )       ( )
                                     ( ) ( )   ( ) ( )
                                         ( )   ( )
                          (delete) ("(") ( )   ( ) (")") ("_")))

  ("actions"
    ((f14) (bright-) (bright+)    ( )     ( ) ( ) ( )   ( ) ( )    ( )      ( )       ( )       ( )    (f18)
     (f13)    ( )     (ms_up)     ( )     ( ) ( ) ( )   ( ) ( )    ( )      ( )       ( )       ( )    (f17)
     (f12) (ms_left) (ms_down) (ms_right) ( ) ( )           ( ) (ms_left) (ms_down) (ms_up) (ms_right) (f16)
     (f11)    ( )       ( )       ( )     ( ) ( ) ( )   ( ) ( )    ( )      ( )       ( )       ( )    (f15)
     ( )      ( )       ( )       ( )     ( )                      ( )      ( )       ( )       ( )      ( )
                                  (rgb_mod) (rgb_hui)   (rgb_vai) (rgb_tog)
                                            (rgb_hud)   (rgb_vad)
                      (ms_butn2) (ms_butn4) (rgb_sld)   (rgb_mod) (ms_btn5) (ms_btn2)))))
