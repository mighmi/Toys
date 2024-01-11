#lang racket

(define (random-pattern)
  (define width 10)
  (define height 10)
  
  (define (random-cell-value)
    (if (< (random 2) 1) 1 0))
  
  (define pattern
    (build-list height
                (lambda (row)
                  (build-list width
                              (lambda (col) (random-cell-value))))))
  
  pattern)

(define (display-pattern pattern)
  (for-each (lambda (row)
              (display (map (lambda (cell) (if (= cell 1) "#" " ")) row))
              (newline))
            pattern))

;; Example: Generate and display a random pattern
(display-pattern (random-pattern))
