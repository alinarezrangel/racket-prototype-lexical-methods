#lang racket

(provide method? method=? object define-method
         define-interface interface? interface-methods)

(struct unique-method ())

(define-syntax define-method
  (syntax-rules ()
    [(_ name) (define name (unique-method))]))

(define (method? a)
  (or (symbol? a) (unique-method? a)))

(define (method=? a b)
  (and (method? a) (method? b)
       (cond [(and (unique-method? a) (unique-method? b))
              (eq? a b)]
             [(and (symbol? a) (symbol? b))
              (eqv? a b)]
             [else #f])))

(define-syntax object-helper
  (syntax-rules (method)
    [(_ msj) (error "unknown method" msj)]
    [(_ msj (method (mname . params) . body) . othr)
     (if (method=? msj mname)
         (λ params . body)
         (object-helper msj . othr))]))

(define-syntax object
  (syntax-rules ()
    [(_ method ...)
     (λ (msj . args)
       (apply (object-helper msj method ...) args))]))

(struct interface (methods))

(define-syntax define-interface
  (syntax-rules (method)
    [(_ name (method mname) ...)
     (begin
       (define-method mname) ...
       (define name (interface (list mname ...))))]))
