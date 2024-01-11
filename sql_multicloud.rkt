#lang racket


(define (make-select fields table &optional (conditions '()) (cloud 'aws) (order '()))
  `(SELECT ,fields FROM ,table
           ,(if (not (null? conditions)) `(WHERE ,(string-join conditions " AND ")) '())
           ,(if (not (null? cloud)) `(ON ,cloud) '())
           ,(if (not (null? order)) `(ORDER BY ,@(map (lambda (o) (format "~a ~a" (car o) (cdr o))) order)) '())))

(define (make-where condition)
  `(,condition))

(define (make-cloud provider)
  provider)

(define (make-order-by field order)
  (cons field order))

(define (make-query stmt)
  (displayln (string-append "Executing Query: " stmt)))

;; Example usage:

(define query1
  (make-query
   (make-select '(instance_id name) 'instances
                (make-where '(= status "running"))
                (make-cloud 'aws)
                (make-order-by 'name 'asc))))

(define query2
  (make-query
   (make-select '(instance_id name) 'instances
                (make-where '(= status "terminated"))
                (make-cloud 'azure)
                (make-order-by 'created_at 'desc))))
