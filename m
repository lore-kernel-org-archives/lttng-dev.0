Return-Path: <lttng-dev-bounces@lists.lttng.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82815CD8CA4
	for <lttng-dev@archiver.kernel.org>; Tue, 10 Oct 2023 15:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1696950831;
	bh=rYuF9fyiAt60gkKJLNajubSynp5iY6AZw2TRoa3gAik=;
	h=Date:To:Subject:List-Id:List-Unsubscribe:List-Archive:List-Post:
	 List-Help:List-Subscribe:From:Reply-To:From;
	b=IIrQHO+ugNeHW0bgsF+UY3kuExoUZAN+Za+Ku36MjvNU0RS6Rh6bSpxZdIlp42RqE
	 pozb+mVqo+cOKve1w+hVxv0TMn+ZVmOZpe8eO/AElY8/9lpm035lpB17p8uV/riLV0
	 QpcosiRfAhWyqa0wqHay92E7TQiEv0Y+LoE+Hlh7I47RYTkqfE3OlYgNtCrsN5Qxyt
	 HMYtp4G9tzPCsOHEZjmdRzOT7Y4CWnNY5x4pcH/9C1S2rB7xj1onqS/IYpv7tfjRh8
	 1ylEagu8VOKOa4WgfVQjntXuMHauZT8Vd1B8/ynaGR/rkX8i/4ey6JSL5drKxY/caj
	 YnVeE4mSnfoVA==
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4S4fYp5dNGz2wDb;
	Tue, 10 Oct 2023 11:13:50 -0400 (EDT)
Received: from mail-ot1-x362.google.com (mail-ot1-x362.google.com
 [IPv6:2607:f8b0:4864:20::362])
 by lists.lttng.org (Postfix) with ESMTPS id 4S2RV54zsPz2tTR
 for <lttng-dev@lists.lttng.org>; Fri,  6 Oct 2023 20:47:56 -0400 (EDT)
Received: by mail-ot1-x362.google.com with SMTP id
 46e09a7af769-6c6504c9ac5so1795742a34.0
 for <lttng-dev@lists.lttng.org>; Fri, 06 Oct 2023 17:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696639675; x=1697244475;
 h=content-disposition:mime-version:message-id:subject:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sMAWIIKgmyOta+qey8TPNgQuJeho+VFLAI/XK7OTl9s=;
 b=rMrDyRR+bWEa7OG5E9jENFE5hYeCh/bGerRikLGxqeutqjg6D9kJfUuBvpi1AQblob
 sdsQ7ESTX/ZYrWb6FhIpwj5axnLzdeGUuS0UVPSApxhNxgm0tQW2J4XKyhOtq0RQ0Qq6
 t6PQo8HRxD5KSpKQ0B21z6QkMfMJaUVq4D0TjdE7rdC9vxyoefV6K0ADCNfHzkZhMGWC
 ByBFaAUK/bIAveyix2D5hG8kI+0pjBNwPqlaEX6xf/INPip7CvFbGtumahnJ38/idmPK
 LkzhneECPlxenjN70qSROthgq31NEZBpOszFG/JIz5sfBkGHBzCYkjUrTKGqJUsEkG1u
 Cbtg==
X-Gm-Message-State: AOJu0Yyl8wwqIzdc50e6rnyQiEBqD69pmU4jb5zY/CbIPtfvzImPr1FK
 XVbynhoq2DFh0D8G9aArXSiSPhMVU/CMpo0+BUle9OCrNTXOBRl0JOfy72YPSrFH6vJ1XJOhv1T
 smVzcymNfw3MC0MkMKoX7Rzhb34hTqEcN8jWufr3bBGGASvjdbe8UD4B+sqRYJzrStO/c3PzSe+
 5tnAvnPVUX0atjcIoX7BFKGFeOG98=
X-Google-Smtp-Source: AGHT+IGLr1Erzx+XZk0FGi5RSmXBCIaDhlGRJI2aAJ3UssTyCmrYN5ydQ5hVY0MUNj8ddGJrFWTDZrx3udMd
X-Received: by 2002:a9d:4d83:0:b0:6bc:d519:d7b3 with SMTP id
 u3-20020a9d4d83000000b006bcd519d7b3mr9148177otk.37.1696639675407; 
 Fri, 06 Oct 2023 17:47:55 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([208.88.159.128])
 by smtp-relay.gmail.com with ESMTPS id
 e25-20020a637459000000b005859bd29c66sm298905pgn.4.2023.10.06.17.47.54
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 17:47:55 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com
 (dev-ushankar.dev.purestorage.com [10.7.70.36])
 by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 750D43401BC
 for <lttng-dev@lists.lttng.org>; Fri,  6 Oct 2023 18:47:54 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
 id 676F9E4066A; Fri,  6 Oct 2023 18:47:53 -0600 (MDT)
