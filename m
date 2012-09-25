From: Hollis Blanchard <hollis_blanchard@mentor.com>
Subject: lttng list missing tracepoints?
Date: Tue, 25 Sep 2012 16:33:17 -0700
Message-ID: <50623F3D.7090908__44288.116406142$1348616039$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1710641156=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Hollis_Blanchard@mentor.com>) id 1TGed2-0000W2-Gk
	for lttng-dev@lists.lttng.org; Tue, 25 Sep 2012 19:33:24 -0400
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1TGecv-0006c8-VW from Hollis_Blanchard@mentor.com
	for lttng-dev@lists.lttng.org; Tue, 25 Sep 2012 16:33:18 -0700
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
Cc: Wade Farnsworth <wade_farnsworth@mentor.com>
List-Id: lttng-dev@lists.lttng.org

--===============1710641156==
Content-Type: multipart/alternative;
	boundary="------------050309020604080706090409"

--------------050309020604080706090409
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

I'm trying to use the net_dev_xmit tracepoint, but it's not showing up 
in my traces. It's not listed by 'lttng list -k', but it is present in 
debugfs/tracing/available_events. The reporting problem seems to be on 
the kernel side, because kernel_list_events() in lttng-sessiond also 
doesn't see any net events.

I'm suddenly thinking I must have I misunderstood something, because I 
see lttng-modules 2.0.2 contains its own tracepoint definitions (e.g. 
instrumentation/events/lttng-module/block.h), and indeed, only those 
events seem to be known to lttng. How can I get at all the other 
tracepoints which are already in the kernel? Is this "feature #6" in 
lttng-modules TODO file?

Thanks!



