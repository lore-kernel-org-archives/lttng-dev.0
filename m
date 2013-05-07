From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Core dump with LTTng Tools v2.1.1
Date: Mon, 6 May 2013 23:24:26 -0400
Message-ID: <20130507032426.GH24603__22146.312837913$1367897097$gmane$org@Krystal>
References: <5127746E.7080200@ericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UZYVw-0004rp-Br
	for lttng-dev@lists.lttng.org; Mon, 06 May 2013 23:24:28 -0400
Content-Disposition: inline
In-Reply-To: <5127746E.7080200@ericsson.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Bernd,

Is this still an issue with stable-2.1 branch and/or 2.2-rc releases ?

Thanks,

Mathieu

* Bernd Hufmann (Bernd.Hufmann@ericsson.com) wrote:
> Hello
>
> When executing the command "lttng list -k" and I get a core dump with  
> the output below. This happens not all the time, but when it happens I  
> have to kill the lttng-sessiond and restart the lttng-sessiond. I  
> attached the core dump.  Could someone of the LTTng team look into this?
>
> My computer has Ubuntu 12.04 with kernel 3.2.0-29. I've installed LTTng  
> modules v2.1.1, LTTng-UST v2.1.1 and userspace-rcu v0.7.6.
>
> Thanks
> Bernd
>
> lttng list -k
> Kernel events:
> -------------
>       mm_vmscan_kswapd_sleep (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       mm_vmscan_kswapd_wake (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       mm_vmscan_wakeup_kswapd (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       mm_vmscan_direct_reclaim_begin (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       mm_vmscan_memcg_reclaim_begin (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       mm_vmscan_memcg_softlimit_reclaim_begin (loglevel: TRACE_EMERG  
> (0)) (type: tracepoint)
>       mm_vmscan_direct_reclaim_end (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       mm_vmscan_memcg_reclaim_end (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       mm_vmscan_memcg_softlimit_reclaim_end (loglevel: TRACE_EMERG (0))  
> (type: tracepoint)
>       mm_shrink_slab_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       mm_shrink_slab_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       mm_vmscan_lru_isolate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       mm_vmscan_memcg_isolate (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       mm_vmscan_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       mm_vmscan_lru_shrink_inactive (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       replace_swap_token (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       put_swap_token (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       disable_swap_token (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       update_swap_token_priority (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       udp_fail_queue_rcv_skb (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       timer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_expire_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_expire_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       hrtimer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       hrtimer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       hrtimer_expire_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       hrtimer_expire_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       hrtimer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       itimer_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       itimer_expire (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       lttng_statedump_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       lttng_statedump_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       lttng_statedump_process_state (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       lttng_statedump_file_descriptor (loglevel: TRACE_EMERG (0)) (type: 
> tracepoint)
>       lttng_statedump_vm_map (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       lttng_statedump_network_interface (loglevel: TRACE_EMERG (0))  
> (type: tracepoint)
>       lttng_statedump_interrupt (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       sock_rcvqueue_full (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sock_exceed_buf_limit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kfree_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       consume_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       skb_copy_datagram_iovec (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       signal_generate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       signal_deliver (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       signal_overflow_fail (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       signal_lose_info (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       scsi_dispatch_cmd_start (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       scsi_dispatch_cmd_error (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       scsi_dispatch_cmd_done (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       scsi_dispatch_cmd_timeout (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       scsi_eh_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_kthread_stop (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_kthread_stop_ret (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       sched_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_wakeup_new (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_switch (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_migrate_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_process_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_process_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_wait_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_process_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_process_fork (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_stat_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_stat_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_stat_iowait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_stat_runtime (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_pi_setprio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regulator_enable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regulator_enable_delay (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       regulator_enable_complete (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       regulator_disable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regulator_disable_complete (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       regulator_set_voltage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regulator_set_voltage_complete (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>        (type: noop)
>       cpu_frequency (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       machine_suspend (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       power_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       power_frequency (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       power_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       clock_enable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       clock_disable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       clock_set_rate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       power_domain_target (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       net_dev_xmit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       net_dev_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       netif_receive_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       netif_rx (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       napi_poll (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       module_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       module_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       module_get (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       module_put (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       module_request (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_userspace_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_msi_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_ack_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_mmio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_fpu (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_age_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_try_async_get_page (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       kvm_async_pf_doublefault (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       kvm_async_pf_not_present (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       kvm_async_pf_ready (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_async_pf_completed (loglevel: TRACE_EMERG (0)) (type:  
> tracepoint)
>       kmalloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kmem_cache_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kmalloc_node (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kmem_cache_alloc_node (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kfree (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kmem_cache_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       mm_page_free_direct (loglevel: TRACE_EMERG (0)) (type: tracepoint)
> lttng: commands/list.c:253: print_events: Assertion `0' failed.
> Aborted (core dumped)
> -- 
> This Communication is Confidential. We only send and receive email on  
> the basis of the terms set out at www.ericsson.com/email_disclaimer


> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
