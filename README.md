# CL-BUNNY
CL-BUNNY is a RabbitMQ client. CL-BUNNY is based on [cl-rabbit](https://github.com/lokedhs/cl-rabbit) and inspired by [bunny](https://github.com/ruby-amqp/bunny).

## Examples
#### Hello World!

```lisp
(defun hello-world ()
  (with-connection ("amqp://" :one-shot t)
    (with-channel ()
      (let ((x (default-exchange)))
        (->
          (queue.declare "cl-bunny.examples.hello-world" :auto-delete t)
          (subscribe (lambda (message)
                       (log:info "Received ~a"
                                 (babel:octets-to-string (message-body message))))))
        (publish x "Hello world!" :routing-key "cl-bunny.examples.hello-world"))
      (sleep 1))))
```
#### Headers exchange

```lisp
(with-connection ("amqp://" :one-shot t)
    (with-channel ()
      (let ((x (amqp-exchange-declare "headers" :type "headers"))
            (q1 (amqp-queue-declare "" :exclusive t))
            (q2 (amqp-queue-declare "" :exclusive t)))
        (amqp-queue-bind q1 :exchange x :arguments '(("os" . "linux")
                                                     ("cores" . 8)
                                                     ("x-match" . "all")))
        (amqp-queue-bind q2 :exchange x :arguments '(("os" . "osx")
                                                     ("cores" . 4)
                                                     ("x-match" . "any")))
        (subscribe q1 (lambda (message)
                        (log:info "~a received ~a" q1 (babel:octets-to-string (message-body message)))))
        (subscribe q2 (lambda (message)
                        (log:info "~a received ~a" q2 (babel:octets-to-string (message-body message)))))

        (amqp-basic-publish "8 cores/Linux" :exchange x
                                            :properties '((:headers . (("os" . "linux")
                                                                       ("cores" . 8)))))
        (amqp-basic-publish "8 cores/OS X" :exchange x
                                           :properties '((:headers . (("os" . "osx")
                                                                      ("cores" . 8)))))
        (amqp-basic-publish "4 cores/Linux" :exchange x
                                            :properties '((:headers . (("os" . "linux")
                                                                       ("cores" . 4)))))

        (log:info "Waiting...")
        (sleep 3)
        (log:info "Disconnecting"))))
```

#### More?
More examples including can be found [here](examples)

## Authors
* Ilya Khaprov <ilya.khaprov@publitechs.com>

## Copyright
Copyright (c) 2015 Ilya Khaprov <ilya.khaprov@publitechs.com>

## License
Released under MIT license
