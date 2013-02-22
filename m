From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: Core dump with LTTng Tools v2.1.1
Date: Fri, 22 Feb 2013 08:36:46 -0500
Message-ID: <5127746E.7080200__32571.5595311069$1361540322$gmane$org@ericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020609050900020400090303"
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from usevmg20.ericsson.net ([198.24.6.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1U8so3-00064k-2F
	for lttng-dev@lists.lttng.org; Fri, 22 Feb 2013 08:36:55 -0500
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--------------020609050900020400090303
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

Hello

When executing the command "lttng list -k" and I get a core dump with 
the output below. This happens not all the time, but when it happens I 
have to kill the lttng-sessiond and restart the lttng-sessiond. I 
attached the core dump.  Could someone of the LTTng team look into this?

My computer has Ubuntu 12.04 with kernel 3.2.0-29. I've installed LTTng 
modules v2.1.1, LTTng-UST v2.1.1 and userspace-rcu v0.7.6.

Thanks
Bernd

lttng list -k
Kernel events:
-------------
       mm_vmscan_kswapd_sleep (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       mm_vmscan_kswapd_wake (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       mm_vmscan_wakeup_kswapd (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       mm_vmscan_direct_reclaim_begin (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       mm_vmscan_memcg_reclaim_begin (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       mm_vmscan_memcg_softlimit_reclaim_begin (loglevel: TRACE_EMERG 
(0)) (type: tracepoint)
       mm_vmscan_direct_reclaim_end (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       mm_vmscan_memcg_reclaim_end (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       mm_vmscan_memcg_softlimit_reclaim_end (loglevel: TRACE_EMERG (0)) 
(type: tracepoint)
       mm_shrink_slab_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       mm_shrink_slab_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       mm_vmscan_lru_isolate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       mm_vmscan_memcg_isolate (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       mm_vmscan_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       mm_vmscan_lru_shrink_inactive (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       replace_swap_token (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       put_swap_token (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       disable_swap_token (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       update_swap_token_priority (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       udp_fail_queue_rcv_skb (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       timer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       timer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       timer_expire_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       timer_expire_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       timer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       hrtimer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       hrtimer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       hrtimer_expire_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       hrtimer_expire_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       hrtimer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       itimer_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       itimer_expire (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       lttng_statedump_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       lttng_statedump_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       lttng_statedump_process_state (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       lttng_statedump_file_descriptor (loglevel: TRACE_EMERG (0)) 
(type: tracepoint)
       lttng_statedump_vm_map (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       lttng_statedump_network_interface (loglevel: TRACE_EMERG (0)) 
(type: tracepoint)
       lttng_statedump_interrupt (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       sock_rcvqueue_full (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sock_exceed_buf_limit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kfree_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       consume_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       skb_copy_datagram_iovec (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       signal_generate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       signal_deliver (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       signal_overflow_fail (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       signal_lose_info (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       scsi_dispatch_cmd_start (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       scsi_dispatch_cmd_error (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       scsi_dispatch_cmd_done (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       scsi_dispatch_cmd_timeout (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       scsi_eh_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_kthread_stop (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_kthread_stop_ret (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       sched_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_wakeup_new (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_switch (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_migrate_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_process_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_process_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_wait_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_process_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_process_fork (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_stat_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_stat_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_stat_iowait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_stat_runtime (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_pi_setprio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       regulator_enable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       regulator_enable_delay (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       regulator_enable_complete (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       regulator_disable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       regulator_disable_complete (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       regulator_set_voltage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       regulator_set_voltage_complete (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
        (type: noop)
       cpu_frequency (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       machine_suspend (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       power_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       power_frequency (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       power_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       clock_enable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       clock_disable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       clock_set_rate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       power_domain_target (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       net_dev_xmit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       net_dev_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       netif_receive_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       netif_rx (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       napi_poll (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       module_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       module_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       module_get (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       module_put (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       module_request (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kvm_userspace_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kvm_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kvm_msi_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kvm_ack_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kvm_mmio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kvm_fpu (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kvm_age_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kvm_try_async_get_page (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       kvm_async_pf_doublefault (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       kvm_async_pf_not_present (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       kvm_async_pf_ready (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kvm_async_pf_completed (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       kmalloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kmem_cache_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kmalloc_node (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kmem_cache_alloc_node (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kfree (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       kmem_cache_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       mm_page_free_direct (loglevel: TRACE_EMERG (0)) (type: tracepoint)
lttng: commands/list.c:253: print_events: Assertion `0' failed.
Aborted (core dumped)
-- 
This Communication is Confidential. We only send and receive email on 
the basis of the terms set out at www.ericsson.com/email_disclaimer

--------------020609050900020400090303
Content-Type: application/zip; name="core.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="core.zip"

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
zMtr68zLK5tqxJL5ueWlOaWl+cVF5TcXF9+Sn5NlvcNyR0ZGqj0lxZKUlmG3p6anzklfnpFm
UalKSEpJpRGkpqXOScywZKRkJCUkzUm2zrEmJydliNvyi+YX30aDtKYnp1jnWCwit6h4YU75
LTk/XJRflEudFJUtKi6MNF6RW3ZL+cLi+YsLc0qz7JV1y6saGysTql0rElbWO5qdVbYIZWJx
ac6iLCqtc4jCUvJeWLyoNKuxKctic9RmWZLmplhtzjolk2pbWZNlsdgaarOslrkpKbameqV8
js2hZ5Y71Kq5liSbXcrXNyr5JM43NWelpM21UqY6K8Uy15pCw1IySTbXXUom2VZPGStnmlyK
sdVW1aJ0kWz7fqKrslHJJ3G+enUgX9n442B55X81ci69icNAAM5P6WVvhbT0sV2kSJsS2qJS
gkiybfeCnMSYtHm4sUPTan/8Ogl4hopDERHfTMbjGdvxWAIB+vRzjTgjYJSCkayBPxMOrOmv
phiUDHejEfkKPweIobt9BhsJ+piGmkueaX5B+b8jpogF4hIxiSikVhSaI56A8BNiKAFfONvO
csMUBJasNIcZ18zDDJgh5sCSEc01sq+xDfKvGASeQxBis8efWsiQEY9q0BcbYJRahlPLBsjo
FfidolgLlFvGz4HPcQ9I2BSh5jepMa9QBxkwEZBymSHcgJtVGoH9JkF6zOCTpRpjwDqCnur3
WPMHiixC2dIM7EmNIs5rNDobxKAnREV80uwqiiuNqxTpsyTGnIDwSoD5GWJoXDCmuQTzd7KB
fmuCzIEFrzXXgq+2wt5mP7f9O8ssSmauSkpjKl5lwU0nETwlHw8kJ4yWptd9l32ybWn7321G
5ElXswL/bum5o/uD9UmoArSL58GeqWq2sNIiIqlZEilTKnLySoe/26b9yWjcq/KkNk/PLy+O
W8JWB4wMZ3xjB1Pf20ZdidIUa1JSk0VFvjJZXmS0J9Y0TdVmtSJVKvucyK4oqjp1M7ldOhNV
TkwqI7OOWXP1UKvh7obRdbBWd8y2FjUFdth2mCahuthaxtnuc3ujTVSAYStrEW600Ilax0hG
hcrPu/fd+W5OLRSaMX909gJiiTQFfatoHtEvJbk9Uqj6bUzt2a1F8+XI7gf+Te/KUJPi2L67
eP7GCDb/oEdkUX50YxhcBzM/WD6MZ8F84T49W2ogiNo6aV71RWHcOg+Hovbupn+m1qlxp+LD
4behBWqBdOENab7N4csQLFUqcp2InnrHlJc0IpKq1u7tzFYeO1/N9Kq07O3koqTw1H5R701a
q8YmhnMdeDqIhm3HWSjRalbjkIRCliSS3VMQh5XoDcj5o7t5nF2yY1Y1+0RETsPBKrz6eRb/
uhqQszgO1Tnsojt0XV0a6lDkufPxzPp3tFsWplr8giecHv1Qi2Hizaf2szU86XfP6yhYLJrj
4XaIrHbAWjejqeuNrUNeGkftGao9Mnbj0Zwbk5ykxlPzNLuLif+8t7L6T6SS66JM5IextPbX
cvcDGcOdOgfWo3HQtnn9B1BLAQIeAxQAAAAIACFCVkImVLj4WIUAAACgBgAEABgAAAAAAAAA
AACggQAAAABjb3JlVVQFAAPObydRdXgLAAEE6QMAAATpAwAAUEsFBgAAAAABAAEASgAAAJaF
AAAAAA==
--------------020609050900020400090303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--------------020609050900020400090303--
