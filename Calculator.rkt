#lang racket

(define (calculator)
  (displayln "Simple Calculator")
  (define (display-menu)
    (displayln "Select an operation:")
    (displayln "1. Addition")
    (displayln "2. Multiplication")
    (displayln "3. Quit"))

  (define (get-choice)
    (display "Enter your choice: ")
    (read))

  (define (get-num)
    (display "Enter a number: ")
    (read))

  (define (handle-error msg)
    (displayln msg)
    (calculator))

  (define (calculate operation)
    (define num1 (get-num))
    (define num2 (get-num))

    (cond
      [(equal? operation 1) (+ num1 num2)]
      [(equal? operation 2) (* num1 num2)]
      [else (handle-error "Invalid operation.")]))

  (define (main)
    (display-menu)
    (define choice (get-choice))

    (cond
      [(equal? choice 3) (displayln "Goodbye!")]
      [(or (equal? choice 1) (equal? choice 2))
       (let ([result (calculate choice)])
         (display "Result: ")
         (displayln result)
         (main))]
      [else (handle-error "Invalid choice.")]))

  (main))

(calculator)
