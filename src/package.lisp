(defpackage :cl-bunny
  (:use :cl :alexandria :eventfd :amqp)
  (:nicknames :bunny)
  (:export #:with-connection
           #:with-channel
           #:with-consumers

           #:*force-timeout*

           #:message-channel
           #:message-consumer-tag
           #:message-consumer
           #:message-delivery-tag
           #:message-redelivered-p
           #:message-exchange
           #:message-routing-key
           #:message-properties
           #:message-body
           #:message-body-string
           #:message.ack
           #:message.nack
           #:message-header-value
           #:message-property-value

           ;; conditions
           #:authentication-error
           #:error-connection
           #:connection-closed-error
           #:channel-closed-error
           #:threaded-promise-timeout
           #:transport-error
           #:network-error

           ;; high-level interfaces
           #:properties-headers
           #:header-value

           ;; connections pool
           #:*connections-pool*
           #:connections-pool-base
           #:eq-connections-pool
           #:connections-pool.get
           #:connections-pool.add
           #:connections-pool.remove
           #:connections-pool.find-or-run

           #:*connection*
           #:connection.new
           #:connection.open
           #:connection.close

           #:connection-spec
           #:connection-spec-login
           #:connection-spec-password
           #:connection-spec-host
           #:connection-spec-port
           #:connection-spec-vhost
           #:connection-spec-use-tls-p
           #:connection-spec-use-ipv6-p
           #:connection-open-p

           #:*channel*
           #:channel-id
           #:channel-connection
           #:channel-open-p
           #:channel.new
           #:channel.open
           #:channel.flow
           #:channel.new.open
           #:channel.send
           #:channel.confirm
           #:channel.tx
           #:channel.wait-confirms
           #:channel.close

           #:tx.commit
           #:tx.rollback

           #:exchange-on-return-callback

           #:queue.declare
           #:queue.bind
           #:queue.purge
           #:queue.unbind
           #:queue.delete

           #:exchange.default
           #:exchange.topic
           #:exchange.fanout
           #:exchange.direct
           #:exchange.headers
           #:exchange.declare
           #:exchange.delete
           #:exchange.bind
           #:exchange.unbind

           #:publish
           #:consume
           #:subscribe
           #:subscribe-sync
           #:qos))
