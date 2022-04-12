#lang racket

(require "oo.rkt")

(provide iterator empty? next sample so)

(define-interface iterator
  (method empty?)
  (method next))

(define so
  (object
   (method (empty?) #t)
   (method (next) 'hello)))

(define (sample obj)
  (obj next))
