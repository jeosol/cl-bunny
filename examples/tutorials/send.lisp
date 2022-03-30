(ql:quickload :cl-bunny.examples)

(in-package :cl-bunny.examples)

(with-connection ("amqp://")
  (with-channel ()
    (let* ((q (queue.declare :name "cl-hello-queue" :auto-delete t)))
      (publish (exchange.default) "Hello world!" :routing-key (queue-name q))
      (format t " [x] Sent 'Hello World!'~%"))))
