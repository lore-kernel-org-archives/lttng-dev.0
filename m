From: Jonathan Rajotte <jonathan.r.julien@gmail.com>
Subject: Re: =?utf-8?b?562U5aSNOiBsdHRuZyB0cmFjZSBrZXJuZWwgb24g?=
	=?utf-8?q?arm64?=
Date: Thu, 14 Apr 2016 15:29:59 -0400
Message-ID: <CAF4oYfGVXW_kodMV7jETNDNbcRGB+-SbYeVMQN-tOUJT437FQg__39718.5012618594$1460662215$gmane$org@mail.gmail.com>
References: <BECE94944F67D640AA66E9BA499F7CE853A12931@SZXEMA509-MBX.china.huawei.com>
 <570BB138.6030705@efficios.com>
 <BECE94944F67D640AA66E9BA499F7CE853A13BF4@SZXEMA509-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1975874498363965975=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f194.google.com (mail-ig0-f194.google.com
 [209.85.213.194])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 39C3DA2C5B
 for <lttng-dev@lists.lttng.org>; Thu, 14 Apr 2016 19:30:01 +0000 (UTC)
Received: by mail-ig0-f194.google.com with SMTP id fn8so257073igb.2
 for <lttng-dev@lists.lttng.org>; Thu, 14 Apr 2016 12:30:00 -0700 (PDT)
In-Reply-To: <BECE94944F67D640AA66E9BA499F7CE853A13BF4@SZXEMA509-MBX.china.huawei.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Lichuanbao <lichuanbao@hisilicon.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Zhanweitao <zhanweitao@hisilicon.com>
List-Id: lttng-dev@lists.lttng.org

--===============1975874498363965975==
Content-Type: multipart/alternative; boundary=001a1133d3d28ab54c053076eb4b

--001a1133d3d28ab54c053076eb4b
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Lichuanbao

On Tue, Apr 12, 2016 at 4:30 AM, Lichuanbao <lichuanbao@hisilicon.com>
wrote:

> Hi Jonathan ,Thank you for your kind help
>
> >You got me curious: D02 ? D03 hisilicon board ? :)
> Ha. You know it? It's D02.
>

From name hope to see one in flesh some day.


> >Does "lttng list -k" return a list of events ?
> Yes.it works,list many event name
>

Then you have a live lttng-sessiond.


>
> >This line suggest that another instance was running.
> >Make sure to kill all lttng-sessiond instance before starting one to
> >make sure you have the actual log of the used sessiond.
>
>
> Yes ,I tried,reboot the board,and "ps -A|grep lttng" ,here is no lttng
> session.
> after " lttng create mysession ",there is an error " Error: Could not get
> lock file /var/run/lttng/lttng-sessiond.lck, another instance is running.=
"
> I used "2.8.0-rc1" version this time. Same problem.
>
> Logs:
>
> -bash-4.3# ps -A|grep lttng
> -bash-4.3# lttng create mysession
> Spawning a session daemon
> Session mysession created.
> Traces will be written in /root/lttng-traces/mysession-19700101-015353
>

The following command "lttng-sessiond -vvv" will necessarily fail since the
previous command " lttng create mysession" just spawned one.

Could you try these on a rebooted board as root:

(Make sure there is no sessiond running)

lttng-sessiond -vvv > sessiond.log 2>&1
lttng create
lttng enable-event -a -k
lttng start
sleep 1
lttng stop
lttng view

If on "lttng view" there is no events or any of the commands fail make sure
to include their output and the sessiond.log file so we can pinpoint the
problem.



