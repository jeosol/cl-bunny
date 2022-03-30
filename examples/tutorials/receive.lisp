(ql:quickload :cl-bunny.examples)

(in-package :cl-bunny.examples)

(with-connection ("amqp://")
  (with-channel ()
    (let ((q (queue.declare :name "cl-hello-queue" :auto-delete t)))
      (format t " [*] Waiting for messages in queue 'hello'~%")
      (subscribe q (lambda (message)
                     (format t " [x] Received ~a~%" (message-body-string message))
                     (message.ack message))
                 :type :sync)
      (consume :one-shot t :timeout nil))))
