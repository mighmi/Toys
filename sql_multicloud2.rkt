#lang racket

(define (create-vm cloud-provider vm-name image-type instance-type tags)
  `(create-vm ,cloud-provider ,vm-name ,image-type ,instance-type ,tags))

(define (create-storage cloud-provider storage-name size tags)
  `(create-storage ,cloud-provider ,storage-name ,size ,tags))

(define (create-network cloud-provider network-name cidr tags)
  `(create-network ,cloud-provider ,network-name ,cidr ,tags))

(define (list-resources cloud-provider)
  `(list-resources ,cloud-provider))

(define (delete-resource cloud-provider resource-id)
  `(delete-resource ,cloud-provider ,resource-id))

(define (scale-vm cloud-provider vm-id new-instance-type)
  `(scale-vm ,cloud-provider ,vm-id ,new-instance-type))

(define-syntax-rule (with-dependencies dependencies body)
  `(with-dependencies ,dependencies ,body))

(define-syntax-rule (if-exists resource-id then-body else-body)
  `(if-exists ,resource-id ,then-body ,else-body))

(define-syntax-rule (parameterize params body)
  `(parameterize ,params ,body))

(define-syntax-rule (tagged tag-name tag-value body)
  `(tagged ,tag-name ,tag-value ,body))

(define-syntax-rule (try-catch try-body catch-body)
  `(try-catch ,try-body ,catch-body))

(define-syntax tagged
  (syntax-rules ()
    ((_ tag-name tag-value body)
     `(tagged ,tag-name ,tag-value ,body))))

(define-syntax try-catch
  (syntax-rules ()
    ((_ try-body catch-body)
     `(try-catch ,try-body ,catch-body))))

(define (with-dependencies dependencies body)
  `(with-dependencies ,dependencies ,body))

(define (if-exists resource-id then-body else-body)
  `(if-exists ,resource-id ,then-body ,else-body))

(define (parameterize params body)
  `(parameterize ,params ,body))

(define (tagged tag-name tag-value body)
  `(tagged ,tag-name ,tag-value ,body))

(define (try-catch try-body catch-body)
  `(try-catch ,try-body ,catch-body))


    ;
    ;
    ;

(with-dependencies
    ((create-network "AWS" "my-network" "10.0.0.0/16" '(("environment" . "production"))))
  (parameterize
      ((vm1 (create-vm "AWS" "vm-1" "ubuntu" "t2.micro" '(("role" . "web"))))
       (storage1 (create-storage "AWS" "data-disk" 100 '(("type" . "ssd"))))
       (network1 (create-network "Azure" "azure-network" "192.168.0.0/24" '(("location" . "East US"))))
       (vms-to-scale (list "vm-1" "vm-2")))
    (try-catch
        (begin
          (for-each
           (lambda (vm-name)
             (if-exists (create-vm "AWS" vm-name "ubuntu" "t2.micro" '())
                 (scale-vm "AWS" vm-name "t2.medium")
                 (create-vm "AWS" vm-name "ubuntu" "t2.micro" '())))
           vms-to-scale)
          (list-resources "AWS"))
        (lambda (error)
          (display "Error: ")
          (display error))))
