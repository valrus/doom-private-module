(mugur-keymap
  :tapping-term 200
  :rgblight-animations nil

  ;; :combos '((left right escape)
  ;;           (x y (C-x "pressed both x and y at once")))

  :with-keys '((num (tg numeric))
               (cesc (C escape))
               (act (tg actions))
               (symtab (lt symbols tab)))

  :layers
  '(("base" vertical
     ((f19)   (1)      (2)      (3)    (4)    (5)  (num)
      (---)   (q)      (w)      (e)    (r)    (t)    (=)
      (cesc) (C a)    (M s)    (G d)  (S f)   (g)
      (---)   (z)      (x)      (c)    (v)    (b) (hypr)
      (act) (grave) (lbracket) (num) (symtab)
                                            (f19) (home)
                                                   (end)
                                 (G bspace) (cesc) (num))

     (num)     (6)     (7)      (8)     (9)       (0)      (---)
     (minus)   (y)     (u)      (i)     (o)       (p)      (---)
             (quote)  (C h)    (M j)   (G k)      (l)      (---)
     (meh)   (slash)   (n)      (m)   (comma)    (dot)     (---)
                     (symtab)  (num) (rbracket) (equal) (tg gaming)
     (pgup) (f18)
     (pgdown)
     (capslock) (G enter) (S space))

  ("symbols"
    (( )  (f1)    (f2)      (f3)     (f4)     (f5)     ( )   ( )      (f6)    (f7)     (f8)     (f9)    (f10)  (delete)
     ( ) (exlm)  (circ)    (hash)   (plus)  (perc)  (plus)   (pipe)  (pipe)  (ampr)   (astr)   (dlr)    (ques)      ( )
     ( )  (at)  (scolon)   (coln)   (minus) (equal)                 (grave)  (left)   (down)    (up)   (right)      ( )
     ( ) (labk)  (cbr)   (lbracket) (lprn)  (tild)     ( )   ( )    (bslash) (rprn) (rbracket) (rcbr)   (rabk)      ( )
     ( )   ( )    ( )       ( )      ( )                                       ( )      ( )      ( )      ( )       ( )
                                                   ( ) ( )   ( ) ( )
                                                       ( )   ( )
                                       (delete) (lprn) ( )   ( ) (rprn) (unds)))

  ("actions"
    ((f14) (brightness_down) (brightness_up)    ( )     ( ) ( ) ( )     ( ) ( ) ( ) ( ) ( ) ( ) ( )
     (f13)        ( )            (ms_up)        ( )     ( ) ( ) ( )     ( ) ( ) ( ) ( ) ( ) ( ) ( )
     (f12)     (ms_left)        (ms_down)    (ms_right) ( ) ( )             ( ) ( ) ( ) ( ) ( ) ( )
     (f11)        ( )              ( )          ( )     ( ) ( ) ( )     ( ) ( ) ( ) ( ) ( ) ( ) ( )
     ( )          ( )              ( )          ( )     ( )                     ( ) ( ) ( ) ( ) ( )
                                                            ( ) ( )     ( ) ( )
                                                            (1 2 3)     ("one two three")
                                                        ( ) ( ) ( )     ( ) ( ) ( )))))