Date: Fri, 6 Oct 2023 18:47:53 -0600
To: lttng-dev@lists.lttng.org
Message-ID: <ZSCquVcm4WZdOP6Z@dev-ushankar.dev.purestorage.com>
MIME-Version: 1.0
Content-Disposition: inline
X-Mailman-Approved-At: Tue, 10 Oct 2023 11:13:49 -0400
Subject: [lttng-dev] lttng list -k is missing tracepoints
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Uday Shankar via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Uday Shankar <ushankar@purestorage.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

Hi,

I'm trying to use LTTNG to trace io_uring tracepoints, of which there
are many in the 6.5.4 kernel I am running:

# grep io_uring /sys/kernel/tracing/available_events
syscalls:sys_exit_io_uring_register
syscalls:sys_enter_io_uring_register
syscalls:sys_exit_io_uring_setup
syscalls:sys_enter_io_uring_setup
syscalls:sys_exit_io_uring_enter
syscalls:sys_enter_io_uring_enter
io_uring:io_uring_local_work_run
io_uring:io_uring_short_write
io_uring:io_uring_task_work_run
io_uring:io_uring_cqe_overflow
io_uring:io_uring_req_failed
io_uring:io_uring_task_add
io_uring:io_uring_poll_arm
io_uring:io_uring_submit_req
io_uring:io_uring_complete
io_uring:io_uring_fail_link
io_uring:io_uring_cqring_wait
io_uring:io_uring_link
io_uring:io_uring_defer
io_uring:io_uring_queue_async_work
io_uring:io_uring_file_get
io_uring:io_uring_register
io_uring:io_uring_create

However, lttng list -k does not show any of these tracepoints. I'm using
an lttng-modules built from the repo which I cloned earlier today:

$ modinfo lttng-wrapper | grep extra_version_git
extra_version_git:  v2.13.0-rc1-316-ga62977ca

