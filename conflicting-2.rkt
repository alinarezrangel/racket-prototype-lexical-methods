#lang racket

(require "oo.rkt")

(provide tape empty? next prev sample)

(define-interface tape
  (method empty?)
  (method next)
  (method prev))

(define (sample obj)
  (obj next))