> -bash-4.3# lttng-sessiond -vvv
> DEBUG1 - 01:54:06.834954 [2687/2687]: Resetting run_as worker signal
> handlers to default (in reset_sighandler() at runas.c:536)
> DEBUG1 - 01:54:06.835249 [2687/2687]: run_as signal handler set for
> SIGTERM and SIGINT (in set_worker_sighandlers() at runas.c:593)
> DEBUG1 - 01:54:06.835345 [2686/2686]: Health check time delta in seconds
> set to 20 (in health_init() at health.c:73)
> DEBUG1 - 01:54:06.835614 [2686/2686]: epoll set max size is 27037798 (in
> compat_epoll_set_max_size() at compat-epoll.c:288)
> DEBUG3 - 01:54:06.835798 [2686/2686]: Creating LTTng run directory:
> /var/run/lttng (in create_lttng_rundir() at main.c:5246)
> DEBUG1 - 01:54:06.835812 [2686/2688]: [ht-thread] startup. (in
> thread_ht_cleanup() at ht-cleanup.c:36)
> DEBUG3 - 01:54:06.835979 [2686/2688]: [ht-thread] Polling. (in
> thread_ht_cleanup() at ht-cleanup.c:66)
> DEBUG2 - 01:54:06.835996 [2686/2686]: Kernel consumer err path:
> /var/run/lttng/kconsumerd/error (in main() at main.c:5688)
> DEBUG2 - 01:54:06.836145 [2686/2686]: Kernel consumer cmd path:
> /var/run/lttng/kconsumerd/command (in main() at main.c:5690)
> PERROR - 01:54:06.836251 [2686/2686]: fcntl lock file: Resource
> temporarily unavailable (in utils_create_lock_file() at utils.c:541)
> Error: Could not get lock file /var/run/lttng/lttng-sessiond.lck, another
> instance is running.
> DEBUG1 - 01:54:06.836379 [2686/2686]: Cleanup sessiond (in
> sessiond_cleanup() at main.c:624)
> DEBUG1 - 01:54:06.836456 [2686/2686]: Removing sessiond and consumerd
> content of directory /var/run/lttng (in sessiond_cleanup() at main.c:643)
> DEBUG1 - 01:54:06.836514 [2686/2686]: Removing
> /var/run/lttng/lttng-sessiond.pid (in sessiond_cleanup() at main.c:649)
> DEBUG1 - 01:54:06.836609 [2686/2686]: Removing /var/run/lttng/agent.port
> (in sessiond_cleanup() at main.c:654)
> DEBUG1 - 01:54:06.836719 [2686/2686]: Removing
> /var/run/lttng/kconsumerd/error (in sessiond_cleanup() at main.c:661)
> DEBUG1 - 01:54:06.836805 [2686/2686]: Removing directory
> /var/run/lttng/kconsumerd (in sessiond_cleanup() at main.c:667)
> DEBUG1 - 01:54:06.836893 [2686/2686]: Removing
> /var/run/lttng/ustconsumerd32/error (in sessiond_cleanup() at main.c:674)
> DEBUG1 - 01:54:06.836991 [2686/2686]: Removing directory
> /var/run/lttng/ustconsumerd32 (in sessiond_cleanup() at main.c:680)
> DEBUG1 - 01:54:06.837075 [2686/2686]: Removing
> /var/run/lttng/ustconsumerd64/error (in sessiond_cleanup() at main.c:687)
> DEBUG1 - 01:54:06.837169 [2686/2686]: Removing directory
> /var/run/lttng/ustconsumerd64 (in sessiond_cleanup() at main.c:693)
> DEBUG1 - 01:54:06.837253 [2686/2686]: Cleaning up all sessions (in
> sessiond_cleanup() at main.c:696)
> DEBUG1 - 01:54:06.837331 [2686/2686]: Cleaning up all agent apps (in
> sessiond_cleanup() at main.c:713)
> DEBUG1 - 01:54:06.837397 [2686/2686]: Closing all UST sockets (in
> sessiond_cleanup() at main.c:716)
> DEBUG2 - 01:54:06.837488 [2686/2686]: UST app cleaning registered apps
> hash table (in ust_app_clean_list() at ust-app.c:3818)
> DEBUG3 - 01:54:06.846332 [2686/2686]: Buffer registry destroy all registr=
y
> (in buffer_reg_destroy_registries() at buffer-registry.c:753)
> DEBUG2 - 01:54:06.846414 [2686/2686]: Closing kernel fd (in
> sessiond_cleanup() at main.c:721)
> DEBUG1 - 01:54:06.846481 [2686/2686]: Unloading kernel modules (in
> sessiond_cleanup() at main.c:728)
> DEBUG1 - 01:54:06.892609 [2686/2686]: Modprobe removal successful
> lttng-ring-buffer-metadata-mmap-client (in modprobe_remove_lttng() at
> modprobe.c:371)
> DEBUG1 - 01:54:06.940557 [2686/2686]: Modprobe removal successful
> lttng-ring-buffer-client-mmap-overwrite (in modprobe_remove_lttng() at
> modprobe.c:371)
> DEBUG1 - 01:54:06.996528 [2686/2686]: Modprobe removal successful
> lttng-ring-buffer-client-mmap-discard (in modprobe_remove_lttng() at
> modprobe.c:371)
> DEBUG1 - 01:54:07.405263 [2686/2686]: Modprobe removal successful
> lttng-ring-buffer-metadata-client (in modprobe_remove_lttng() at
> modprobe.c:371)
> DEBUG1 - 01:54:07.805463 [2686/2686]: Modprobe removal successful
> lttng-ring-buffer-client-overwrite (in modprobe_remove_lttng() at
> modprobe.c:371)
> DEBUG1 - 01:54:07.124584 [2686/2686]: Modprobe removal successful
> lttng-ring-buffer-client-discard (in modprobe_remove_lttng() at
> modprobe.c:371)
> DEBUG3 - 01:54:07.124716 [2686/2688]: [ht-thread] Returning from poll on =
2
> fds. (in thread_ht_cleanup() at ht-cleanup.c:73)
> DEBUG1 - 01:54:07.124831 [2686/2688]: [ht-cleanup] quit. (in
> thread_ht_cleanup() at ht-cleanup.c:152)
> DEBUG1 - 01:54:07.124916 [2686/2688]: [ht-cleanup] Thread terminates. (in
> thread_ht_cleanup() at ht-cleanup.c:163)
> DEBUG1 - 01:54:07.125084 [2686/2686]: Cleaning up options (in
> sessiond_cleanup_options() at main.c:775)
> DEBUG1 - 01:54:07.125161 [2686/2686]: Destroying run_as worker (in
> run_as_destroy_worker() at runas.c:705)
> DEBUG1 - 01:54:07.125236 [2686/2686]: Closing run_as worker socket (in
> run_as_destroy_worker() at runas.c:711)
> DEBUG1 - 01:54:07.125343 [2687/2687]: run_as worker exiting (ret =3D 0) (=
in
> run_as_create_worker() at runas.c:655)
> DEBUG1 - 01:54:07.126301 [2686/2686]: lttng-runas terminated with status
> code 0 (in run_as_destroy_worker() at runas.c:733)
> DEBUG1 - 01:54:07.126332 [2686/2686]: *** assert failed :-) *** =3D=3D>
> Matthew, BEET driven development works! (in sessiond_cleanup_options() at
> main.c:807)
> -bash-4.3# ps -A|grep lttng
>  2582 ?        00:00:00 lttng-sessiond
>  2583 ?        00:00:00 lttng-runas
> -bash-4.3# lttng list -k
> Kernel events:
> -------------
>       lttng_logger (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_touch_buffer (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_dirty_buffer (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_rq_abort (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_rq_requeue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_rq_complete (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_rq_insert (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_rq_issue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_bio_bounce (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_bio_complete (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_bio_backmerge (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_bio_frontmerge (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_bio_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_getrq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_sleeprq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_plug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_unplug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_split (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_bio_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       block_rq_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_transaction_commit (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_inode_new (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_inode_request (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_inode_evict (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_get_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_ordered_extent_add (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_ordered_extent_remove (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_ordered_extent_start (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_ordered_extent_put (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs__extent_writepage (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_writepage_end_io_hook (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_sync_file (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_sync_fs (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_delayed_tree_ref (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       btrfs_delayed_data_ref (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       btrfs_delayed_ref_head (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       btrfs_chunk_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_chunk_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_cow_block (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_space_reservation (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_reserved_extent_alloc (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_reserved_extent_free (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_find_free_extent (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       btrfs_reserve_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_reserve_extent_cluster (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_find_cluster (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_failed_cluster_setup (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_setup_cluster (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       btrfs_alloc_extent_state (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       btrfs_free_extent_state (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       compaction_isolate_migratepages (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       compaction_isolate_freepages (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       compaction_migratepages (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext3_free_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_request_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_allocate_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_evict_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_drop_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_mark_inode_dirty (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       ext3_write_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_ordered_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       ext3_writeback_write_end (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext3_journalled_write_end (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext3_ordered_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       ext3_writeback_writepage (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext3_journalled_writepage (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext3_readpage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_releasepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_invalidatepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_discard_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_request_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_allocate_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_free_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_sync_file_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_sync_file_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_sync_fs (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_rsv_window_add (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_discard_reservation (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext3_alloc_new_reservation (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext3_reserved (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_forget (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_read_block_bitmap (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       ext3_direct_IO_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_direct_IO_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_unlink_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_unlink_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_truncate_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_truncate_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_get_blocks_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       ext3_get_blocks_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext3_load_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_free_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_request_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_allocate_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_evict_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_drop_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_mark_inode_dirty (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       ext4_begin_ordered_truncate (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_write_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_da_write_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_ordered_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       ext4_writeback_write_end (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_journalled_write_end (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_da_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_da_writepages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_da_write_pages (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_da_write_pages_extent (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_da_writepages_result (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_readpage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_releasepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_invalidatepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_journalled_invalidatepage (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_discard_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_mb_new_inode_pa (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_mb_new_group_pa (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_mb_release_inode_pa (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_mb_release_group_pa (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_discard_preallocations (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_mb_discard_preallocations (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_request_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_allocate_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_free_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_sync_file_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_sync_file_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_sync_fs (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_alloc_da_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_mballoc_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_mballoc_prealloc (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       ext4_mballoc_discard (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_mballoc_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_forget (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_da_update_reserve_space (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_da_reserve_space (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       ext4_da_release_space (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       ext4_mb_bitmap_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_mb_buddy_bitmap_load (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_read_block_bitmap_load (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_load_inode_bitmap (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       ext4_direct_IO_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_direct_IO_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_fallocate_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_fallocate_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_punch_hole (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_zero_range (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_unlink_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_unlink_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_truncate_enter (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_truncate_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_ext_convert_to_initialized_enter (loglevel: TRACE_EMERG (0))
> (type: tracepoint)
>       ext4_ext_convert_to_initialized_fastpath (loglevel: TRACE_EMERG (0)=
)
> (type: tracepoint)
>       ext4_ext_map_blocks_enter (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_ind_map_blocks_enter (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_ext_map_blocks_exit (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_ind_map_blocks_exit (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_ext_load_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_load_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_journal_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_journal_start_reserved (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_ext_handle_uninitialized_extents (loglevel: TRACE_EMERG (0))
> (type: tracepoint)
>       ext4_get_implied_cluster_alloc_exit (loglevel: TRACE_EMERG (0))
> (type: tracepoint)
>       ext4_ext_put_in_cache (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       ext4_ext_in_cache (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_find_delalloc_range (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_get_reserved_cluster_alloc (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_ext_show_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_remove_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_ext_rm_leaf (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_ext_rm_idx (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       ext4_ext_remove_space (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       ext4_ext_remove_space_done (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       ext4_es_insert_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       ext4_es_cache_extent (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       gpio_direction (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       gpio_value (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       irq_handler_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       irq_handler_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       irq_softirq_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       irq_softirq_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       irq_softirq_raise (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd_checkpoint (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd_start_commit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd_commit_locking (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd_commit_flushing (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd_commit_logging (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd_drop_transaction (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd_end_commit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd_do_submit_data (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd_cleanup_journal_tail (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       jbd_journal_write_superblock (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       jbd2_checkpoint (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd2_start_commit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd2_commit_locking (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd2_commit_flushing (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd2_commit_logging (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd2_drop_transaction (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       jbd2_end_commit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd2_submit_inode_data (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       jbd2_run_stats (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd2_checkpoint_stats (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       jbd2_update_log_tail (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       jbd2_write_superblock (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       kmem_kmalloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kmem_cache_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kmem_kmalloc_node (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kmem_cache_alloc_node (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       kmem_kfree (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kmem_cache_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kmem_mm_page_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kmem_mm_page_free_batched (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       kmem_mm_page_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kmem_mm_page_alloc_zone_locked (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       kmem_mm_page_pcpu_drain (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       kmem_mm_page_alloc_extfrag (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       kvm_userspace_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_mmio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_fpu (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       kvm_age_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       module_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       module_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       module_get (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       module_put (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       module_request (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       napi_poll (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       net_dev_xmit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       net_dev_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       net_if_receive_skb (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       net_if_rx (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       power_cpu_idle (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       power_cpu_frequency (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       power_machine_suspend (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       power_wakeup_source_activate (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       power_wakeup_source_deactivate (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       power_clock_enable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       power_clock_disable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       power_clock_set_rate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       power_domain_target (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       printk_console (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       random_mix_pool_bytes (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       random_mix_pool_bytes_nolock (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       random_credit_entropy_bits (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       random_get_random_bytes (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       random_extract_entropy (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       random_extract_entropy_user (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       rcu_utilization (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regmap_reg_write (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regmap_reg_read (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regmap_reg_read_cache (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       regmap_hw_read_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regmap_hw_read_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regmap_hw_write_start (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       regmap_hw_write_done (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regmap_regcache_sync (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regmap_cache_only (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regmap_cache_bypass (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regulator_enable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regulator_enable_delay (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       regulator_enable_complete (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       regulator_disable (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       regulator_disable_complete (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       regulator_set_voltage (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       regulator_set_voltage_complete (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       sched_kthread_stop (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_kthread_stop_ret (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       sched_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_wakeup_new (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_switch (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_migrate_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_process_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_process_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_wait_task (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_process_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_process_fork (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_process_exec (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_stat_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_stat_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_stat_iowait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_stat_blocked (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_stat_runtime (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sched_pi_setprio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       scsi_dispatch_cmd_start (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       scsi_dispatch_cmd_error (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       scsi_dispatch_cmd_done (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       scsi_dispatch_cmd_timeout (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       scsi_eh_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       signal_generate (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       signal_deliver (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       skb_kfree (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       skb_consume (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       skb_copy_datagram_iovec (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       sock_rcvqueue_full (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       sock_exceed_buf_limit (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       lttng_statedump_start (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       lttng_statedump_end (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       lttng_statedump_process_state (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       lttng_statedump_file_descriptor (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       lttng_statedump_vm_map (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       lttng_statedump_network_interface (loglevel: TRACE_EMERG (0)) (type=
:
> tracepoint)
>       lttng_statedump_block_device (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       lttng_statedump_interrupt (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       rpc_call_status (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       rpc_bind_status (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       rpc_connect_status (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       rpc_task_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       rpc_task_run_action (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       rpc_task_complete (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       rpc_task_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       rpc_task_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_expire_entry (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_expire_exit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_hrtimer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_hrtimer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_hrtimer_expire_entry (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       timer_hrtimer_expire_exit (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       timer_hrtimer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_itimer_state (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       timer_itimer_expire (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       udp_fail_queue_rcv_skb (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       mm_vmscan_kswapd_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       mm_vmscan_kswapd_wake (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       mm_vmscan_wakeup_kswapd (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       mm_vmscan_direct_reclaim_begin (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       mm_vmscan_memcg_reclaim_begin (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       mm_vmscan_memcg_softlimit_reclaim_begin (loglevel: TRACE_EMERG (0))
> (type: tracepoint)
>       mm_vmscan_direct_reclaim_end (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       mm_vmscan_memcg_reclaim_end (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       mm_vmscan_memcg_softlimit_reclaim_end (loglevel: TRACE_EMERG (0))
> (type: tracepoint)
>       mm_vmscan_shrink_slab_start (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       mm_vmscan_shrink_slab_end (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       mm_vmscan_lru_isolate (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       mm_vmscan_memcg_isolate (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       mm_vmscan_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       mm_vmscan_lru_shrink_inactive (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       workqueue_queue_work (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       workqueue_activate_work (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       workqueue_execute_start (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       workqueue_execute_end (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       writeback_dirty_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       writeback_dirty_inode_start (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_dirty_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       writeback_mark_inode_dirty (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_write_inode_start (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_write_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       writeback_nothread (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       writeback_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       writeback_exec (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       writeback_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       writeback_written (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       writeback_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       writeback_pages_written (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_bdi_register (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       writeback_nowork (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       writeback_wake_background (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_wake_thread (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       writeback_wake_forker_thread (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_bdi_unregister (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_thread_start (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>       writeback_thread_stop (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>       writeback_wbc_writepage (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_queue_io (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>       writeback_global_dirty_state (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_bdi_dirty_ratelimit (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_balance_dirty_pages (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_sb_inodes_requeue (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_congestion_wait (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_wait_iff_congested (loglevel: TRACE_EMERG (0)) (type:
> tracepoint)
>       writeback_single_inode (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>
>
>
> -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
> =E5=8F=91=E4=BB=B6=E4=BA=BA: lttng-dev [mailto:lttng-dev-bounces@lists.lt=
tng.org] =E4=BB=A3=E8=A1=A8 Jonathan
> Rajotte Julien
> =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2016=E5=B9=B44=E6=9C=8811=E6=97=A5 =
22:14
> =E6=94=B6=E4=BB=B6=E4=BA=BA: lttng-dev@lists.lttng.org
> =E4=B8=BB=E9=A2=98: Re: [lttng-dev] lttng trace kernel on arm64
>
> Hi,
>
> On 2016-04-08 02:28 AM, Lichuanbao wrote:
> >
> > Hi,
> >
> >    I want to use lttng trace kernel event,I installed lttng-tools
> > 2.7.1 lttng-ust 2.7.2 lttng-modules 2.7.2 on my arm64 board,
> >
>
> You got me curious: D02 ? D03 hisilicon board ? :)
>
> > And then I create my session like sub command as root,but there is
> > nothing result to view.
> >
> >     # lttng create
> >
> >     # lttng enable-event --kernel --all
> >
> >     # lttng start
> >
> >     # sleep 10       # let the system generate some activity
> >
> >     # lttng stop
> >
> >     # lttng view
> >
> > # lttng destroy
> >
>
> Does "lttng list -k" return a list of events ?
>
> > -bash-4.3# lttng view
> >
> > Trace directory: /root/lttng-traces/auto-20160407-211248
> >
> > [error] Cannot open any trace for reading.
> >
> > [error] opening trace "/root/lttng-traces/auto-20160407-211248" for
> > reading.
> >
> > [error] none of the specified trace paths could be opened.
> >
> > Get thes session daemon log as follow:
> >
> > bash-4.3# lttng-sessiond -vvv
> >
> > DEBUG1 - 21:52:15.396991 [5621/5621]: run_as signal handler set for
> > SIGTERM and SIGINT (in set_worker_sighandlers() at runas.c:600)
> >
> > DEBUG1 - 21:52:15.397410 [5620/5620]: Health check time delta in
> > seconds set to 20 (in health_init() at health.c:74)
> >
> > DEBUG1 - 21:52:15.397661 [5620/5620]: epoll set max size is 27037798
> > (in compat_epoll_set_max_size() at compat-epoll.c:290)
> >
> > DEBUG3 - 21:52:15.397838 [5620/5620]: Creating LTTng run directory:
> > /var/run/lttng (in create_lttng_rundir() at main.c:5156)
> >
> > DEBUG1 - 21:52:15.397852 [5620/5622]: [ht-thread] startup. (in
> > thread_ht_cleanup() at ht-cleanup.c:37)
> >
> > DEBUG2 - 21:52:15.397986 [5620/5620]: Kernel consumer err path:
> > /var/run/lttng/kconsumerd/error (in main() at main.c:5601)
> >
> > DEBUG2 - 21:52:15.398070 [5620/5620]: Kernel consumer cmd path:
> > /var/run/lttng/kconsumerd/command (in main() at main.c:5603)
> >
> > DEBUG3 - 21:52:15.398034 [5620/5622]: [ht-thread] Polling. (in
> > thread_ht_cleanup() at ht-cleanup.c:67)
> >
> > Error: Could not get lock file /var/run/lttng/lttng-sessiond.lck,
> > another instance is running.
> >
>
> This line suggest that another instance was running.
>
> Make sure to kill all lttng-sessiond instance before starting one to
> make sure you have the actual log of the used sessiond.
>
> Cheers
>
>
> > DEBUG1 - 21:52:15.398240 [5620/5620]: Cleanup sessiond (in
> > sessiond_cleanup() at main.c:622)
> >
> > DEBUG1 - 21:52:15.398294 [5620/5620]: Removing sessiond and consumerd
> > content of directory /var/run/lttng (in sessiond_cleanup() at main.c:64=
1)
> >
> > DEBUG1 - 21:52:15.398321 [5620/5620]: Removing
> > /var/run/lttng/lttng-sessiond.pid (in sessiond_cleanup() at main.c:647)
> >
> > DEBUG1 - 21:52:15.398372 [5620/5620]: Removing
> > /var/run/lttng/agent.port (in sessiond_cleanup() at main.c:652)
> >
> > DEBUG1 - 21:52:15.398420 [5620/5620]: Removing
> > /var/run/lttng/kconsumerd/error (in sessiond_cleanup() at main.c:659)
> >
> > DEBUG1 - 21:52:15.398472 [5620/5620]: Removing directory
> > /var/run/lttng/kconsumerd (in sessiond_cleanup() at main.c:665)
> >
> > DEBUG1 - 21:52:15.398526 [5620/5620]: Removing
> > /var/run/lttng/ustconsumerd32/error (in sessiond_cleanup() at main.c:67=
2)
> >
> > DEBUG1 - 21:52:15.398579 [5620/5620]: Removing directory
> > /var/run/lttng/ustconsumerd32 (in sessiond_cleanup() at main.c:678)
> >
> > DEBUG1 - 21:52:15.398620 [5620/5620]: Removing
> > /var/run/lttng/ustconsumerd64/error (in sessiond_cleanup() at main.c:68=
5)
> >
> > DEBUG1 - 21:52:15.398673 [5620/5620]: Removing directory
> > /var/run/lttng/ustconsumerd64 (in sessiond_cleanup() at main.c:691)
> >
> > DEBUG1 - 21:52:15.398734 [5620/5620]: Cleaning up all sessions (in
> > sessiond_cleanup() at main.c:694)
> >
> > DEBUG1 - 21:52:15.398765 [5620/5620]: Cleaning up all agent apps (in
> > sessiond_cleanup() at main.c:711)
> >
> > DEBUG1 - 21:52:15.398789 [5620/5620]: Closing all UST sockets (in
> > sessiond_cleanup() at main.c:714)
> >
> > DEBUG2 - 21:52:15.398813 [5620/5620]: UST app cleaning registered apps
> > hash table (in ust_app_clean_list() at ust-app.c:3702)
> >
> > DEBUG3 - 21:52:15.398837 [5620/5620]: Buffer registry destroy all
> > registry (in buffer_reg_destroy_registries() at buffer-registry.c:716)
> >
> > DEBUG2 - 21:52:15.398861 [5620/5620]: Closing kernel fd (in
> > sessiond_cleanup() at main.c:719)
> >
> > DEBUG1 - 21:52:15.398884 [5620/5620]: Unloading kernel modules (in
> > sessiond_cleanup() at main.c:726)
> >
> > DEBUG1 - 21:52:15.403580 [5620/5620]: Modprobe removal successful
> > lttng-kretprobes (in modprobe_remove_lttng() at modprobe.c:126)
> >
> > DEBUG1 - 21:52:15.407855 [5620/5620]: Modprobe removal successful
> > lttng-kprobes (in modprobe_remove_lttng() at modprobe.c:126)
> >
> > DEBUG1 - 21:52:15.412073 [5620/5620]: Modprobe removal successful
> > lttng-ftrace (in modprobe_remove_lttng() at modprobe.c:126)
> >
> > DEBUG1 - 21:52:15.416256 [5620/5620]: Modprobe removal successful
> > lttng-types (in modprobe_remove_lttng() at modprobe.c:126)
> >
> > DEBUG1 - 21:52:15.420593 [5620/5620]: Modprobe removal successful
> > lttng-ring-buffer-metadata-mmap-client (in modprobe_remove_lttng() at
> > modprobe.c:126)
> >
> > DEBUG1 - 21:52:15.425108 [5620/5620]: Modprobe removal successful
> > lttng-ring-buffer-client-mmap-overwrite (in modprobe_remove_lttng() at
> > modprobe.c:126)
> >
> > DEBUG1 - 21:52:15.429745 [5620/5620]: Modprobe removal successful
> > lttng-ring-buffer-client-mmap-discard (in modprobe_remove_lttng() at
> > modprobe.c:126)
> >
> > Error: Unable to remove module lttng-ring-buffer-metadata-client
> >
> > DEBUG1 - 21:52:15.438779 [5620/5620]: Modprobe removal successful
> > lttng-ring-buffer-client-overwrite (in modprobe_remove_lttng() at
> > modprobe.c:126)
> >
> > Error: Unable to remove module lttng-ring-buffer-client-discard
> >
> > Error: Unable to remove module lttng-lib-ring-buffer
> >
> > Error: Unable to remove module lttng-tracer
> >
> > DEBUG3 - 21:52:15.452135 [5620/5622]: [ht-thread] Returning from poll
> > on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:74)
> >
> > DEBUG1 - 21:52:15.452186 [5620/5622]: [ht-cleanup] quit. (in
> > thread_ht_cleanup() at ht-cleanup.c:153)
> >
> > DEBUG1 - 21:52:15.452225 [5620/5622]: [ht-cleanup] Thread terminates.
> > (in thread_ht_cleanup() at ht-cleanup.c:164)
> >
> > DEBUG1 - 21:52:15.452333 [5620/5620]: Cleaning up options (in
> > sessiond_cleanup_options() at main.c:773)
> >
> > DEBUG1 - 21:52:15.453308 [5620/5620]: lttng-runas terminated with
> > status code 0 (in run_as_destroy_worker() at runas.c:737)
> >
> > DEBUG1 - 21:52:15.453349 [5620/5620]: *** assert failed :-) *** =3D=3D>
> > Matthew, BEET driven development works! (in sessiond_cleanup_options()
> > at main.c:805)
> >
> > can anybody help me ?
> >
> > thanks very much.
> >
> > lichuanbao
> >
> > ShenZhen in China
> >
> >
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Jonathan R. Julien
> Efficios
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>



--=20
Jonathan Rajotte Julien

--001a1133d3d28ab54c053076eb4b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Lichuanbao<br><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Tue, Apr 12, 2016 at 4:30 AM, Lichuanbao <span dir=3D"l=
tr">&lt;<a href=3D"mailto:lichuanbao@hisilicon.com" target=3D"_blank">lichu=
anbao@hisilicon.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quo=
te" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-col=
or:rgb(204,204,204);border-left-style:solid;padding-left:1ex">Hi Jonathan ,=
Thank you for your kind help<br>
<span class=3D""><br>
&gt;You got me curious: D02 ? D03 hisilicon board ? :)<br>
</span>Ha. You know it? It&#39;s D02.<br></blockquote><div><br></div><div>F=
rom name hope to see one in flesh some day.</div><div><br></div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:=
1px;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left=
:1ex">
<span class=3D""><br>
&gt;Does &quot;lttng list -k&quot; return a list of events ?<br>
</span>Yes.it works,list many event name<br></blockquote><div><br></div><di=
v>Then you have a live lttng-sessiond.</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px=
;border-left-color:rgb(204,204,204);border-left-style:solid;padding-left:1e=
x">
<span class=3D""><br>
&gt;This line suggest that another instance was running.<br>
&gt;Make sure to kill all lttng-sessiond instance before starting one to<br=
>
&gt;make sure you have the actual log of the used sessiond.<br>
<br>
<br>
</span>Yes ,I tried,reboot the board,and &quot;ps -A|grep lttng&quot; ,here=
 is no lttng session.<br>
after &quot; lttng create mysession &quot;,there is an error &quot; Error: =
Could not get lock file /var/run/lttng/lttng-sessiond.lck, another instance=
 is running.&quot;<br>
I used &quot;2.8.0-rc1&quot; version this time. Same problem.<br>
<br>
Logs:<br>
<br>
-bash-4.3# ps -A|grep lttng<br>
-bash-4.3# lttng create mysession<br>
Spawning a session daemon<br>
Session mysession created.<br>
Traces will be written in /root/lttng-traces/mysession-19700101-015353<br><=
/blockquote><div><br></div><div>The following command &quot;lttng-sessiond =
-vvv&quot; will necessarily fail since the previous command &quot;=C2=A0ltt=
ng create mysession&quot; just spawned one.</div><div><br></div><div>Could =
you try these on a rebooted board as root:</div><div><br></div><div>(Make s=
ure there is no sessiond running)</div><div><br></div><div>lttng-sessiond -=
vvv &gt; sessiond.log 2&gt;&amp;1<br></div><div>lttng create=C2=A0</div><di=
v>lttng enable-event -a -k</div><div>lttng start</div><div>sleep 1</div><di=
v>lttng stop</div><div>lttng view</div><div><br></div><div>If on &quot;lttn=
g view&quot; there is no events or any of the commands fail make sure to in=
clude their output and the sessiond.log file so we can pinpoint the problem=
.</div><div><br></div><div>=C2=A0<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left-width:1px;border-left-color=
:rgb(204,204,204);border-left-style:solid;padding-left:1ex">
-bash-4.3# lttng-sessiond -vvv<br>
DEBUG1 - 01:54:06.834954 [2687/2687]: Resetting run_as worker signal handle=
rs to default (in reset_sighandler() at runas.c:536)<br>
DEBUG1 - 01:54:06.835249 [2687/2687]: run_as signal handler set for SIGTERM=
 and SIGINT (in set_worker_sighandlers() at runas.c:593)<br>
DEBUG1 - 01:54:06.835345 [2686/2686]: Health check time delta in seconds se=
t to 20 (in health_init() at health.c:73)<br>
DEBUG1 - 01:54:06.835614 [2686/2686]: epoll set max size is 27037798 (in co=
mpat_epoll_set_max_size() at compat-epoll.c:288)<br>
DEBUG3 - 01:54:06.835798 [2686/2686]: Creating LTTng run directory: /var/ru=
n/lttng (in create_lttng_rundir() at main.c:5246)<br>
DEBUG1 - 01:54:06.835812 [2686/2688]: [ht-thread] startup. (in thread_ht_cl=
eanup() at ht-cleanup.c:36)<br>
DEBUG3 - 01:54:06.835979 [2686/2688]: [ht-thread] Polling. (in thread_ht_cl=
eanup() at ht-cleanup.c:66)<br>
DEBUG2 - 01:54:06.835996 [2686/2686]: Kernel consumer err path: /var/run/lt=
tng/kconsumerd/error (in main() at main.c:5688)<br>
DEBUG2 - 01:54:06.836145 [2686/2686]: Kernel consumer cmd path: /var/run/lt=
tng/kconsumerd/command (in main() at main.c:5690)<br>
PERROR - 01:54:06.836251 [2686/2686]: fcntl lock file: Resource temporarily=
 unavailable (in utils_create_lock_file() at utils.c:541)<br>
<span class=3D"">Error: Could not get lock file /var/run/lttng/lttng-sessio=
nd.lck, another instance is running.<br>
</span>DEBUG1 - 01:54:06.836379 [2686/2686]: Cleanup sessiond (in sessiond_=
cleanup() at main.c:624)<br>
DEBUG1 - 01:54:06.836456 [2686/2686]: Removing sessiond and consumerd conte=
nt of directory /var/run/lttng (in sessiond_cleanup() at main.c:643)<br>
DEBUG1 - 01:54:06.836514 [2686/2686]: Removing /var/run/lttng/lttng-session=
d.pid (in sessiond_cleanup() at main.c:649)<br>
DEBUG1 - 01:54:06.836609 [2686/2686]: Removing /var/run/lttng/agent.port (i=
n sessiond_cleanup() at main.c:654)<br>
DEBUG1 - 01:54:06.836719 [2686/2686]: Removing /var/run/lttng/kconsumerd/er=
ror (in sessiond_cleanup() at main.c:661)<br>
DEBUG1 - 01:54:06.836805 [2686/2686]: Removing directory /var/run/lttng/kco=
nsumerd (in sessiond_cleanup() at main.c:667)<br>
DEBUG1 - 01:54:06.836893 [2686/2686]: Removing /var/run/lttng/ustconsumerd3=
2/error (in sessiond_cleanup() at main.c:674)<br>
DEBUG1 - 01:54:06.836991 [2686/2686]: Removing directory /var/run/lttng/ust=
consumerd32 (in sessiond_cleanup() at main.c:680)<br>
DEBUG1 - 01:54:06.837075 [2686/2686]: Removing /var/run/lttng/ustconsumerd6=
4/error (in sessiond_cleanup() at main.c:687)<br>
DEBUG1 - 01:54:06.837169 [2686/2686]: Removing directory /var/run/lttng/ust=
consumerd64 (in sessiond_cleanup() at main.c:693)<br>
DEBUG1 - 01:54:06.837253 [2686/2686]: Cleaning up all sessions (in sessiond=
_cleanup() at main.c:696)<br>
DEBUG1 - 01:54:06.837331 [2686/2686]: Cleaning up all agent apps (in sessio=
nd_cleanup() at main.c:713)<br>
DEBUG1 - 01:54:06.837397 [2686/2686]: Closing all UST sockets (in sessiond_=
cleanup() at main.c:716)<br>
DEBUG2 - 01:54:06.837488 [2686/2686]: UST app cleaning registered apps hash=
 table (in ust_app_clean_list() at ust-app.c:3818)<br>
DEBUG3 - 01:54:06.846332 [2686/2686]: Buffer registry destroy all registry =
(in buffer_reg_destroy_registries() at buffer-registry.c:753)<br>
DEBUG2 - 01:54:06.846414 [2686/2686]: Closing kernel fd (in sessiond_cleanu=
p() at main.c:721)<br>
DEBUG1 - 01:54:06.846481 [2686/2686]: Unloading kernel modules (in sessiond=
_cleanup() at main.c:728)<br>
DEBUG1 - 01:54:06.892609 [2686/2686]: Modprobe removal successful lttng-rin=
g-buffer-metadata-mmap-client (in modprobe_remove_lttng() at modprobe.c:371=
)<br>
DEBUG1 - 01:54:06.940557 [2686/2686]: Modprobe removal successful lttng-rin=
g-buffer-client-mmap-overwrite (in modprobe_remove_lttng() at modprobe.c:37=
1)<br>
DEBUG1 - 01:54:06.996528 [2686/2686]: Modprobe removal successful lttng-rin=
g-buffer-client-mmap-discard (in modprobe_remove_lttng() at modprobe.c:371)=
<br>
DEBUG1 - 01:54:07.405263 [2686/2686]: Modprobe removal successful lttng-rin=
g-buffer-metadata-client (in modprobe_remove_lttng() at modprobe.c:371)<br>
DEBUG1 - 01:54:07.805463 [2686/2686]: Modprobe removal successful lttng-rin=
g-buffer-client-overwrite (in modprobe_remove_lttng() at modprobe.c:371)<br=
>
DEBUG1 - 01:54:07.124584 [2686/2686]: Modprobe removal successful lttng-rin=
g-buffer-client-discard (in modprobe_remove_lttng() at modprobe.c:371)<br>
DEBUG3 - 01:54:07.124716 [2686/2688]: [ht-thread] Returning from poll on 2 =
fds. (in thread_ht_cleanup() at ht-cleanup.c:73)<br>
DEBUG1 - 01:54:07.124831 [2686/2688]: [ht-cleanup] quit. (in thread_ht_clea=
nup() at ht-cleanup.c:152)<br>
DEBUG1 - 01:54:07.124916 [2686/2688]: [ht-cleanup] Thread terminates. (in t=
hread_ht_cleanup() at ht-cleanup.c:163)<br>
DEBUG1 - 01:54:07.125084 [2686/2686]: Cleaning up options (in sessiond_clea=
nup_options() at main.c:775)<br>
DEBUG1 - 01:54:07.125161 [2686/2686]: Destroying run_as worker (in run_as_d=
estroy_worker() at runas.c:705)<br>
DEBUG1 - 01:54:07.125236 [2686/2686]: Closing run_as worker socket (in run_=
as_destroy_worker() at runas.c:711)<br>
DEBUG1 - 01:54:07.125343 [2687/2687]: run_as worker exiting (ret =3D 0) (in=
 run_as_create_worker() at runas.c:655)<br>
DEBUG1 - 01:54:07.126301 [2686/2686]: lttng-runas terminated with status co=
de 0 (in run_as_destroy_worker() at runas.c:733)<br>
DEBUG1 - 01:54:07.126332 [2686/2686]: *** assert failed :-) *** =3D=3D&gt; =
Matthew, BEET driven development works! (in sessiond_cleanup_options() at m=
ain.c:807)<br>
-bash-4.3# ps -A|grep lttng<br>
=C2=A02582 ?=C2=A0 =C2=A0 =C2=A0 =C2=A0 00:00:00 lttng-sessiond<br>
=C2=A02583 ?=C2=A0 =C2=A0 =C2=A0 =C2=A0 00:00:00 lttng-runas<br>
-bash-4.3# lttng list -k<br>
Kernel events:<br>
-------------<br>
=C2=A0 =C2=A0 =C2=A0 lttng_logger (loglevel: TRACE_EMERG (0)) (type: tracep=
oint)<br>
=C2=A0 =C2=A0 =C2=A0 block_touch_buffer (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_dirty_buffer (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_rq_abort (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_rq_requeue (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_rq_complete (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_rq_insert (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_rq_issue (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_bio_bounce (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_bio_complete (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_bio_backmerge (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_bio_frontmerge (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_bio_queue (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_getrq (loglevel: TRACE_EMERG (0)) (type: tracepo=
int)<br>
=C2=A0 =C2=A0 =C2=A0 block_sleeprq (loglevel: TRACE_EMERG (0)) (type: trace=
point)<br>
=C2=A0 =C2=A0 =C2=A0 block_plug (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)<br>
=C2=A0 =C2=A0 =C2=A0 block_unplug (loglevel: TRACE_EMERG (0)) (type: tracep=
oint)<br>
=C2=A0 =C2=A0 =C2=A0 block_split (loglevel: TRACE_EMERG (0)) (type: tracepo=
int)<br>
=C2=A0 =C2=A0 =C2=A0 block_bio_remap (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 block_rq_remap (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_transaction_commit (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_inode_new (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_inode_request (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_inode_evict (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_get_extent (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_ordered_extent_add (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_ordered_extent_remove (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_ordered_extent_start (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_ordered_extent_put (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs__extent_writepage (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_writepage_end_io_hook (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_sync_file (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_sync_fs (loglevel: TRACE_EMERG (0)) (type: trace=
point)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_delayed_tree_ref (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_delayed_data_ref (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_delayed_ref_head (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_chunk_alloc (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_chunk_free (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_cow_block (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_space_reservation (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_reserved_extent_alloc (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_reserved_extent_free (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_find_free_extent (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_reserve_extent (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_reserve_extent_cluster (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_find_cluster (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_failed_cluster_setup (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_setup_cluster (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_alloc_extent_state (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 btrfs_free_extent_state (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 compaction_isolate_migratepages (loglevel: TRACE_EMERG=
 (0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 compaction_isolate_freepages (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 compaction_migratepages (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_free_inode (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_request_inode (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_allocate_inode (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_evict_inode (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_drop_inode (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_mark_inode_dirty (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_write_begin (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_ordered_write_end (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_writeback_write_end (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_journalled_write_end (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_ordered_writepage (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_writeback_writepage (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_journalled_writepage (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_readpage (loglevel: TRACE_EMERG (0)) (type: trace=
point)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_releasepage (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_invalidatepage (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_discard_blocks (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_request_blocks (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_allocate_blocks (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_free_blocks (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_sync_file_enter (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_sync_file_exit (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_sync_fs (loglevel: TRACE_EMERG (0)) (type: tracep=
oint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_rsv_window_add (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_discard_reservation (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_alloc_new_reservation (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_reserved (loglevel: TRACE_EMERG (0)) (type: trace=
point)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_forget (loglevel: TRACE_EMERG (0)) (type: tracepo=
int)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_read_block_bitmap (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_direct_IO_enter (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_direct_IO_exit (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_unlink_enter (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_unlink_exit (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_truncate_enter (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_truncate_exit (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_get_blocks_enter (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_get_blocks_exit (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext3_load_inode (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_free_inode (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_request_inode (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_allocate_inode (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_evict_inode (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_drop_inode (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mark_inode_dirty (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_begin_ordered_truncate (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_write_begin (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_da_write_begin (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ordered_write_end (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_writeback_write_end (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_journalled_write_end (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_da_write_end (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_da_writepages (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_da_write_pages (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_da_write_pages_extent (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_da_writepages_result (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_writepage (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_readpage (loglevel: TRACE_EMERG (0)) (type: trace=
point)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_releasepage (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_invalidatepage (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_journalled_invalidatepage (loglevel: TRACE_EMERG =
(0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_discard_blocks (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mb_new_inode_pa (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mb_new_group_pa (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mb_release_inode_pa (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mb_release_group_pa (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_discard_preallocations (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mb_discard_preallocations (loglevel: TRACE_EMERG =
(0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_request_blocks (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_allocate_blocks (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_free_blocks (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_sync_file_enter (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_sync_file_exit (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_sync_fs (loglevel: TRACE_EMERG (0)) (type: tracep=
oint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_alloc_da_blocks (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mballoc_alloc (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mballoc_prealloc (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mballoc_discard (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mballoc_free (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_forget (loglevel: TRACE_EMERG (0)) (type: tracepo=
int)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_da_update_reserve_space (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_da_reserve_space (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_da_release_space (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mb_bitmap_load (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_mb_buddy_bitmap_load (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_read_block_bitmap_load (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_load_inode_bitmap (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_direct_IO_enter (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_direct_IO_exit (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_fallocate_exit (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_fallocate_enter (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_punch_hole (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_zero_range (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_unlink_enter (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_unlink_exit (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_truncate_enter (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_truncate_exit (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_convert_to_initialized_enter (loglevel: TRACE=
_EMERG (0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_convert_to_initialized_fastpath (loglevel: TR=
ACE_EMERG (0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_map_blocks_enter (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ind_map_blocks_enter (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_map_blocks_exit (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ind_map_blocks_exit (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_load_extent (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_load_inode (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_journal_start (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_journal_start_reserved (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_handle_uninitialized_extents (loglevel: TRACE=
_EMERG (0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_get_implied_cluster_alloc_exit (loglevel: TRACE_E=
MERG (0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_put_in_cache (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_in_cache (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_find_delalloc_range (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_get_reserved_cluster_alloc (loglevel: TRACE_EMERG=
 (0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_show_extent (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_remove_blocks (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_rm_leaf (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_rm_idx (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_remove_space (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_ext_remove_space_done (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_es_insert_extent (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 ext4_es_cache_extent (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 gpio_direction (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 gpio_value (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)<br>
=C2=A0 =C2=A0 =C2=A0 irq_handler_entry (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 irq_handler_exit (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 irq_softirq_entry (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 irq_softirq_exit (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 irq_softirq_raise (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd_checkpoint (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd_start_commit (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd_commit_locking (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd_commit_flushing (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd_commit_logging (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd_drop_transaction (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd_end_commit (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd_do_submit_data (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd_cleanup_journal_tail (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd_journal_write_superblock (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_checkpoint (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_start_commit (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_commit_locking (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_commit_flushing (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_commit_logging (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_drop_transaction (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_end_commit (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_submit_inode_data (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_run_stats (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_checkpoint_stats (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_update_log_tail (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 jbd2_write_superblock (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_kmalloc (loglevel: TRACE_EMERG (0)) (type: tracep=
oint)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_cache_alloc (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_kmalloc_node (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_cache_alloc_node (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_kfree (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_cache_free (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_mm_page_free (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_mm_page_free_batched (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_mm_page_alloc (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_mm_page_alloc_zone_locked (loglevel: TRACE_EMERG =
(0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_mm_page_pcpu_drain (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kmem_mm_page_alloc_extfrag (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kvm_userspace_exit (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 kvm_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepo=
int)<br>
=C2=A0 =C2=A0 =C2=A0 kvm_mmio (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)<br>
=C2=A0 =C2=A0 =C2=A0 kvm_fpu (loglevel: TRACE_EMERG (0)) (type: tracepoint)=
<br>
=C2=A0 =C2=A0 =C2=A0 kvm_age_page (loglevel: TRACE_EMERG (0)) (type: tracep=
oint)<br>
=C2=A0 =C2=A0 =C2=A0 module_load (loglevel: TRACE_EMERG (0)) (type: tracepo=
int)<br>
=C2=A0 =C2=A0 =C2=A0 module_free (loglevel: TRACE_EMERG (0)) (type: tracepo=
int)<br>
=C2=A0 =C2=A0 =C2=A0 module_get (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)<br>
=C2=A0 =C2=A0 =C2=A0 module_put (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)<br>
=C2=A0 =C2=A0 =C2=A0 module_request (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 napi_poll (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)<br>
=C2=A0 =C2=A0 =C2=A0 net_dev_xmit (loglevel: TRACE_EMERG (0)) (type: tracep=
oint)<br>
=C2=A0 =C2=A0 =C2=A0 net_dev_queue (loglevel: TRACE_EMERG (0)) (type: trace=
point)<br>
=C2=A0 =C2=A0 =C2=A0 net_if_receive_skb (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 net_if_rx (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)<br>
=C2=A0 =C2=A0 =C2=A0 power_cpu_idle (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 power_cpu_frequency (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 power_machine_suspend (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 power_wakeup_source_activate (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 power_wakeup_source_deactivate (loglevel: TRACE_EMERG =
(0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 power_clock_enable (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 power_clock_disable (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 power_clock_set_rate (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 power_domain_target (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 printk_console (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 random_mix_pool_bytes (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 random_mix_pool_bytes_nolock (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 random_credit_entropy_bits (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 random_get_random_bytes (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 random_extract_entropy (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 random_extract_entropy_user (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 rcu_utilization (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regmap_reg_write (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regmap_reg_read (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regmap_reg_read_cache (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regmap_hw_read_start (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regmap_hw_read_done (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regmap_hw_write_start (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regmap_hw_write_done (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regmap_regcache_sync (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regmap_cache_only (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regmap_cache_bypass (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regulator_enable (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regulator_enable_delay (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regulator_enable_complete (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regulator_disable (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regulator_disable_complete (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regulator_set_voltage (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 regulator_set_voltage_complete (loglevel: TRACE_EMERG =
(0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_kthread_stop (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_kthread_stop_ret (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_wakeup (loglevel: TRACE_EMERG (0)) (type: tracep=
oint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_wakeup_new (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_switch (loglevel: TRACE_EMERG (0)) (type: tracep=
oint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_migrate_task (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_process_free (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_process_exit (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_wait_task (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_process_wait (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_process_fork (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_process_exec (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_stat_wait (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_stat_sleep (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_stat_iowait (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_stat_blocked (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_stat_runtime (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sched_pi_setprio (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 scsi_dispatch_cmd_start (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 scsi_dispatch_cmd_error (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 scsi_dispatch_cmd_done (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 scsi_dispatch_cmd_timeout (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 scsi_eh_wakeup (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 signal_generate (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 signal_deliver (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 skb_kfree (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)<br>
=C2=A0 =C2=A0 =C2=A0 skb_consume (loglevel: TRACE_EMERG (0)) (type: tracepo=
int)<br>
=C2=A0 =C2=A0 =C2=A0 skb_copy_datagram_iovec (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sock_rcvqueue_full (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 sock_exceed_buf_limit (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 lttng_statedump_start (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 lttng_statedump_end (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 lttng_statedump_process_state (loglevel: TRACE_EMERG (=
0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 lttng_statedump_file_descriptor (loglevel: TRACE_EMERG=
 (0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 lttng_statedump_vm_map (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 lttng_statedump_network_interface (loglevel: TRACE_EME=
RG (0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 lttng_statedump_block_device (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 lttng_statedump_interrupt (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 rpc_call_status (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 rpc_bind_status (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 rpc_connect_status (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 rpc_task_begin (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 rpc_task_run_action (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 rpc_task_complete (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 rpc_task_sleep (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 rpc_task_wakeup (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 timer_init (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)<br>
=C2=A0 =C2=A0 =C2=A0 timer_start (loglevel: TRACE_EMERG (0)) (type: tracepo=
int)<br>
=C2=A0 =C2=A0 =C2=A0 timer_expire_entry (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 timer_expire_exit (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 timer_cancel (loglevel: TRACE_EMERG (0)) (type: tracep=
oint)<br>
=C2=A0 =C2=A0 =C2=A0 timer_hrtimer_init (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 timer_hrtimer_start (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 timer_hrtimer_expire_entry (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 timer_hrtimer_expire_exit (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 timer_hrtimer_cancel (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 timer_itimer_state (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 timer_itimer_expire (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 udp_fail_queue_rcv_skb (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_kswapd_sleep (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_kswapd_wake (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_wakeup_kswapd (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_direct_reclaim_begin (loglevel: TRACE_EMERG =
(0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_memcg_reclaim_begin (loglevel: TRACE_EMERG (=
0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_memcg_softlimit_reclaim_begin (loglevel: TRA=
CE_EMERG (0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_direct_reclaim_end (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_memcg_reclaim_end (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_memcg_softlimit_reclaim_end (loglevel: TRACE=
_EMERG (0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_shrink_slab_start (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_shrink_slab_end (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_lru_isolate (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_memcg_isolate (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_writepage (loglevel: TRACE_EMERG (0)) (type:=
 tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 mm_vmscan_lru_shrink_inactive (loglevel: TRACE_EMERG (=
0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 workqueue_queue_work (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 workqueue_activate_work (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 workqueue_execute_start (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 workqueue_execute_end (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_dirty_page (loglevel: TRACE_EMERG (0)) (type=
: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_dirty_inode_start (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_dirty_inode (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_mark_inode_dirty (loglevel: TRACE_EMERG (0))=
 (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_write_inode_start (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_write_inode (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_nothread (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_queue (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_exec (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_start (loglevel: TRACE_EMERG (0)) (type: tra=
cepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_written (loglevel: TRACE_EMERG (0)) (type: t=
racepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_wait (loglevel: TRACE_EMERG (0)) (type: trac=
epoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_pages_written (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_bdi_register (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_nowork (loglevel: TRACE_EMERG (0)) (type: tr=
acepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_wake_background (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_wake_thread (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_wake_forker_thread (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_bdi_unregister (loglevel: TRACE_EMERG (0)) (=
type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_thread_start (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_thread_stop (loglevel: TRACE_EMERG (0)) (typ=
e: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_wbc_writepage (loglevel: TRACE_EMERG (0)) (t=
ype: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_queue_io (loglevel: TRACE_EMERG (0)) (type: =
tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_global_dirty_state (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_bdi_dirty_ratelimit (loglevel: TRACE_EMERG (=
0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_balance_dirty_pages (loglevel: TRACE_EMERG (=
0)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_sb_inodes_requeue (loglevel: TRACE_EMERG (0)=
) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_congestion_wait (loglevel: TRACE_EMERG (0)) =
(type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_wait_iff_congested (loglevel: TRACE_EMERG (0=
)) (type: tracepoint)<br>
=C2=A0 =C2=A0 =C2=A0 writeback_single_inode (loglevel: TRACE_EMERG (0)) (ty=
pe: tracepoint)<br>
<br>
<br>
<br>
-----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----<br>
=E5=8F=91=E4=BB=B6=E4=BA=BA: lttng-dev [mailto:<a href=3D"mailto:lttng-dev-=
bounces@lists.lttng.org">lttng-dev-bounces@lists.lttng.org</a>] =E4=BB=A3=
=E8=A1=A8 Jonathan Rajotte Julien<br>
=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2016=E5=B9=B44=E6=9C=8811=E6=97=A5 22=
:14<br>
=E6=94=B6=E4=BB=B6=E4=BA=BA: <a href=3D"mailto:lttng-dev@lists.lttng.org">l=
ttng-dev@lists.lttng.org</a><br>
=E4=B8=BB=E9=A2=98: Re: [lttng-dev] lttng trace kernel on arm64<br>
<div class=3D""><div class=3D"h5"><br>
Hi,<br>
<br>
On 2016-04-08 02:28 AM, Lichuanbao wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 I want to use lttng trace kernel event,I installed lttng-=
tools<br>
&gt; 2.7.1 lttng-ust 2.7.2 lttng-modules 2.7.2 on my arm64 board,<br>
&gt;<br>
<br>
You got me curious: D02 ? D03 hisilicon board ? :)<br>
<br>
&gt; And then I create my session like sub command as root,but there is<br>
&gt; nothing result to view.<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0# lttng create<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0# lttng enable-event --kernel --all<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0# lttng start<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0# sleep 10=C2=A0 =C2=A0 =C2=A0 =C2=A0# let the syst=
em generate some activity<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0# lttng stop<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0# lttng view<br>
&gt;<br>
&gt; # lttng destroy<br>
&gt;<br>
<br>
Does &quot;lttng list -k&quot; return a list of events ?<br>
<br>
&gt; -bash-4.3# lttng view<br>
&gt;<br>
&gt; Trace directory: /root/lttng-traces/auto-20160407-211248<br>
&gt;<br>
&gt; [error] Cannot open any trace for reading.<br>
&gt;<br>
&gt; [error] opening trace &quot;/root/lttng-traces/auto-20160407-211248&qu=
ot; for<br>
&gt; reading.<br>
&gt;<br>
&gt; [error] none of the specified trace paths could be opened.<br>
&gt;<br>
&gt; Get thes session daemon log as follow:<br>
&gt;<br>
&gt; bash-4.3# lttng-sessiond -vvv<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.396991 [5621/5621]: run_as signal handler set for<br=
>
&gt; SIGTERM and SIGINT (in set_worker_sighandlers() at runas.c:600)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.397410 [5620/5620]: Health check time delta in<br>
&gt; seconds set to 20 (in health_init() at health.c:74)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.397661 [5620/5620]: epoll set max size is 27037798<b=
r>
&gt; (in compat_epoll_set_max_size() at compat-epoll.c:290)<br>
&gt;<br>
&gt; DEBUG3 - 21:52:15.397838 [5620/5620]: Creating LTTng run directory:<br=
>
&gt; /var/run/lttng (in create_lttng_rundir() at main.c:5156)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.397852 [5620/5622]: [ht-thread] startup. (in<br>
&gt; thread_ht_cleanup() at ht-cleanup.c:37)<br>
&gt;<br>
&gt; DEBUG2 - 21:52:15.397986 [5620/5620]: Kernel consumer err path:<br>
&gt; /var/run/lttng/kconsumerd/error (in main() at main.c:5601)<br>
&gt;<br>
&gt; DEBUG2 - 21:52:15.398070 [5620/5620]: Kernel consumer cmd path:<br>
&gt; /var/run/lttng/kconsumerd/command (in main() at main.c:5603)<br>
&gt;<br>
&gt; DEBUG3 - 21:52:15.398034 [5620/5622]: [ht-thread] Polling. (in<br>
&gt; thread_ht_cleanup() at ht-cleanup.c:67)<br>
&gt;<br>
&gt; Error: Could not get lock file /var/run/lttng/lttng-sessiond.lck,<br>
&gt; another instance is running.<br>
&gt;<br>
<br>
This line suggest that another instance was running.<br>
<br>
Make sure to kill all lttng-sessiond instance before starting one to<br>
make sure you have the actual log of the used sessiond.<br>
<br>
Cheers<br>
<br>
<br>
&gt; DEBUG1 - 21:52:15.398240 [5620/5620]: Cleanup sessiond (in<br>
&gt; sessiond_cleanup() at main.c:622)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398294 [5620/5620]: Removing sessiond and consumerd<=
br>
&gt; content of directory /var/run/lttng (in sessiond_cleanup() at main.c:6=
41)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398321 [5620/5620]: Removing<br>
&gt; /var/run/lttng/lttng-sessiond.pid (in sessiond_cleanup() at main.c:647=
)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398372 [5620/5620]: Removing<br>
&gt; /var/run/lttng/agent.port (in sessiond_cleanup() at main.c:652)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398420 [5620/5620]: Removing<br>
&gt; /var/run/lttng/kconsumerd/error (in sessiond_cleanup() at main.c:659)<=
br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398472 [5620/5620]: Removing directory<br>
&gt; /var/run/lttng/kconsumerd (in sessiond_cleanup() at main.c:665)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398526 [5620/5620]: Removing<br>
&gt; /var/run/lttng/ustconsumerd32/error (in sessiond_cleanup() at main.c:6=
72)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398579 [5620/5620]: Removing directory<br>
&gt; /var/run/lttng/ustconsumerd32 (in sessiond_cleanup() at main.c:678)<br=
>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398620 [5620/5620]: Removing<br>
&gt; /var/run/lttng/ustconsumerd64/error (in sessiond_cleanup() at main.c:6=
85)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398673 [5620/5620]: Removing directory<br>
&gt; /var/run/lttng/ustconsumerd64 (in sessiond_cleanup() at main.c:691)<br=
>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398734 [5620/5620]: Cleaning up all sessions (in<br>
&gt; sessiond_cleanup() at main.c:694)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398765 [5620/5620]: Cleaning up all agent apps (in<b=
r>
&gt; sessiond_cleanup() at main.c:711)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398789 [5620/5620]: Closing all UST sockets (in<br>
&gt; sessiond_cleanup() at main.c:714)<br>
&gt;<br>
&gt; DEBUG2 - 21:52:15.398813 [5620/5620]: UST app cleaning registered apps=
<br>
&gt; hash table (in ust_app_clean_list() at ust-app.c:3702)<br>
&gt;<br>
&gt; DEBUG3 - 21:52:15.398837 [5620/5620]: Buffer registry destroy all<br>
&gt; registry (in buffer_reg_destroy_registries() at buffer-registry.c:716)=
<br>
&gt;<br>
&gt; DEBUG2 - 21:52:15.398861 [5620/5620]: Closing kernel fd (in<br>
&gt; sessiond_cleanup() at main.c:719)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.398884 [5620/5620]: Unloading kernel modules (in<br>
&gt; sessiond_cleanup() at main.c:726)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.403580 [5620/5620]: Modprobe removal successful<br>
&gt; lttng-kretprobes (in modprobe_remove_lttng() at modprobe.c:126)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.407855 [5620/5620]: Modprobe removal successful<br>
&gt; lttng-kprobes (in modprobe_remove_lttng() at modprobe.c:126)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.412073 [5620/5620]: Modprobe removal successful<br>
&gt; lttng-ftrace (in modprobe_remove_lttng() at modprobe.c:126)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.416256 [5620/5620]: Modprobe removal successful<br>
&gt; lttng-types (in modprobe_remove_lttng() at modprobe.c:126)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.420593 [5620/5620]: Modprobe removal successful<br>
&gt; lttng-ring-buffer-metadata-mmap-client (in modprobe_remove_lttng() at<=
br>
&gt; modprobe.c:126)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.425108 [5620/5620]: Modprobe removal successful<br>
&gt; lttng-ring-buffer-client-mmap-overwrite (in modprobe_remove_lttng() at=
<br>
&gt; modprobe.c:126)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.429745 [5620/5620]: Modprobe removal successful<br>
&gt; lttng-ring-buffer-client-mmap-discard (in modprobe_remove_lttng() at<b=
r>
&gt; modprobe.c:126)<br>
&gt;<br>
&gt; Error: Unable to remove module lttng-ring-buffer-metadata-client<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.438779 [5620/5620]: Modprobe removal successful<br>
&gt; lttng-ring-buffer-client-overwrite (in modprobe_remove_lttng() at<br>
&gt; modprobe.c:126)<br>
&gt;<br>
&gt; Error: Unable to remove module lttng-ring-buffer-client-discard<br>
&gt;<br>
&gt; Error: Unable to remove module lttng-lib-ring-buffer<br>
&gt;<br>
&gt; Error: Unable to remove module lttng-tracer<br>
&gt;<br>
&gt; DEBUG3 - 21:52:15.452135 [5620/5622]: [ht-thread] Returning from poll<=
br>
&gt; on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:74)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.452186 [5620/5622]: [ht-cleanup] quit. (in<br>
&gt; thread_ht_cleanup() at ht-cleanup.c:153)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.452225 [5620/5622]: [ht-cleanup] Thread terminates.<=
br>
&gt; (in thread_ht_cleanup() at ht-cleanup.c:164)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.452333 [5620/5620]: Cleaning up options (in<br>
&gt; sessiond_cleanup_options() at main.c:773)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.453308 [5620/5620]: lttng-runas terminated with<br>
&gt; status code 0 (in run_as_destroy_worker() at runas.c:737)<br>
&gt;<br>
&gt; DEBUG1 - 21:52:15.453349 [5620/5620]: *** assert failed :-) *** =3D=3D=
&gt;<br>
&gt; Matthew, BEET driven development works! (in sessiond_cleanup_options()=
<br>
&gt; at main.c:805)<br>
&gt;<br>
&gt; can anybody help me ?<br>
&gt;<br>
&gt; thanks very much.<br>
&gt;<br>
&gt; lichuanbao<br>
&gt;<br>
&gt; ShenZhen in China<br>
&gt;<br>
&gt;<br>
&gt;<br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org=
</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
--<br>
Jonathan R. Julien<br>
Efficios<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br>=
<div class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr">Jonat=
han Rajotte Julien<div><br></div></div></div></div></div>
</div></div>

--001a1133d3d28ab54c053076eb4b--

--===============1975874498363965975==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============1975874498363965975==--