(lttng-tools and lttng-ust are older; whatever version came with my
distro, but I don't think that should matter). Am I missing something?

Here's the full output of lttng list -k, in case it's helpful:

Kernel events:
-------------
      lttng_logger (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      compaction_isolate_migratepages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      compaction_isolate_freepages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      compaction_migratepages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_bias_level_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_bias_level_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_dapm_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_dapm_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_dapm_widget_power (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_dapm_widget_event_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_dapm_widget_event_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_dapm_walk_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_dapm_path (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_dapm_connected (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_jack_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_jack_report (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      asoc_snd_soc_jack_notify (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      gpio_direction (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      gpio_value (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_touch_buffer (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_dirty_buffer (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_rq_requeue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_rq_complete (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_rq_insert (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_rq_issue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_rq_merge (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_bio_complete (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_bio_bounce (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_bio_backmerge (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_bio_frontmerge (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_bio_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_getrq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_plug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_unplug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_split (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_bio_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      block_rq_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_free_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_request_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_allocate_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_evict_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_drop_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mark_inode_dirty (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_begin_ordered_truncate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_write_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_da_write_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ordered_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_writeback_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_journalled_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_da_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_da_writepages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_da_write_pages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_da_write_pages_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_da_writepages_result (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_readpage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_releasepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_invalidatepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_journalled_invalidatepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_discard_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mb_new_inode_pa (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mb_new_group_pa (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mb_release_inode_pa (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mb_release_group_pa (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_discard_preallocations (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mb_discard_preallocations (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_request_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_allocate_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_free_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_sync_file_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_sync_file_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_sync_fs (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_alloc_da_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mballoc_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mballoc_prealloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mballoc_discard (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mballoc_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_forget (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_da_update_reserve_space (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_da_reserve_space (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_da_release_space (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mb_bitmap_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_mb_buddy_bitmap_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_read_block_bitmap_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_load_inode_bitmap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_direct_IO_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_direct_IO_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_fallocate_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_fallocate_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_punch_hole (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_zero_range (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_unlink_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_unlink_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_truncate_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_truncate_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_convert_to_initialized_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_convert_to_initialized_fastpath (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_map_blocks_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ind_map_blocks_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_map_blocks_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ind_map_blocks_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_load_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_load_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_journal_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_journal_start_reserved (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_handle_uninitialized_extents (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_get_implied_cluster_alloc_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_put_in_cache (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_in_cache (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_find_delalloc_range (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_get_reserved_cluster_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_show_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_remove_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_rm_leaf (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_rm_idx (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_remove_space (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_ext_remove_space_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_es_insert_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_es_cache_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_fc_replay_scan (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      ext4_fc_replay (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      irq_handler_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      irq_handler_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      irq_softirq_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      irq_softirq_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      irq_softirq_raise (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_checkpoint (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_start_commit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_commit_locking (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_commit_flushing (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_commit_logging (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_drop_transaction (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_end_commit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_submit_inode_data (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_run_stats (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_checkpoint_stats (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_update_log_tail (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      jbd2_write_superblock (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      i2c_write (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      i2c_read (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      i2c_reply (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      i2c_result (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_kmalloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_cache_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_kmalloc_node (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_cache_alloc_node (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_kfree (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_cache_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_mm_page_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_mm_page_free_batched (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_mm_page_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_mm_page_alloc_zone_locked (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_mm_page_pcpu_drain (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kmem_mm_page_alloc_extfrag (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_userspace_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_ioapic_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_msi_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_ack_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_fpu (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_age_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_try_async_get_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_async_pf_doublefault (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_async_pf_not_present (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_async_pf_ready (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_async_pf_completed (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_hypercall (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_hv_hypercall (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_pio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_cpuid (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_apic (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_inj_virq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_inj_exception (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_page_fault (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_msr (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_cr (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_pic_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_apic_ipi (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_apic_accept_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_eoi (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_pv_eoi (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_nested_vmrun (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_nested_intercepts (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_nested_vmexit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_nested_vmexit_inject (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_nested_intr_vmexit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_invlpga (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_skinit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_emulate_insn (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_vcpu_match_mmio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_write_tsc_offset (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_update_master_clock (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_x86_track_tsc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      module_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      module_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      module_get (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      module_put (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      module_request (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_pagetable_walk (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_paging_element (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_set_accessed_bit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_set_dirty_bit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_walker_error (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_get_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_sync_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_unsync_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_prepare_zap_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_mark_mmio_spte (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_handle_mmio_page_fault (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      kvm_mmu_fast_page_fault (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      napi_poll (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_dev_xmit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_dev_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_if_receive_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_if_rx (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_napi_gro_frags_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_napi_gro_receive_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_if_receive_skb_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_if_rx_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_if_rx_ni_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_if_receive_skb_list_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_napi_gro_frags_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_napi_gro_receive_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_if_receive_skb_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_if_rx_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_if_rx_ni_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      net_if_receive_skb_list_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      printk_console (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      power_cpu_idle (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      power_cpu_frequency (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      power_machine_suspend (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      power_wakeup_source_activate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      power_wakeup_source_deactivate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      power_clock_enable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      power_clock_disable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      power_clock_set_rate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      power_domain_target (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      rcu_utilization (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      regmap_reg_write (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      regmap_reg_read (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      regmap_reg_read_cache (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      regmap_hw_read_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      regmap_hw_read_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      regmap_hw_write_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      regmap_hw_write_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      regmap_regcache_sync (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      regmap_cache_only (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      regmap_cache_bypass (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      signal_generate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      signal_deliver (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_kthread_stop (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_kthread_stop_ret (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_waking (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_wakeup_new (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_switch (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_migrate_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_process_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_process_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_wait_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_process_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_process_fork (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_process_exec (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_stat_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_stat_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_stat_iowait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_stat_blocked (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_stat_runtime (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sched_pi_setprio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sock_rcvqueue_full (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      sock_exceed_buf_limit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      scsi_dispatch_cmd_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      scsi_dispatch_cmd_error (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      scsi_dispatch_cmd_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      scsi_dispatch_cmd_timeout (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      scsi_eh_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      skb_kfree (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      skb_consume (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      skb_copy_datagram_iovec (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_process_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_process_cgroup_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_process_ipc_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_process_mnt_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_process_net_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_process_pid_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_process_user_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_process_uts_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_process_time_ns (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_file_descriptor (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_vm_map (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_network_interface (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_block_device (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_interrupt (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      lttng_statedump_cpu_topology (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      rpc_call_status (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      rpc_bind_status (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      rpc_connect_status (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      rpc_task_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      rpc_task_run_action (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      rpc_task_complete (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      rpc_task_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      rpc_task_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_expire_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_expire_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_hrtimer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_hrtimer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_hrtimer_expire_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_hrtimer_expire_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_hrtimer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_itimer_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      timer_itimer_expire (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_kswapd_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_kswapd_wake (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_wakeup_kswapd (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_direct_reclaim_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_memcg_reclaim_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_memcg_softlimit_reclaim_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_direct_reclaim_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_memcg_reclaim_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_memcg_softlimit_reclaim_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_shrink_slab_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_shrink_slab_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_lru_isolate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      mm_vmscan_lru_shrink_inactive (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      udp_fail_queue_rcv_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_exceptions_page_fault_user (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_exceptions_page_fault_kernel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      workqueue_queue_work (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      workqueue_activate_work (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      workqueue_execute_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      workqueue_execute_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_dirty_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_dirty_inode_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_dirty_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_mark_inode_dirty (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_write_inode_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_write_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_nothread (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_exec (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_written (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_pages_written (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_bdi_register (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_nowork (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_wake_background (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_wake_thread (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_wake_forker_thread (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_bdi_unregister (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_thread_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_thread_stop (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_wbc_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_queue_io (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_global_dirty_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_bdi_dirty_ratelimit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_balance_dirty_pages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_sb_inodes_requeue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_congestion_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_wait_iff_congested (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      writeback_single_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_local_timer_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_local_timer_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_reschedule_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_reschedule_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_spurious_apic_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_spurious_apic_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_error_apic_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_error_apic_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_ipi_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_ipi_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_irq_work_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_irq_work_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_call_function_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_call_function_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_call_function_single_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_call_function_single_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_threshold_apic_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_threshold_apic_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_deferred_error_apic_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_deferred_error_apic_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_thermal_apic_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
      x86_irq_vectors_thermal_apic_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