lttng list -k says:
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
       lttng_statedump_vm_map (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       lttng_statedump_network_interface (loglevel: TRACE_EMERG (0)) 
(type: tracepoint)
       lttng_statedump_interrupt (loglevel: TRACE_EMERG (0)) (type: 
tracepoint)
       signal_generate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       signal_deliver (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       signal_overflow_fail (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       signal_lose_info (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_kthread_stop (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       sched_kthread_stop_ret (loglevel: TRACE_EMERG (0)) (type: tracepoint)
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
       irq_handler_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       irq_handler_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       softirq_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       softirq_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       softirq_raise (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_rq_abort (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_rq_requeue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_rq_complete (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_rq_insert (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_rq_issue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_bio_bounce (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_bio_complete (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_bio_backmerge (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_bio_frontmerge (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_bio_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_getrq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_sleeprq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_plug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_unplug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_split (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_bio_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
       block_rq_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)

debugfs/tracing/available_events:

    btrfs:btrfs_transaction_commit
    btrfs:btrfs_inode_new
    btrfs:btrfs_inode_request
    btrfs:btrfs_inode_evict
    btrfs:btrfs_get_extent
    btrfs:btrfs_ordered_extent_add
    btrfs:btrfs_ordered_extent_remove
    btrfs:btrfs_ordered_extent_start
    btrfs:btrfs_ordered_extent_put
    btrfs:__extent_writepage
    btrfs:btrfs_writepage_end_io_hook
    btrfs:btrfs_sync_file
    btrfs:btrfs_sync_fs
    btrfs:btrfs_delayed_tree_ref
    btrfs:btrfs_delayed_data_ref
    btrfs:btrfs_delayed_ref_head
    btrfs:btrfs_chunk_alloc
    btrfs:btrfs_chunk_free
    btrfs:btrfs_cow_block
    btrfs:btrfs_reserved_extent_alloc
    btrfs:btrfs_reserved_extent_free
    mac80211:drv_return_void
    mac80211:drv_return_int
    mac80211:drv_return_bool
    mac80211:drv_return_u64
    mac80211:drv_start
    mac80211:drv_suspend
    mac80211:drv_resume
    mac80211:drv_stop
    mac80211:drv_add_interface
    mac80211:drv_change_interface
    mac80211:drv_remove_interface
    mac80211:drv_config
    mac80211:drv_bss_info_changed
    mac80211:drv_tx_sync
    mac80211:drv_finish_tx_sync
    mac80211:drv_prepare_multicast
    mac80211:drv_configure_filter
    mac80211:drv_set_tim
    mac80211:drv_set_key
    mac80211:drv_update_tkip_key
    mac80211:drv_hw_scan
    mac80211:drv_cancel_hw_scan
    mac80211:drv_sched_scan_start
    mac80211:drv_sched_scan_stop
    mac80211:drv_sw_scan_start
    mac80211:drv_sw_scan_complete
    mac80211:drv_get_stats
    mac80211:drv_get_tkip_seq
    mac80211:drv_set_frag_threshold
    mac80211:drv_set_rts_threshold
    mac80211:drv_set_coverage_class
    mac80211:drv_sta_notify
    mac80211:drv_sta_add
    mac80211:drv_sta_remove
    mac80211:drv_conf_tx
    mac80211:drv_get_tsf
    mac80211:drv_set_tsf
    mac80211:drv_reset_tsf
    mac80211:drv_tx_last_beacon
    mac80211:drv_ampdu_action
    mac80211:drv_get_survey
    mac80211:drv_flush
    mac80211:drv_channel_switch
    mac80211:drv_set_antenna
    mac80211:drv_get_antenna
    mac80211:drv_remain_on_channel
    mac80211:drv_cancel_remain_on_channel
    mac80211:drv_offchannel_tx
    mac80211:drv_set_ringparam
    mac80211:drv_get_ringparam
    mac80211:drv_tx_frames_pending
    mac80211:drv_offchannel_tx_cancel_wait
    mac80211:drv_set_bitrate_mask
    mac80211:drv_set_rekey_data
    mac80211:drv_rssi_callback
    mac80211:api_start_tx_ba_session
    mac80211:api_start_tx_ba_cb
    mac80211:api_stop_tx_ba_session
    mac80211:api_stop_tx_ba_cb
    mac80211:api_restart_hw
    mac80211:api_beacon_loss
    mac80211:api_connection_loss
    mac80211:api_cqm_rssi_notify
    mac80211:api_scan_completed
    mac80211:api_sched_scan_results
    mac80211:api_sched_scan_stopped
    mac80211:api_sta_block_awake
    mac80211:api_chswitch_done
    mac80211:api_ready_on_channel
    mac80211:api_remain_on_channel_expired
    mac80211:api_gtk_rekey_notify
    mac80211:api_enable_rssi_reports
    mac80211:wake_queue
    mac80211:stop_queue
    skb:kfree_skb
    skb:consume_skb
    skb:skb_copy_datagram_iovec
    net:net_dev_xmit
    net:net_dev_queue
    net:netif_receive_skb
    net:netif_rx
    napi:napi_poll
    sock:sock_rcvqueue_full
    sock:sock_exceed_buf_limit
    udp:udp_fail_queue_rcv_skb
    asoc:snd_soc_reg_write
    asoc:snd_soc_reg_read
    asoc:snd_soc_preg_write
    asoc:snd_soc_preg_read
    asoc:snd_soc_bias_level_start
    asoc:snd_soc_bias_level_done
    asoc:snd_soc_dapm_start
    asoc:snd_soc_dapm_done
    asoc:snd_soc_dapm_widget_power
    asoc:snd_soc_dapm_widget_event_start
    asoc:snd_soc_dapm_widget_event_done
    asoc:snd_soc_dapm_walk_done
    asoc:snd_soc_jack_irq
    asoc:snd_soc_jack_report
    asoc:snd_soc_jack_notify
    asoc:snd_soc_cache_sync
    scsi:scsi_dispatch_cmd_start
    scsi:scsi_dispatch_cmd_error
    scsi:scsi_dispatch_cmd_done
    scsi:scsi_dispatch_cmd_timeout
    scsi:scsi_eh_wakeup
    drm:drm_vblank_event
    drm:drm_vblank_event_queued
    drm:drm_vblank_event_delivered
    regulator:regulator_enable
    regulator:regulator_enable_delay
    regulator:regulator_enable_complete
    regulator:regulator_disable
    regulator:regulator_disable_complete
    regulator:regulator_set_voltage
    regulator:regulator_set_voltage_complete
    gpio:gpio_direction
    gpio:gpio_value
    block:block_rq_abort
    block:block_rq_requeue
    block:block_rq_complete
    block:block_rq_insert
    block:block_rq_issue
    block:block_bio_bounce
    block:block_bio_complete
    block:block_bio_backmerge
    block:block_bio_frontmerge
    block:block_bio_queue
    block:block_getrq
    block:block_sleeprq
    block:block_plug
    block:block_unplug
    block:block_split
    block:block_bio_remap
    block:block_rq_remap
    jbd2:jbd2_checkpoint
    jbd2:jbd2_start_commit
    jbd2:jbd2_commit_locking
    jbd2:jbd2_commit_flushing
    jbd2:jbd2_commit_logging
    jbd2:jbd2_end_commit
    jbd2:jbd2_submit_inode_data
    jbd2:jbd2_run_stats
    jbd2:jbd2_checkpoint_stats
    jbd2:jbd2_cleanup_journal_tail
    jbd:jbd_checkpoint
    jbd:jbd_start_commit
    jbd:jbd_commit_locking
    jbd:jbd_commit_flushing
    jbd:jbd_commit_logging
    jbd:jbd_drop_transaction
    jbd:jbd_end_commit
    jbd:jbd_do_submit_data
    jbd:jbd_cleanup_journal_tail
    jbd:jbd_update_superblock_end
    ext4:ext4_free_inode
    ext4:ext4_request_inode
    ext4:ext4_allocate_inode
    ext4:ext4_evict_inode
    ext4:ext4_drop_inode
    ext4:ext4_mark_inode_dirty
    ext4:ext4_begin_ordered_truncate
    ext4:ext4_write_begin
    ext4:ext4_da_write_begin
    ext4:ext4_ordered_write_end
    ext4:ext4_writeback_write_end
    ext4:ext4_journalled_write_end
    ext4:ext4_da_write_end
    ext4:ext4_da_writepages
    ext4:ext4_da_write_pages
    ext4:ext4_da_writepages_result
    ext4:ext4_writepage
    ext4:ext4_readpage
    ext4:ext4_releasepage
    ext4:ext4_invalidatepage
    ext4:ext4_discard_blocks
    ext4:ext4_mb_new_inode_pa
    ext4:ext4_mb_new_group_pa
    ext4:ext4_mb_release_inode_pa
    ext4:ext4_mb_release_group_pa
    ext4:ext4_discard_preallocations
    ext4:ext4_mb_discard_preallocations
    ext4:ext4_request_blocks
    ext4:ext4_allocate_blocks
    ext4:ext4_free_blocks
    ext4:ext4_sync_file_enter
    ext4:ext4_sync_file_exit
    ext4:ext4_sync_fs
    ext4:ext4_alloc_da_blocks
    ext4:ext4_mballoc_alloc
    ext4:ext4_mballoc_prealloc
    ext4:ext4_mballoc_discard
    ext4:ext4_mballoc_free
    ext4:ext4_forget
    ext4:ext4_da_update_reserve_space
    ext4:ext4_da_reserve_space
    ext4:ext4_da_release_space
    ext4:ext4_mb_bitmap_load
    ext4:ext4_mb_buddy_bitmap_load
    ext4:ext4_read_block_bitmap_load
    ext4:ext4_load_inode_bitmap
    ext4:ext4_direct_IO_enter
    ext4:ext4_direct_IO_exit
    ext4:ext4_fallocate_enter
    ext4:ext4_fallocate_exit
    ext4:ext4_unlink_enter
    ext4:ext4_unlink_exit
    ext4:ext4_truncate_enter
    ext4:ext4_truncate_exit
    ext4:ext4_ext_map_blocks_enter
    ext4:ext4_ind_map_blocks_enter
    ext4:ext4_ext_map_blocks_exit
    ext4:ext4_ind_map_blocks_exit
    ext4:ext4_ext_load_extent
    ext4:ext4_load_inode
    ext4:ext4_journal_start
    ext4:ext4_trim_extent
    ext4:ext4_trim_all_free
    ext3:ext3_free_inode
    ext3:ext3_request_inode
    ext3:ext3_allocate_inode
    ext3:ext3_evict_inode
    ext3:ext3_drop_inode
    ext3:ext3_mark_inode_dirty
    ext3:ext3_write_begin
    ext3:ext3_ordered_write_end
    ext3:ext3_writeback_write_end
    ext3:ext3_journalled_write_end
    ext3:ext3_ordered_writepage
    ext3:ext3_writeback_writepage
    ext3:ext3_journalled_writepage
    ext3:ext3_readpage
    ext3:ext3_releasepage
    ext3:ext3_invalidatepage
    ext3:ext3_discard_blocks
    ext3:ext3_request_blocks
    ext3:ext3_allocate_blocks
    ext3:ext3_free_blocks
    ext3:ext3_sync_file_enter
    ext3:ext3_sync_file_exit
    ext3:ext3_sync_fs
    ext3:ext3_rsv_window_add
    ext3:ext3_discard_reservation
    ext3:ext3_alloc_new_reservation
    ext3:ext3_reserved
    ext3:ext3_forget
    ext3:ext3_read_block_bitmap
    ext3:ext3_direct_IO_enter
    ext3:ext3_direct_IO_exit
    ext3:ext3_unlink_enter
    ext3:ext3_unlink_exit
    ext3:ext3_truncate_enter
    ext3:ext3_truncate_exit
    ext3:ext3_get_blocks_enter
    ext3:ext3_get_blocks_exit
    ext3:ext3_load_inode
    writeback:writeback_nothread
    writeback:writeback_queue
    writeback:writeback_exec
    writeback:writeback_start
    writeback:writeback_written
    writeback:writeback_wait
    writeback:writeback_pages_written
    writeback:writeback_nowork
    writeback:writeback_wake_background
    writeback:writeback_wake_thread
    writeback:writeback_wake_forker_thread
    writeback:writeback_bdi_register
    writeback:writeback_bdi_unregister
    writeback:writeback_thread_start
    writeback:writeback_thread_stop
    writeback:balance_dirty_start
    writeback:balance_dirty_wait
    writeback:balance_dirty_written
    writeback:wbc_writepage
    writeback:writeback_queue_io
    writeback:global_dirty_state
    writeback:writeback_congestion_wait
    writeback:writeback_wait_iff_congested
    writeback:writeback_single_inode_requeue
    writeback:writeback_single_inode
    kmem:kmalloc
    kmem:kmem_cache_alloc
    kmem:kmalloc_node
    kmem:kmem_cache_alloc_node
    kmem:kfree
    kmem:kmem_cache_free
    kmem:mm_page_free_direct
    kmem:mm_pagevec_free
    kmem:mm_page_alloc
    kmem:mm_page_alloc_zone_locked
    kmem:mm_page_pcpu_drain
    kmem:mm_page_alloc_extfrag
    vmscan:mm_vmscan_kswapd_sleep
    vmscan:mm_vmscan_kswapd_wake
    vmscan:mm_vmscan_wakeup_kswapd
    vmscan:mm_vmscan_direct_reclaim_begin
    vmscan:mm_vmscan_memcg_reclaim_begin
    vmscan:mm_vmscan_memcg_softlimit_reclaim_begin
    vmscan:mm_vmscan_direct_reclaim_end
    vmscan:mm_vmscan_memcg_reclaim_end
    vmscan:mm_vmscan_memcg_softlimit_reclaim_end
    vmscan:mm_shrink_slab_start
    vmscan:mm_shrink_slab_end
    vmscan:mm_vmscan_lru_isolate
    vmscan:mm_vmscan_memcg_isolate
    vmscan:mm_vmscan_writepage
    vmscan:mm_vmscan_lru_shrink_inactive
    vmscan:replace_swap_token
    vmscan:put_swap_token
    vmscan:disable_swap_token
    vmscan:update_swap_token_priority
    power:cpu_idle
    power:cpu_frequency
    power:machine_suspend
    power:power_start
    power:power_frequency
    power:power_end
    power:clock_enable
    power:clock_disable
    power:clock_set_rate
    power:power_domain_target
    module:module_load
    module:module_free
    module:module_get
    module:module_put
    module:module_request
    workqueue:workqueue_queue_work
    workqueue:workqueue_activate_work
    workqueue:workqueue_execute_start
    workqueue:workqueue_execute_end
    signal:signal_generate
    signal:signal_deliver
    signal:signal_overflow_fail
    signal:signal_lose_info
    timer:timer_init
    timer:timer_start
    timer:timer_expire_entry
    timer:timer_expire_exit
    timer:timer_cancel
    timer:hrtimer_init
    timer:hrtimer_start
    timer:hrtimer_expire_entry
    timer:hrtimer_expire_exit
    timer:hrtimer_cancel
    timer:itimer_state
    timer:itimer_expire
    irq:irq_handler_entry
    irq:irq_handler_exit
    irq:softirq_entry
    irq:softirq_exit
    irq:softirq_raise
    sched:sched_kthread_stop
    sched:sched_kthread_stop_ret
    sched:sched_wakeup
    sched:sched_wakeup_new
    sched:sched_switch
    sched:sched_migrate_task
    sched:sched_process_free
    sched:sched_process_exit
    sched:sched_wait_task
    sched:sched_process_wait
    sched:sched_process_fork
    sched:sched_stat_wait
    sched:sched_stat_sleep
    sched:sched_stat_iowait
    sched:sched_stat_runtime
    sched:sched_pi_setprio


-- 
Hollis Blanchard
Product Owner, Sourcery Analyzer <http://go.mentor.com/sourceryanalyzer>
Mentor Graphics, Embedded Systems Division


--------------050309020604080706090409
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    I'm trying to use the net_dev_xmit tracepoint, but it's not showing
    up in my traces. It's not listed by 'lttng list -k', but it is
    present in debugfs/tracing/available_events. The reporting problem
    seems to be on the kernel side, because kernel_list_events() in
    lttng-sessiond also doesn't see any net events.<br>
    <br>
    I'm suddenly thinking I must have I misunderstood something, because
    I see lttng-modules 2.0.2 contains its own tracepoint definitions
    (e.g. instrumentation/events/lttng-module/block.h), and indeed, only
    those events seem to be known to lttng. How can I get at all the
    other tracepoints which are already in the kernel? Is this "feature
    #6" in lttng-modules TODO file?<br>
    <br>
    Thanks!<br>
    <br>
    <br>
    <br>
    lttng list -k says:<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timer_expire_entry (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timer_expire_exit (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; timer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_expire_entry (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_expire_exit (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hrtimer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; itimer_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; itimer_expire (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lttng_statedump_start (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lttng_statedump_end (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lttng_statedump_process_state (loglevel: TRACE_EMERG (0))
    (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lttng_statedump_file_descriptor (loglevel: TRACE_EMERG (0))
    (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lttng_statedump_vm_map (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lttng_statedump_network_interface (loglevel: TRACE_EMERG (0))
    (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; lttng_statedump_interrupt (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal_generate (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal_deliver (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal_overflow_fail (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; signal_lose_info (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_kthread_stop (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_kthread_stop_ret (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_wakeup_new (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_switch (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_migrate_task (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_process_free (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_process_exit (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_wait_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_process_wait (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_process_fork (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_stat_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_stat_sleep (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_stat_iowait (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_stat_runtime (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; sched_pi_setprio (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq_handler_entry (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; irq_handler_exit (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; softirq_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; softirq_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; softirq_raise (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_rq_abort (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_rq_requeue (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_rq_complete (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_rq_insert (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_rq_issue (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_bio_bounce (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_bio_complete (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_bio_backmerge (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_bio_frontmerge (loglevel: TRACE_EMERG (0)) (type:
    tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_bio_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_getrq (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_sleeprq (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_plug (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_unplug (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_split (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_bio_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; block_rq_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
    <br>
    debugfs/tracing/available_events:<br>
    <blockquote>btrfs:btrfs_transaction_commit<br>
      btrfs:btrfs_inode_new<br>
      btrfs:btrfs_inode_request<br>
      btrfs:btrfs_inode_evict<br>
      btrfs:btrfs_get_extent<br>
      btrfs:btrfs_ordered_extent_add<br>
      btrfs:btrfs_ordered_extent_remove<br>
      btrfs:btrfs_ordered_extent_start<br>
      btrfs:btrfs_ordered_extent_put<br>
      btrfs:__extent_writepage<br>
      btrfs:btrfs_writepage_end_io_hook<br>
      btrfs:btrfs_sync_file<br>
      btrfs:btrfs_sync_fs<br>
      btrfs:btrfs_delayed_tree_ref<br>
      btrfs:btrfs_delayed_data_ref<br>
      btrfs:btrfs_delayed_ref_head<br>
      btrfs:btrfs_chunk_alloc<br>
      btrfs:btrfs_chunk_free<br>
      btrfs:btrfs_cow_block<br>
      btrfs:btrfs_reserved_extent_alloc<br>
      btrfs:btrfs_reserved_extent_free<br>
      mac80211:drv_return_void<br>
      mac80211:drv_return_int<br>
      mac80211:drv_return_bool<br>
      mac80211:drv_return_u64<br>
      mac80211:drv_start<br>
      mac80211:drv_suspend<br>
      mac80211:drv_resume<br>
      mac80211:drv_stop<br>
      mac80211:drv_add_interface<br>
      mac80211:drv_change_interface<br>
      mac80211:drv_remove_interface<br>
      mac80211:drv_config<br>
      mac80211:drv_bss_info_changed<br>
      mac80211:drv_tx_sync<br>
      mac80211:drv_finish_tx_sync<br>
      mac80211:drv_prepare_multicast<br>
      mac80211:drv_configure_filter<br>
      mac80211:drv_set_tim<br>
      mac80211:drv_set_key<br>
      mac80211:drv_update_tkip_key<br>
      mac80211:drv_hw_scan<br>
      mac80211:drv_cancel_hw_scan<br>
      mac80211:drv_sched_scan_start<br>
      mac80211:drv_sched_scan_stop<br>
      mac80211:drv_sw_scan_start<br>
      mac80211:drv_sw_scan_complete<br>
      mac80211:drv_get_stats<br>
      mac80211:drv_get_tkip_seq<br>
      mac80211:drv_set_frag_threshold<br>
      mac80211:drv_set_rts_threshold<br>
      mac80211:drv_set_coverage_class<br>
      mac80211:drv_sta_notify<br>
      mac80211:drv_sta_add<br>
      mac80211:drv_sta_remove<br>
      mac80211:drv_conf_tx<br>
      mac80211:drv_get_tsf<br>
      mac80211:drv_set_tsf<br>
      mac80211:drv_reset_tsf<br>
      mac80211:drv_tx_last_beacon<br>
      mac80211:drv_ampdu_action<br>
      mac80211:drv_get_survey<br>
      mac80211:drv_flush<br>
      mac80211:drv_channel_switch<br>
      mac80211:drv_set_antenna<br>
      mac80211:drv_get_antenna<br>
      mac80211:drv_remain_on_channel<br>
      mac80211:drv_cancel_remain_on_channel<br>
      mac80211:drv_offchannel_tx<br>
      mac80211:drv_set_ringparam<br>
      mac80211:drv_get_ringparam<br>
      mac80211:drv_tx_frames_pending<br>
      mac80211:drv_offchannel_tx_cancel_wait<br>
      mac80211:drv_set_bitrate_mask<br>
      mac80211:drv_set_rekey_data<br>
      mac80211:drv_rssi_callback<br>
      mac80211:api_start_tx_ba_session<br>
      mac80211:api_start_tx_ba_cb<br>
      mac80211:api_stop_tx_ba_session<br>
      mac80211:api_stop_tx_ba_cb<br>
      mac80211:api_restart_hw<br>
      mac80211:api_beacon_loss<br>
      mac80211:api_connection_loss<br>
      mac80211:api_cqm_rssi_notify<br>
      mac80211:api_scan_completed<br>
      mac80211:api_sched_scan_results<br>
      mac80211:api_sched_scan_stopped<br>
      mac80211:api_sta_block_awake<br>
      mac80211:api_chswitch_done<br>
      mac80211:api_ready_on_channel<br>
      mac80211:api_remain_on_channel_expired<br>
      mac80211:api_gtk_rekey_notify<br>
      mac80211:api_enable_rssi_reports<br>
      mac80211:wake_queue<br>
      mac80211:stop_queue<br>
      skb:kfree_skb<br>
      skb:consume_skb<br>
      skb:skb_copy_datagram_iovec<br>
      <a class="moz-txt-link-freetext" href="net:net_dev_xmit">net:net_dev_xmit</a><br>
      <a class="moz-txt-link-freetext" href="net:net_dev_queue">net:net_dev_queue</a><br>
      <a class="moz-txt-link-freetext" href="net:netif_receive_skb">net:netif_receive_skb</a><br>
      <a class="moz-txt-link-freetext" href="net:netif_rx">net:netif_rx</a><br>
      napi:napi_poll<br>
      sock:sock_rcvqueue_full<br>
      sock:sock_exceed_buf_limit<br>
      udp:udp_fail_queue_rcv_skb<br>
      asoc:snd_soc_reg_write<br>
      asoc:snd_soc_reg_read<br>
      asoc:snd_soc_preg_write<br>
      asoc:snd_soc_preg_read<br>
      asoc:snd_soc_bias_level_start<br>
      asoc:snd_soc_bias_level_done<br>
      asoc:snd_soc_dapm_start<br>
      asoc:snd_soc_dapm_done<br>
      asoc:snd_soc_dapm_widget_power<br>
      asoc:snd_soc_dapm_widget_event_start<br>
      asoc:snd_soc_dapm_widget_event_done<br>
      asoc:snd_soc_dapm_walk_done<br>
      asoc:snd_soc_jack_irq<br>
      asoc:snd_soc_jack_report<br>
      asoc:snd_soc_jack_notify<br>
      asoc:snd_soc_cache_sync<br>
      scsi:scsi_dispatch_cmd_start<br>
      scsi:scsi_dispatch_cmd_error<br>
      scsi:scsi_dispatch_cmd_done<br>
      scsi:scsi_dispatch_cmd_timeout<br>
      scsi:scsi_eh_wakeup<br>
      drm:drm_vblank_event<br>
      drm:drm_vblank_event_queued<br>
      drm:drm_vblank_event_delivered<br>
      regulator:regulator_enable<br>
      regulator:regulator_enable_delay<br>
      regulator:regulator_enable_complete<br>
      regulator:regulator_disable<br>
      regulator:regulator_disable_complete<br>
      regulator:regulator_set_voltage<br>
      regulator:regulator_set_voltage_complete<br>
      gpio:gpio_direction<br>
      gpio:gpio_value<br>
      block:block_rq_abort<br>
      block:block_rq_requeue<br>
      block:block_rq_complete<br>
      block:block_rq_insert<br>
      block:block_rq_issue<br>
      block:block_bio_bounce<br>
      block:block_bio_complete<br>
      block:block_bio_backmerge<br>
      block:block_bio_frontmerge<br>
      block:block_bio_queue<br>
      block:block_getrq<br>
      block:block_sleeprq<br>
      block:block_plug<br>
      block:block_unplug<br>
      block:block_split<br>
      block:block_bio_remap<br>
      block:block_rq_remap<br>
      jbd2:jbd2_checkpoint<br>
      jbd2:jbd2_start_commit<br>
      jbd2:jbd2_commit_locking<br>
      jbd2:jbd2_commit_flushing<br>
      jbd2:jbd2_commit_logging<br>
      jbd2:jbd2_end_commit<br>
      jbd2:jbd2_submit_inode_data<br>
      jbd2:jbd2_run_stats<br>
      jbd2:jbd2_checkpoint_stats<br>
      jbd2:jbd2_cleanup_journal_tail<br>
      jbd:jbd_checkpoint<br>
      jbd:jbd_start_commit<br>
      jbd:jbd_commit_locking<br>
      jbd:jbd_commit_flushing<br>
      jbd:jbd_commit_logging<br>
      jbd:jbd_drop_transaction<br>
      jbd:jbd_end_commit<br>
      jbd:jbd_do_submit_data<br>
      jbd:jbd_cleanup_journal_tail<br>
      jbd:jbd_update_superblock_end<br>
      ext4:ext4_free_inode<br>
      ext4:ext4_request_inode<br>
      ext4:ext4_allocate_inode<br>
      ext4:ext4_evict_inode<br>
      ext4:ext4_drop_inode<br>
      ext4:ext4_mark_inode_dirty<br>
      ext4:ext4_begin_ordered_truncate<br>
      ext4:ext4_write_begin<br>
      ext4:ext4_da_write_begin<br>
      ext4:ext4_ordered_write_end<br>
      ext4:ext4_writeback_write_end<br>
      ext4:ext4_journalled_write_end<br>
      ext4:ext4_da_write_end<br>
      ext4:ext4_da_writepages<br>
      ext4:ext4_da_write_pages<br>
      ext4:ext4_da_writepages_result<br>
      ext4:ext4_writepage<br>
      ext4:ext4_readpage<br>
      ext4:ext4_releasepage<br>
      ext4:ext4_invalidatepage<br>
      ext4:ext4_discard_blocks<br>
      ext4:ext4_mb_new_inode_pa<br>
      ext4:ext4_mb_new_group_pa<br>
      ext4:ext4_mb_release_inode_pa<br>
      ext4:ext4_mb_release_group_pa<br>
      ext4:ext4_discard_preallocations<br>
      ext4:ext4_mb_discard_preallocations<br>
      ext4:ext4_request_blocks<br>
      ext4:ext4_allocate_blocks<br>
      ext4:ext4_free_blocks<br>
      ext4:ext4_sync_file_enter<br>
      ext4:ext4_sync_file_exit<br>
      ext4:ext4_sync_fs<br>
      ext4:ext4_alloc_da_blocks<br>
      ext4:ext4_mballoc_alloc<br>
      ext4:ext4_mballoc_prealloc<br>
      ext4:ext4_mballoc_discard<br>
      ext4:ext4_mballoc_free<br>
      ext4:ext4_forget<br>
      ext4:ext4_da_update_reserve_space<br>
      ext4:ext4_da_reserve_space<br>
      ext4:ext4_da_release_space<br>
      ext4:ext4_mb_bitmap_load<br>
      ext4:ext4_mb_buddy_bitmap_load<br>
      ext4:ext4_read_block_bitmap_load<br>
      ext4:ext4_load_inode_bitmap<br>
      ext4:ext4_direct_IO_enter<br>
      ext4:ext4_direct_IO_exit<br>
      ext4:ext4_fallocate_enter<br>
      ext4:ext4_fallocate_exit<br>
      ext4:ext4_unlink_enter<br>
      ext4:ext4_unlink_exit<br>
      ext4:ext4_truncate_enter<br>
      ext4:ext4_truncate_exit<br>
      ext4:ext4_ext_map_blocks_enter<br>
      ext4:ext4_ind_map_blocks_enter<br>
      ext4:ext4_ext_map_blocks_exit<br>
      ext4:ext4_ind_map_blocks_exit<br>
      ext4:ext4_ext_load_extent<br>
      ext4:ext4_load_inode<br>
      ext4:ext4_journal_start<br>
      ext4:ext4_trim_extent<br>
      ext4:ext4_trim_all_free<br>
      ext3:ext3_free_inode<br>
      ext3:ext3_request_inode<br>
      ext3:ext3_allocate_inode<br>
      ext3:ext3_evict_inode<br>
      ext3:ext3_drop_inode<br>
      ext3:ext3_mark_inode_dirty<br>
      ext3:ext3_write_begin<br>
      ext3:ext3_ordered_write_end<br>
      ext3:ext3_writeback_write_end<br>
      ext3:ext3_journalled_write_end<br>
      ext3:ext3_ordered_writepage<br>
      ext3:ext3_writeback_writepage<br>
      ext3:ext3_journalled_writepage<br>
      ext3:ext3_readpage<br>
      ext3:ext3_releasepage<br>
      ext3:ext3_invalidatepage<br>
      ext3:ext3_discard_blocks<br>
      ext3:ext3_request_blocks<br>
      ext3:ext3_allocate_blocks<br>
      ext3:ext3_free_blocks<br>
      ext3:ext3_sync_file_enter<br>
      ext3:ext3_sync_file_exit<br>
      ext3:ext3_sync_fs<br>
      ext3:ext3_rsv_window_add<br>
      ext3:ext3_discard_reservation<br>
      ext3:ext3_alloc_new_reservation<br>
      ext3:ext3_reserved<br>
      ext3:ext3_forget<br>
      ext3:ext3_read_block_bitmap<br>
      ext3:ext3_direct_IO_enter<br>
      ext3:ext3_direct_IO_exit<br>
      ext3:ext3_unlink_enter<br>
      ext3:ext3_unlink_exit<br>
      ext3:ext3_truncate_enter<br>
      ext3:ext3_truncate_exit<br>
      ext3:ext3_get_blocks_enter<br>
      ext3:ext3_get_blocks_exit<br>
      ext3:ext3_load_inode<br>
      writeback:writeback_nothread<br>
      writeback:writeback_queue<br>
      writeback:writeback_exec<br>
      writeback:writeback_start<br>
      writeback:writeback_written<br>
      writeback:writeback_wait<br>
      writeback:writeback_pages_written<br>
      writeback:writeback_nowork<br>
      writeback:writeback_wake_background<br>
      writeback:writeback_wake_thread<br>
      writeback:writeback_wake_forker_thread<br>
      writeback:writeback_bdi_register<br>
      writeback:writeback_bdi_unregister<br>
      writeback:writeback_thread_start<br>
      writeback:writeback_thread_stop<br>
      writeback:balance_dirty_start<br>
      writeback:balance_dirty_wait<br>
      writeback:balance_dirty_written<br>
      writeback:wbc_writepage<br>
      writeback:writeback_queue_io<br>
      writeback:global_dirty_state<br>
      writeback:writeback_congestion_wait<br>
      writeback:writeback_wait_iff_congested<br>
      writeback:writeback_single_inode_requeue<br>
      writeback:writeback_single_inode<br>
      kmem:kmalloc<br>
      kmem:kmem_cache_alloc<br>
      kmem:kmalloc_node<br>
      kmem:kmem_cache_alloc_node<br>
      kmem:kfree<br>
      kmem:kmem_cache_free<br>
      kmem:mm_page_free_direct<br>
      kmem:mm_pagevec_free<br>
      kmem:mm_page_alloc<br>
      kmem:mm_page_alloc_zone_locked<br>
      kmem:mm_page_pcpu_drain<br>
      kmem:mm_page_alloc_extfrag<br>
      vmscan:mm_vmscan_kswapd_sleep<br>
      vmscan:mm_vmscan_kswapd_wake<br>
      vmscan:mm_vmscan_wakeup_kswapd<br>
      vmscan:mm_vmscan_direct_reclaim_begin<br>
      vmscan:mm_vmscan_memcg_reclaim_begin<br>
      vmscan:mm_vmscan_memcg_softlimit_reclaim_begin<br>
      vmscan:mm_vmscan_direct_reclaim_end<br>
      vmscan:mm_vmscan_memcg_reclaim_end<br>
      vmscan:mm_vmscan_memcg_softlimit_reclaim_end<br>
      vmscan:mm_shrink_slab_start<br>
      vmscan:mm_shrink_slab_end<br>
      vmscan:mm_vmscan_lru_isolate<br>
      vmscan:mm_vmscan_memcg_isolate<br>
      vmscan:mm_vmscan_writepage<br>
      vmscan:mm_vmscan_lru_shrink_inactive<br>
      vmscan:replace_swap_token<br>
      vmscan:put_swap_token<br>
      vmscan:disable_swap_token<br>
      vmscan:update_swap_token_priority<br>
      power:cpu_idle<br>
      power:cpu_frequency<br>
      power:machine_suspend<br>
      power:power_start<br>
      power:power_frequency<br>
      power:power_end<br>
      power:clock_enable<br>
      power:clock_disable<br>
      power:clock_set_rate<br>
      power:power_domain_target<br>
      module:module_load<br>
      module:module_free<br>
      module:module_get<br>
      module:module_put<br>
      module:module_request<br>
      workqueue:workqueue_queue_work<br>
      workqueue:workqueue_activate_work<br>
      workqueue:workqueue_execute_start<br>
      workqueue:workqueue_execute_end<br>
      signal:signal_generate<br>
      signal:signal_deliver<br>
      signal:signal_overflow_fail<br>
      signal:signal_lose_info<br>
      timer:timer_init<br>
      timer:timer_start<br>
      timer:timer_expire_entry<br>
      timer:timer_expire_exit<br>
      timer:timer_cancel<br>
      timer:hrtimer_init<br>
      timer:hrtimer_start<br>
      timer:hrtimer_expire_entry<br>
      timer:hrtimer_expire_exit<br>
      timer:hrtimer_cancel<br>
      timer:itimer_state<br>
      timer:itimer_expire<br>
      irq:irq_handler_entry<br>
      irq:irq_handler_exit<br>
      irq:softirq_entry<br>
      irq:softirq_exit<br>
      irq:softirq_raise<br>
      sched:sched_kthread_stop<br>
      sched:sched_kthread_stop_ret<br>
      sched:sched_wakeup<br>
      sched:sched_wakeup_new<br>
      sched:sched_switch<br>
      sched:sched_migrate_task<br>
      sched:sched_process_free<br>
      sched:sched_process_exit<br>
      sched:sched_wait_task<br>
      sched:sched_process_wait<br>
      sched:sched_process_fork<br>
      sched:sched_stat_wait<br>
      sched:sched_stat_sleep<br>
      sched:sched_stat_iowait<br>
      sched:sched_stat_runtime<br>
      sched:sched_pi_setprio<br>
    </blockquote>
    <br>
    <div class="moz-signature">-- <br>
      Hollis Blanchard<br>
      Product Owner, <a href="http://go.mentor.com/sourceryanalyzer">Sourcery
        Analyzer</a><br>
      Mentor Graphics, Embedded Systems Division<br>
      <br>
    </div>
  </body>
</html>

--------------050309020604080706090409--


--===============1710641156==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1710641156==--
