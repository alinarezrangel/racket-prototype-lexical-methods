#lang racket

(require "oo.rkt"
         (prefix-in iter: "conflicting-1.rkt")
         (prefix-in tape: "conflicting-2.rkt"))

(define sample
  (object
   (method (iter:empty?) #t)
   (method (iter:next) #f)

   (method (tape:empty?) #f)
   (method (tape:next) 0)
   (method (tape:prev) 0)))

(iter:sample sample)
(iter:sample iter:so)
(tape:sample sample)
