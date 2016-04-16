From: Jonathan Rajotte Julien <Jonathan.rajotte-julien@efficios.com>
Subject: Re: =?utf-8?b?562U5aSNOiAg562U5aSNOiBsdHRuZyB0cmFjZSBr?=
 =?utf-8?q?ernel_on_arm64?=
Date: Sat, 16 Apr 2016 11:15:46 -0400
Message-ID: <57125722.3020501__8680.37279365144$1460819784$gmane$org@efficios.com>
References: <BECE94944F67D640AA66E9BA499F7CE853A12931@SZXEMA509-MBX.china.huawei.com>
 <570BB138.6030705@efficios.com>
 <BECE94944F67D640AA66E9BA499F7CE853A13BF4@SZXEMA509-MBX.china.huawei.com>
 <CAF4oYfGVXW_kodMV7jETNDNbcRGB+-SbYeVMQN-tOUJT437FQg@mail.gmail.com>
 <BECE94944F67D640AA66E9BA499F7CE853A15185@SZXEMA509-MBX.china.huawei.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0608021966670293921=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [78.47.125.74])
 by evm-lttng-1.efficios.com (Postfix) with ESMTPS id 78B20A2162
 for <lttng-dev@lists.lttng.org>; Sat, 16 Apr 2016 15:15:57 +0000 (UTC)
In-Reply-To: <BECE94944F67D640AA66E9BA499F7CE853A15185@SZXEMA509-MBX.china.huawei.com>
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
Cc: Zhanweitao <zhanweitao@hisilicon.com>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

This is a multi-part message in MIME format.
--===============0608021966670293921==
Content-Type: multipart/alternative;
 boundary="------------050907000301070402070901"

This is a multi-part message in MIME format.
--------------050907000301070402070901
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable



On 2016-04-16 08:27 AM, Lichuanbao wrote:
>
> Hi Jonathan
>
> Glad to see your words again!
>
> >From name hope to see one in flesh some day.
>
> I also hope one day to ask when facing you
>
> You are not interested in me ,right? haha( =E2=80=B5=E2=96=BD=E2=80=B2)=
=CF=88
>
> >The following command "lttng-sessiond -vvv" will necessarily fail sinc=
e the=20
> previous command " lttng create mysession" just spawned one.
>
> >Could you try these on a rebooted board as root:
>
> >(Make sure there is no sessiond running)
>
> >lttng-sessiond -vvv > sessiond.log 2>&1
>
> >lttng create
>
> >lttng enable-event -a -k
>
> >lttng start
>
> >sleep 1
>
> >lttng stop
>
> >lttng view
>
> >If on "lttng view" there is no events or any of the commands fail make=
 sure to include=20
> their output and the sessiond.log file so we can pinpoint the problem.
>
> Yes,Step by step according to your cmd:
>
> The session.log view attachments.there are some error as flow, I=20
> installed lttng-ust already:
>
> lttng-consumerd: error while loading shared libraries:=20
> liblttng-ust-ctl.so.2: cannot open shared object file: No such file or=20
> directory
>
> Error: Condition timed out. The consumer thread was never ready.=20
> Killing it
>
> Error: Fatal error spawning consumer control thread
>
Could you do a search for this file and make sure it exist ?

Also it might be a good idea to uninstall everything (lttng-ust,=20
lttng-tools, lttng-modules) make sure that you install the same version=20
(stable 2.8 from git if you can) for all three.

I also requested access board on http://open-estuary.org/ to test it myse=
lf.

Cheers

> *shell log:*
>
> -bash-4.3# lttng -v create
>
> DEBUG1 - 00:03:59.845027 [2462/2462]: Auto session name set to=20
> auto-19700101-000359 (in create_session() at commands/create.c:249)
>
> DEBUG3 - 00:03:59.845136 [2462/2462]: URI string:=20
> file:///root/lttng-traces/auto-19700101-000359 (in uri_parse() at=20
> uri.c:292)
>
> DEBUG3 - 00:03:59.845198 [2462/2462]: URI file destination:=20
> /root/lttng-traces/auto-19700101-000359 (in uri_parse() at uri.c:329)
>
> DEBUG3 - 00:03:59.845223 [2462/2462]: URI dtype: 3, proto: 0, host: ,=20
> subdir: , ctrl: 0, data: 0 (in uri_parse() at uri.c:506)
>
> DEBUG1 - 00:03:59.845300 [2462/2462]: LSM cmd type : 8 (in=20
> send_session_msg() at lttng-ctl.c:135)
>
> Session auto-19700101-000359 created.
>
> Traces will be written in /root/lttng-traces/auto-19700101-000359
>
> DEBUG1 - 00:03:59.846076 [2462/2462]: Init config session in /root (in=20
> config_init() at conf.c:323)
>
> -bash-4.3# lttng -v enable-event -a -k
>
> DEBUG1 - 00:04:19.762761 [2463/2463]: Session name found:=20
> auto-19700101-000359 (in _get_session_name() at utils.c:64)
>
> DEBUG1 - 00:04:19.763042 [2463/2463]: LSM cmd type : 6 (in=20
> send_session_msg() at lttng-ctl.c:135)
>
>                                                      /////////////////t=
his=20
> step wait for many seconds ,but failed last
>
> Error: Events: Kernel consumer start failed (channel channel0, session=20
> auto-19700101-000359)
>
> Error: Command error
>
> DEBUG1 - 00:04:49.768267 [2463/2463]: Clean exit (in clean_exit() at=20
> lttng.c:149)
>
> *=E5=8F=91=E4=BB=B6=E4=BA=BA:*Jonathan Rajotte [mailto:jonathan.r.julie=
n@gmail.com]
> *=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4:*2016=E5=B9=B44=E6=9C=8815=E6=97=A5=
3:30
> *=E6=94=B6=E4=BB=B6=E4=BA=BA:*Lichuanbao
> *=E6=8A=84=E9=80=81:*Jonathan Rajotte Julien; lttng-dev@lists.lttng.org=
; Zhanweitao
> *=E4=B8=BB=E9=A2=98:*Re: [lttng-dev] =E7=AD=94=E5=A4=8D: lttng trace ke=
rnel on arm64
>
> Hi Lichuanbao
>
> On Tue, Apr 12, 2016 at 4:30 AM, Lichuanbao <lichuanbao@hisilicon.com=20
> <mailto:lichuanbao@hisilicon.com>> wrote:
>
> Hi Jonathan ,Thank you for your kind help
>
> >You got me curious: D02 ? D03 hisilicon board ? :)
> Ha. You know it? It's D02.
>
> From name hope to see one in flesh some day.
>
>
>     >Does "lttng list -k" return a list of events ?
>     Yes.it works,list many event name
>
> Then you have a live lttng-sessiond.
>
>
>     >This line suggest that another instance was running.
>     >Make sure to kill all lttng-sessiond instance before starting one =
to
>     >make sure you have the actual log of the used sessiond.
>
>
>     Yes ,I tried,reboot the board,and "ps -A|grep lttng" ,here is no
>     lttng session.
>     after " lttng create mysession ",there is an error " Error: Could
>     not get lock file /var/run/lttng/lttng-sessiond.lck, another
>     instance is running."
>     I used "2.8.0-rc1" version this time. Same problem.
>
>     Logs:
>
>     -bash-4.3# ps -A|grep lttng
>     -bash-4.3# lttng create mysession
>     Spawning a session daemon
>     Session mysession created.
>     Traces will be written in /root/lttng-traces/mysession-19700101-015=
353
>
> The following command "lttng-sessiond -vvv" will necessarily fail=20
> since the previous command " lttng create mysession" just spawned one.
>
> Could you try these on a rebooted board as root:
>
> (Make sure there is no sessiond running)
>
> lttng-sessiond -vvv > sessiond.log 2>&1
>
> lttng create
>
> lttng enable-event -a -k
>
> lttng start
>
> sleep 1
>
> lttng stop
>
> lttng view
>
> If on "lttng view" there is no events or any of the commands fail make=20
> sure to include their output and the sessiond.log file so we can=20
> pinpoint the problem.
>
>     -bash-4.3# lttng-sessiond -vvv
>     DEBUG1 - 01:54:06.834954 [2687/2687]: Resetting run_as worker
>     signal handlers to default (in reset_sighandler() at runas.c:536)
>     DEBUG1 - 01:54:06.835249 [2687/2687]: run_as signal handler set
>     for SIGTERM and SIGINT (in set_worker_sighandlers() at runas.c:593)
>     DEBUG1 - 01:54:06.835345 [2686/2686]: Health check time delta in
>     seconds set to 20 (in health_init() at health.c:73)
>     DEBUG1 - 01:54:06.835614 [2686/2686]: epoll set max size is
>     27037798 (in compat_epoll_set_max_size() at compat-epoll.c:288)
>     DEBUG3 - 01:54:06.835798 [2686/2686]: Creating LTTng run
>     directory: /var/run/lttng (in create_lttng_rundir() at main.c:5246)
>     DEBUG1 - 01:54:06.835812 [2686/2688]: [ht-thread] startup. (in
>     thread_ht_cleanup() at ht-cleanup.c:36)
>     DEBUG3 - 01:54:06.835979 [2686/2688]: [ht-thread] Polling. (in
>     thread_ht_cleanup() at ht-cleanup.c:66)
>     DEBUG2 - 01:54:06.835996 [2686/2686]: Kernel consumer err path:
>     /var/run/lttng/kconsumerd/error (in main() at main.c:5688)
>     DEBUG2 - 01:54:06.836145 [2686/2686]: Kernel consumer cmd path:
>     /var/run/lttng/kconsumerd/command (in main() at main.c:5690)
>     PERROR - 01:54:06.836251 [2686/2686]: fcntl lock file: Resource
>     temporarily unavailable (in utils_create_lock_file() at utils.c:541=
)
>     Error: Could not get lock file /var/run/lttng/lttng-sessiond.lck,
>     another instance is running.
>     DEBUG1 - 01:54:06.836379 [2686/2686]: Cleanup sessiond (in
>     sessiond_cleanup() at main.c:624)
>     DEBUG1 - 01:54:06.836456 [2686/2686]: Removing sessiond and
>     consumerd content of directory /var/run/lttng (in
>     sessiond_cleanup() at main.c:643)
>     DEBUG1 - 01:54:06.836514 [2686/2686]: Removing
>     /var/run/lttng/lttng-sessiond.pid (in sessiond_cleanup() at
>     main.c:649)
>     DEBUG1 - 01:54:06.836609 [2686/2686]: Removing
>     /var/run/lttng/agent.port (in sessiond_cleanup() at main.c:654)
>     DEBUG1 - 01:54:06.836719 [2686/2686]: Removing
>     /var/run/lttng/kconsumerd/error (in sessiond_cleanup() at main.c:66=
1)
>     DEBUG1 - 01:54:06.836805 [2686/2686]: Removing directory
>     /var/run/lttng/kconsumerd (in sessiond_cleanup() at main.c:667)
>     DEBUG1 - 01:54:06.836893 [2686/2686]: Removing
>     /var/run/lttng/ustconsumerd32/error (in sessiond_cleanup() at
>     main.c:674)
>     DEBUG1 - 01:54:06.836991 [2686/2686]: Removing directory
>     /var/run/lttng/ustconsumerd32 (in sessiond_cleanup() at main.c:680)
>     DEBUG1 - 01:54:06.837075 [2686/2686]: Removing
>     /var/run/lttng/ustconsumerd64/error (in sessiond_cleanup() at
>     main.c:687)
>     DEBUG1 - 01:54:06.837169 [2686/2686]: Removing directory
>     /var/run/lttng/ustconsumerd64 (in sessiond_cleanup() at main.c:693)
>     DEBUG1 - 01:54:06.837253 [2686/2686]: Cleaning up all sessions (in
>     sessiond_cleanup() at main.c:696)
>     DEBUG1 - 01:54:06.837331 [2686/2686]: Cleaning up all agent apps
>     (in sessiond_cleanup() at main.c:713)
>     DEBUG1 - 01:54:06.837397 [2686/2686]: Closing all UST sockets (in
>     sessiond_cleanup() at main.c:716)
>     DEBUG2 - 01:54:06.837488 [2686/2686]: UST app cleaning registered
>     apps hash table (in ust_app_clean_list() at ust-app.c:3818)
>     DEBUG3 - 01:54:06.846332 [2686/2686]: Buffer registry destroy all
>     registry (in buffer_reg_destroy_registries() at buffer-registry.c:7=
53)
>     DEBUG2 - 01:54:06.846414 [2686/2686]: Closing kernel fd (in
>     sessiond_cleanup() at main.c:721)
>     DEBUG1 - 01:54:06.846481 [2686/2686]: Unloading kernel modules (in
>     sessiond_cleanup() at main.c:728)
>     DEBUG1 - 01:54:06.892609 [2686/2686]: Modprobe removal successful
>     lttng-ring-buffer-metadata-mmap-client (in modprobe_remove_lttng()
>     at modprobe.c:371)
>     DEBUG1 - 01:54:06.940557 [2686/2686]: Modprobe removal successful
>     lttng-ring-buffer-client-mmap-overwrite (in
>     modprobe_remove_lttng() at modprobe.c:371)
>     DEBUG1 - 01:54:06.996528 [2686/2686]: Modprobe removal successful
>     lttng-ring-buffer-client-mmap-discard (in modprobe_remove_lttng()
>     at modprobe.c:371)
>     DEBUG1 - 01:54:07.405263 [2686/2686]: Modprobe removal successful
>     lttng-ring-buffer-metadata-client (in modprobe_remove_lttng() at
>     modprobe.c:371)
>     DEBUG1 - 01:54:07.805463 [2686/2686]: Modprobe removal successful
>     lttng-ring-buffer-client-overwrite (in modprobe_remove_lttng() at
>     modprobe.c:371)
>     DEBUG1 - 01:54:07.124584 [2686/2686]: Modprobe removal successful
>     lttng-ring-buffer-client-discard (in modprobe_remove_lttng() at
>     modprobe.c:371)
>     DEBUG3 - 01:54:07.124716 [2686/2688]: [ht-thread] Returning from
>     poll on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:73)
>     DEBUG1 - 01:54:07.124831 [2686/2688]: [ht-cleanup] quit. (in
>     thread_ht_cleanup() at ht-cleanup.c:152)
>     DEBUG1 - 01:54:07.124916 [2686/2688]: [ht-cleanup] Thread
>     terminates. (in thread_ht_cleanup() at ht-cleanup.c:163)
>     DEBUG1 - 01:54:07.125084 [2686/2686]: Cleaning up options (in
>     sessiond_cleanup_options() at main.c:775)
>     DEBUG1 - 01:54:07.125161 [2686/2686]: Destroying run_as worker (in
>     run_as_destroy_worker() at runas.c:705)
>     DEBUG1 - 01:54:07.125236 [2686/2686]: Closing run_as worker socket
>     (in run_as_destroy_worker() at runas.c:711)
>     DEBUG1 - 01:54:07.125343 [2687/2687]: run_as worker exiting (ret =3D
>     0) (in run_as_create_worker() at runas.c:655)
>     DEBUG1 - 01:54:07.126301 [2686/2686]: lttng-runas terminated with
>     status code 0 (in run_as_destroy_worker() at runas.c:733)
>     DEBUG1 - 01:54:07.126332 [2686/2686]: *** assert failed :-) ***
>     =3D=3D> Matthew, BEET driven development works! (in
>     sessiond_cleanup_options() at main.c:807)
>     -bash-4.3# ps -A|grep lttng
>      2582 ?        00:00:00 lttng-sessiond
>      2583 ?        00:00:00 lttng-runas
>     -bash-4.3# lttng list -k
>     Kernel events:
>     -------------
>           lttng_logger (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           block_touch_buffer (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           block_dirty_buffer (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           block_rq_abort (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           block_rq_requeue (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           block_rq_complete (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           block_rq_insert (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           block_rq_issue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           block_bio_bounce (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           block_bio_complete (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           block_bio_backmerge (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           block_bio_frontmerge (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           block_bio_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           block_getrq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           block_sleeprq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           block_plug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           block_unplug (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           block_split (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           block_bio_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           block_rq_remap (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           btrfs_transaction_commit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_inode_new (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           btrfs_inode_request (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_inode_evict (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           btrfs_get_extent (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           btrfs_ordered_extent_add (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_ordered_extent_remove (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           btrfs_ordered_extent_start (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           btrfs_ordered_extent_put (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs__extent_writepage (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_writepage_end_io_hook (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           btrfs_sync_file (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           btrfs_sync_fs (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           btrfs_delayed_tree_ref (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_delayed_data_ref (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_delayed_ref_head (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_chunk_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           btrfs_chunk_free (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           btrfs_cow_block (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           btrfs_space_reservation (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_reserved_extent_alloc (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           btrfs_reserved_extent_free (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           btrfs_find_free_extent (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_reserve_extent (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_reserve_extent_cluster (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           btrfs_find_cluster (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_failed_cluster_setup (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           btrfs_setup_cluster (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_alloc_extent_state (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           btrfs_free_extent_state (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           compaction_isolate_migratepages (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           compaction_isolate_freepages (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           compaction_migratepages (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_free_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           ext3_request_inode (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_allocate_inode (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_evict_inode (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           ext3_drop_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           ext3_mark_inode_dirty (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_write_begin (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           ext3_ordered_write_end (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_writeback_write_end (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_journalled_write_end (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_ordered_writepage (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_writeback_writepage (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_journalled_writepage (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_readpage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           ext3_releasepage (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           ext3_invalidatepage (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_discard_blocks (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_request_blocks (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_allocate_blocks (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_free_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           ext3_sync_file_enter (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_sync_file_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_sync_fs (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           ext3_rsv_window_add (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_discard_reservation (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_alloc_new_reservation (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           ext3_reserved (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           ext3_forget (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           ext3_read_block_bitmap (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_direct_IO_enter (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_direct_IO_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_unlink_enter (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           ext3_unlink_exit (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           ext3_truncate_enter (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_truncate_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_get_blocks_enter (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_get_blocks_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext3_load_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           ext4_free_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           ext4_request_inode (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_allocate_inode (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_evict_inode (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           ext4_drop_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           ext4_mark_inode_dirty (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_begin_ordered_truncate (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           ext4_write_begin (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           ext4_da_write_begin (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_ordered_write_end (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_writeback_write_end (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_journalled_write_end (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_da_write_end (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           ext4_da_writepages (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_da_write_pages (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_da_write_pages_extent (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           ext4_da_writepages_result (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_writepage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           ext4_readpage (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           ext4_releasepage (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           ext4_invalidatepage (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_journalled_invalidatepage (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           ext4_discard_blocks (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_mb_new_inode_pa (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_mb_new_group_pa (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_mb_release_inode_pa (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_mb_release_group_pa (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_discard_preallocations (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           ext4_mb_discard_preallocations (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           ext4_request_blocks (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_allocate_blocks (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_free_blocks (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           ext4_sync_file_enter (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_sync_file_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_sync_fs (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           ext4_alloc_da_blocks (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_mballoc_alloc (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_mballoc_prealloc (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_mballoc_discard (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_mballoc_free (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           ext4_forget (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           ext4_da_update_reserve_space (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           ext4_da_reserve_space (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_da_release_space (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_mb_bitmap_load (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_mb_buddy_bitmap_load (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_read_block_bitmap_load (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           ext4_load_inode_bitmap (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_direct_IO_enter (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_direct_IO_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_fallocate_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_fallocate_enter (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_punch_hole (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           ext4_zero_range (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           ext4_unlink_enter (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           ext4_unlink_exit (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           ext4_truncate_enter (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_truncate_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_ext_convert_to_initialized_enter (loglevel: TRACE_EMERG
>     (0)) (type: tracepoint)
>           ext4_ext_convert_to_initialized_fastpath (loglevel:
>     TRACE_EMERG (0)) (type: tracepoint)
>           ext4_ext_map_blocks_enter (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_ind_map_blocks_enter (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_ext_map_blocks_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_ind_map_blocks_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_ext_load_extent (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_load_inode (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           ext4_journal_start (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_journal_start_reserved (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           ext4_ext_handle_uninitialized_extents (loglevel: TRACE_EMERG
>     (0)) (type: tracepoint)
>           ext4_get_implied_cluster_alloc_exit (loglevel: TRACE_EMERG
>     (0)) (type: tracepoint)
>           ext4_ext_put_in_cache (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_ext_in_cache (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           ext4_find_delalloc_range (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_get_reserved_cluster_alloc (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           ext4_ext_show_extent (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_remove_blocks (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_ext_rm_leaf (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           ext4_ext_rm_idx (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           ext4_ext_remove_space (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_ext_remove_space_done (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           ext4_es_insert_extent (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           ext4_es_cache_extent (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           gpio_direction (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           gpio_value (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           irq_handler_entry (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           irq_handler_exit (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           irq_softirq_entry (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           irq_softirq_exit (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           irq_softirq_raise (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           jbd_checkpoint (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           jbd_start_commit (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           jbd_commit_locking (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd_commit_flushing (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd_commit_logging (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd_drop_transaction (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd_end_commit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           jbd_do_submit_data (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd_cleanup_journal_tail (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd_journal_write_superblock (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           jbd2_checkpoint (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           jbd2_start_commit (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           jbd2_commit_locking (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd2_commit_flushing (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd2_commit_logging (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd2_drop_transaction (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd2_end_commit (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           jbd2_submit_inode_data (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd2_run_stats (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           jbd2_checkpoint_stats (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd2_update_log_tail (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           jbd2_write_superblock (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           kmem_kmalloc (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           kmem_cache_alloc (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           kmem_kmalloc_node (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           kmem_cache_alloc_node (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           kmem_kfree (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           kmem_cache_free (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           kmem_mm_page_free (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           kmem_mm_page_free_batched (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           kmem_mm_page_alloc (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           kmem_mm_page_alloc_zone_locked (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           kmem_mm_page_pcpu_drain (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           kmem_mm_page_alloc_extfrag (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           kvm_userspace_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           kvm_set_irq (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           kvm_mmio (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           kvm_fpu (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           kvm_age_page (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           module_load (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           module_free (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           module_get (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           module_put (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           module_request (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           napi_poll (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           net_dev_xmit (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           net_dev_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           net_if_receive_skb (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           net_if_rx (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           power_cpu_idle (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           power_cpu_frequency (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           power_machine_suspend (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           power_wakeup_source_activate (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           power_wakeup_source_deactivate (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           power_clock_enable (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           power_clock_disable (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           power_clock_set_rate (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           power_domain_target (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           printk_console (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           random_mix_pool_bytes (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           random_mix_pool_bytes_nolock (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           random_credit_entropy_bits (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           random_get_random_bytes (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           random_extract_entropy (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           random_extract_entropy_user (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           rcu_utilization (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           regmap_reg_write (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           regmap_reg_read (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           regmap_reg_read_cache (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           regmap_hw_read_start (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           regmap_hw_read_done (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           regmap_hw_write_start (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           regmap_hw_write_done (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           regmap_regcache_sync (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           regmap_cache_only (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           regmap_cache_bypass (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           regulator_enable (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           regulator_enable_delay (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           regulator_enable_complete (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           regulator_disable (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           regulator_disable_complete (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           regulator_set_voltage (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           regulator_set_voltage_complete (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           sched_kthread_stop (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sched_kthread_stop_ret (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sched_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           sched_wakeup_new (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           sched_switch (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           sched_migrate_task (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sched_process_free (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sched_process_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sched_wait_task (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           sched_process_wait (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sched_process_fork (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sched_process_exec (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sched_stat_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           sched_stat_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           sched_stat_iowait (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           sched_stat_blocked (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sched_stat_runtime (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sched_pi_setprio (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           scsi_dispatch_cmd_start (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           scsi_dispatch_cmd_error (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           scsi_dispatch_cmd_done (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           scsi_dispatch_cmd_timeout (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           scsi_eh_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           signal_generate (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           signal_deliver (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           skb_kfree (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           skb_consume (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           skb_copy_datagram_iovec (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sock_rcvqueue_full (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           sock_exceed_buf_limit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           lttng_statedump_start (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           lttng_statedump_end (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           lttng_statedump_process_state (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           lttng_statedump_file_descriptor (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           lttng_statedump_vm_map (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           lttng_statedump_network_interface (loglevel: TRACE_EMERG
>     (0)) (type: tracepoint)
>           lttng_statedump_block_device (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           lttng_statedump_interrupt (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           rpc_call_status (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           rpc_bind_status (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           rpc_connect_status (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           rpc_task_begin (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           rpc_task_run_action (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           rpc_task_complete (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           rpc_task_sleep (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           rpc_task_wakeup (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           timer_init (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           timer_start (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           timer_expire_entry (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           timer_expire_exit (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           timer_cancel (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           timer_hrtimer_init (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           timer_hrtimer_start (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           timer_hrtimer_expire_entry (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           timer_hrtimer_expire_exit (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           timer_hrtimer_cancel (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           timer_itimer_state (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           timer_itimer_expire (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           udp_fail_queue_rcv_skb (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           mm_vmscan_kswapd_sleep (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           mm_vmscan_kswapd_wake (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           mm_vmscan_wakeup_kswapd (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           mm_vmscan_direct_reclaim_begin (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           mm_vmscan_memcg_reclaim_begin (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           mm_vmscan_memcg_softlimit_reclaim_begin (loglevel:
>     TRACE_EMERG (0)) (type: tracepoint)
>           mm_vmscan_direct_reclaim_end (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           mm_vmscan_memcg_reclaim_end (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           mm_vmscan_memcg_softlimit_reclaim_end (loglevel: TRACE_EMERG
>     (0)) (type: tracepoint)
>           mm_vmscan_shrink_slab_start (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           mm_vmscan_shrink_slab_end (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           mm_vmscan_lru_isolate (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           mm_vmscan_memcg_isolate (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           mm_vmscan_writepage (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           mm_vmscan_lru_shrink_inactive (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           workqueue_queue_work (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           workqueue_activate_work (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           workqueue_execute_start (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           workqueue_execute_end (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_dirty_page (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_dirty_inode_start (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           writeback_dirty_inode (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_mark_inode_dirty (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           writeback_write_inode_start (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           writeback_write_inode (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_nothread (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_queue (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           writeback_exec (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           writeback_start (loglevel: TRACE_EMERG (0)) (type: tracepoint=
)
>           writeback_written (loglevel: TRACE_EMERG (0)) (type: tracepoi=
nt)
>           writeback_wait (loglevel: TRACE_EMERG (0)) (type: tracepoint)
>           writeback_pages_written (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_bdi_register (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_nowork (loglevel: TRACE_EMERG (0)) (type: tracepoin=
t)
>           writeback_wake_background (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_wake_thread (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_wake_forker_thread (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           writeback_bdi_unregister (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_thread_start (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_thread_stop (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_wbc_writepage (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_queue_io (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_global_dirty_state (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           writeback_bdi_dirty_ratelimit (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           writeback_balance_dirty_pages (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           writeback_sb_inodes_requeue (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           writeback_congestion_wait (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>           writeback_wait_iff_congested (loglevel: TRACE_EMERG (0))
>     (type: tracepoint)
>           writeback_single_inode (loglevel: TRACE_EMERG (0)) (type:
>     tracepoint)
>
>
>
>     -----=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6-----
>     =E5=8F=91=E4=BB=B6=E4=BA=BA: lttng-dev [mailto:lttng-dev-bounces@li=
sts.lttng.org
>     <mailto:lttng-dev-bounces@lists.lttng.org>] =E4=BB=A3=E8=A1=A8Jonat=
han Rajotte
>     Julien
>     =E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4: 2016=E5=B9=B44=E6=9C=8811=E6=97=
=A522:14
>     =E6=94=B6=E4=BB=B6=E4=BA=BA: lttng-dev@lists.lttng.org <mailto:lttn=
g-dev@lists.lttng.org>
>     =E4=B8=BB=E9=A2=98: Re: [lttng-dev] lttng trace kernel on arm64
>
>
>     Hi,
>
>     On 2016-04-08 02:28 AM, Lichuanbao wrote:
>     >
>     > Hi,
>     >
>     >    I want to use lttng trace kernel event,I installed lttng-tools
>     > 2.7.1 lttng-ust 2.7.2 lttng-modules 2.7.2 on my arm64 board,
>     >
>
>     You got me curious: D02 ? D03 hisilicon board ? :)
>
>     > And then I create my session like sub command as root,but there i=
s
>     > nothing result to view.
>     >
>     >     # lttng create
>     >
>     >     # lttng enable-event --kernel --all
>     >
>     >     # lttng start
>     >
>     >     # sleep 10       # let the system generate some activity
>     >
>     >     # lttng stop
>     >
>     >     # lttng view
>     >
>     > # lttng destroy
>     >
>
>     Does "lttng list -k" return a list of events ?
>
>     > -bash-4.3# lttng view
>     >
>     > Trace directory: /root/lttng-traces/auto-20160407-211248
>     >
>     > [error] Cannot open any trace for reading.
>     >
>     > [error] opening trace "/root/lttng-traces/auto-20160407-211248" f=
or
>     > reading.
>     >
>     > [error] none of the specified trace paths could be opened.
>     >
>     > Get thes session daemon log as follow:
>     >
>     > bash-4.3# lttng-sessiond -vvv
>     >
>     > DEBUG1 - 21:52:15.396991 [5621/5621]: run_as signal handler set f=
or
>     > SIGTERM and SIGINT (in set_worker_sighandlers() at runas.c:600)
>     >
>     > DEBUG1 - 21:52:15.397410 [5620/5620]: Health check time delta in
>     > seconds set to 20 (in health_init() at health.c:74)
>     >
>     > DEBUG1 - 21:52:15.397661 [5620/5620]: epoll set max size is 27037=
798
>     > (in compat_epoll_set_max_size() at compat-epoll.c:290)
>     >
>     > DEBUG3 - 21:52:15.397838 [5620/5620]: Creating LTTng run director=
y:
>     > /var/run/lttng (in create_lttng_rundir() at main.c:5156)
>     >
>     > DEBUG1 - 21:52:15.397852 [5620/5622]: [ht-thread] startup. (in
>     > thread_ht_cleanup() at ht-cleanup.c:37)
>     >
>     > DEBUG2 - 21:52:15.397986 [5620/5620]: Kernel consumer err path:
>     > /var/run/lttng/kconsumerd/error (in main() at main.c:5601)
>     >
>     > DEBUG2 - 21:52:15.398070 [5620/5620]: Kernel consumer cmd path:
>     > /var/run/lttng/kconsumerd/command (in main() at main.c:5603)
>     >
>     > DEBUG3 - 21:52:15.398034 [5620/5622]: [ht-thread] Polling. (in
>     > thread_ht_cleanup() at ht-cleanup.c:67)
>     >
>     > Error: Could not get lock file /var/run/lttng/lttng-sessiond.lck,
>     > another instance is running.
>     >
>
>     This line suggest that another instance was running.
>
>     Make sure to kill all lttng-sessiond instance before starting one t=
o
>     make sure you have the actual log of the used sessiond.
>
>     Cheers
>
>
>     > DEBUG1 - 21:52:15.398240 [5620/5620]: Cleanup sessiond (in
>     > sessiond_cleanup() at main.c:622)
>     >
>     > DEBUG1 - 21:52:15.398294 [5620/5620]: Removing sessiond and
>     consumerd
>     > content of directory /var/run/lttng (in sessiond_cleanup() at
>     main.c:641)
>     >
>     > DEBUG1 - 21:52:15.398321 [5620/5620]: Removing
>     > /var/run/lttng/lttng-sessiond.pid (in sessiond_cleanup() at
>     main.c:647)
>     >
>     > DEBUG1 - 21:52:15.398372 [5620/5620]: Removing
>     > /var/run/lttng/agent.port (in sessiond_cleanup() at main.c:652)
>     >
>     > DEBUG1 - 21:52:15.398420 [5620/5620]: Removing
>     > /var/run/lttng/kconsumerd/error (in sessiond_cleanup() at
>     main.c:659)
>     >
>     > DEBUG1 - 21:52:15.398472 [5620/5620]: Removing directory
>     > /var/run/lttng/kconsumerd (in sessiond_cleanup() at main.c:665)
>     >
>     > DEBUG1 - 21:52:15.398526 [5620/5620]: Removing
>     > /var/run/lttng/ustconsumerd32/error (in sessiond_cleanup() at
>     main.c:672)
>     >
>     > DEBUG1 - 21:52:15.398579 [5620/5620]: Removing directory
>     > /var/run/lttng/ustconsumerd32 (in sessiond_cleanup() at main.c:67=
8)
>     >
>     > DEBUG1 - 21:52:15.398620 [5620/5620]: Removing
>     > /var/run/lttng/ustconsumerd64/error (in sessiond_cleanup() at
>     main.c:685)
>     >
>     > DEBUG1 - 21:52:15.398673 [5620/5620]: Removing directory
>     > /var/run/lttng/ustconsumerd64 (in sessiond_cleanup() at main.c:69=
1)
>     >
>     > DEBUG1 - 21:52:15.398734 [5620/5620]: Cleaning up all sessions (i=
n
>     > sessiond_cleanup() at main.c:694)
>     >
>     > DEBUG1 - 21:52:15.398765 [5620/5620]: Cleaning up all agent apps =
(in
>     > sessiond_cleanup() at main.c:711)
>     >
>     > DEBUG1 - 21:52:15.398789 [5620/5620]: Closing all UST sockets (in
>     > sessiond_cleanup() at main.c:714)
>     >
>     > DEBUG2 - 21:52:15.398813 [5620/5620]: UST app cleaning
>     registered apps
>     > hash table (in ust_app_clean_list() at ust-app.c:3702)
>     >
>     > DEBUG3 - 21:52:15.398837 [5620/5620]: Buffer registry destroy all
>     > registry (in buffer_reg_destroy_registries() at
>     buffer-registry.c:716)
>     >
>     > DEBUG2 - 21:52:15.398861 [5620/5620]: Closing kernel fd (in
>     > sessiond_cleanup() at main.c:719)
>     >
>     > DEBUG1 - 21:52:15.398884 [5620/5620]: Unloading kernel modules (i=
n
>     > sessiond_cleanup() at main.c:726)
>     >
>     > DEBUG1 - 21:52:15.403580 [5620/5620]: Modprobe removal successful
>     > lttng-kretprobes (in modprobe_remove_lttng() at modprobe.c:126)
>     >
>     > DEBUG1 - 21:52:15.407855 [5620/5620]: Modprobe removal successful
>     > lttng-kprobes (in modprobe_remove_lttng() at modprobe.c:126)
>     >
>     > DEBUG1 - 21:52:15.412073 [5620/5620]: Modprobe removal successful
>     > lttng-ftrace (in modprobe_remove_lttng() at modprobe.c:126)
>     >
>     > DEBUG1 - 21:52:15.416256 [5620/5620]: Modprobe removal successful
>     > lttng-types (in modprobe_remove_lttng() at modprobe.c:126)
>     >
>     > DEBUG1 - 21:52:15.420593 [5620/5620]: Modprobe removal successful
>     > lttng-ring-buffer-metadata-mmap-client (in
>     modprobe_remove_lttng() at
>     > modprobe.c:126)
>     >
>     > DEBUG1 - 21:52:15.425108 [5620/5620]: Modprobe removal successful
>     > lttng-ring-buffer-client-mmap-overwrite (in
>     modprobe_remove_lttng() at
>     > modprobe.c:126)
>     >
>     > DEBUG1 - 21:52:15.429745 [5620/5620]: Modprobe removal successful
>     > lttng-ring-buffer-client-mmap-discard (in modprobe_remove_lttng()=
 at
>     > modprobe.c:126)
>     >
>     > Error: Unable to remove module lttng-ring-buffer-metadata-client
>     >
>     > DEBUG1 - 21:52:15.438779 [5620/5620]: Modprobe removal successful
>     > lttng-ring-buffer-client-overwrite (in modprobe_remove_lttng() at
>     > modprobe.c:126)
>     >
>     > Error: Unable to remove module lttng-ring-buffer-client-discard
>     >
>     > Error: Unable to remove module lttng-lib-ring-buffer
>     >
>     > Error: Unable to remove module lttng-tracer
>     >
>     > DEBUG3 - 21:52:15.452135 [5620/5622]: [ht-thread] Returning from
>     poll
>     > on 2 fds. (in thread_ht_cleanup() at ht-cleanup.c:74)
>     >
>     > DEBUG1 - 21:52:15.452186 [5620/5622]: [ht-cleanup] quit. (in
>     > thread_ht_cleanup() at ht-cleanup.c:153)
>     >
>     > DEBUG1 - 21:52:15.452225 [5620/5622]: [ht-cleanup] Thread
>     terminates.
>     > (in thread_ht_cleanup() at ht-cleanup.c:164)
>     >
>     > DEBUG1 - 21:52:15.452333 [5620/5620]: Cleaning up options (in
>     > sessiond_cleanup_options() at main.c:773)
>     >
>     > DEBUG1 - 21:52:15.453308 [5620/5620]: lttng-runas terminated with
>     > status code 0 (in run_as_destroy_worker() at runas.c:737)
>     >
>     > DEBUG1 - 21:52:15.453349 [5620/5620]: *** assert failed :-) *** =3D=
=3D>
>     > Matthew, BEET driven development works! (in
>     sessiond_cleanup_options()
>     > at main.c:805)
>     >
>     > can anybody help me ?
>     >
>     > thanks very much.
>     >
>     > lichuanbao
>     >
>     > ShenZhen in China
>     >
>     >
>     >
>     > _______________________________________________
>     > lttng-dev mailing list
>     > lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>     > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>     --
>     Jonathan R. Julien
>     Efficios
>
>     _______________________________________________
>     lttng-dev mailing list
>     lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>     https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>     _______________________________________________
>     lttng-dev mailing list
>     lttng-dev@lists.lttng.org <mailto:lttng-dev@lists.lttng.org>
>     https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
>
> --=20
>
> Jonathan Rajotte Julien
>

--=20
Jonathan R. Julien
Efficios


--------------050907000301070402070901
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta content=3D"text/html; charset=3DUTF-8" http-equiv=3D"Content-Ty=
pe">
  </head>
  <body>
    <br>
    <br>
    <div class=3D"moz-cite-prefix">On 2016-04-16 08:27 AM, Lichuanbao
      wrote:<br>
    </div>
    <blockquote
cite=3D"mid:BECE94944F67D640AA66E9BA499F7CE853A15185@SZXEMA509-MBX.china.=
huawei.com"
      type=3D"cite">
      <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DU=
TF-8">
      <meta name=3D"Generator" content=3D"Microsoft Word 12 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:=E5=AE=8B=E4=BD=93;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@=E5=AE=8B=E4=BD=93";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:=E5=AE=8B=E4=BD=93;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"=E6=89=B9=E6=B3=A8=E6=A1=86=E6=96=87=E6=9C=AC Char";
	margin:0cm;
	margin-bottom:.0001pt;
	font-size:9.0pt;
	font-family:=E5=AE=8B=E4=BD=93;}
span.Char
	{mso-style-name:"=E6=89=B9=E6=B3=A8=E6=A1=86=E6=96=87=E6=9C=AC Char";
	mso-style-priority:99;
	mso-style-link:=E6=89=B9=E6=B3=A8=E6=A1=86=E6=96=87=E6=9C=AC;
	font-family:=E5=AE=8B=E4=BD=93;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 90.0pt 72.0pt 90.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Jonathan<o:p></o:p=
></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Glad to see your word=
s
            again! <o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;From name hope to
            see one in flesh some day.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">I also hope one day t=
o
            ask when facing you
            <o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">You are not intereste=
d
            in me ,right? haha( =E2=80=B5=E2=96=BD=E2=80=B2)=CF=88<o:p></=
o:p></span></p>
        <p class=3D"MsoNormal"><span
style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-seri=
f&quot;;color:#1F497D"
            lang=3D"EN-US"><o:p>=C2=A0</o:p></span></p>
        <p class=3D"MsoNormal"><span
style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-seri=
f&quot;;color:#1F497D"
            lang=3D"EN-US"><o:p>=C2=A0</o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;The following
            command "lttng-sessiond -vvv" will necessarily fail since
            the previous command "=C2=A0lttng create mysession" just spaw=
ned
            one.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;Could you try the=
se
            on a rebooted board as root:<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;(Make sure there =
is
            no sessiond running)<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;lttng-sessiond -v=
vv
            &gt; sessiond.log 2&gt;&amp;1<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;lttng create=C2=A0=
<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;lttng enable-even=
t
            -a -k<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;lttng start<o:p><=
/o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;sleep 1<o:p></o:p=
></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;lttng stop<o:p></=
o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;lttng view<o:p></=
o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">&gt;If on "lttng view=
"
            there is no events or any of the commands fail make sure to
            include their output and the sessiond.log file so we can
            pinpoint the problem.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Yes,Step by step
            according to your cmd:<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">The session.log view
            attachments.there are some error as flow, I installed
            lttng-ust already:<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">lttng-consumerd: erro=
r
            while loading shared libraries: liblttng-ust-ctl.so.2:
            cannot open shared object file: No such file or directory<o:p=
></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Error: Condition time=
d
            out. The consumer thread was never ready. Killing it<o:p></o:=
p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Error: Fatal error
            spawning consumer control thread</span></p>
      </div>
    </blockquote>
    Could you do a search for this file and make sure it exist ?<br>
    <br>
    Also it might be a good idea to uninstall everything (lttng-ust,
    lttng-tools, lttng-modules) make sure that you install the same
    version (stable 2.8 from git if you can) for all three.<br>
    <br>
    I also requested access board on <a class=3D"moz-txt-link-freetext" h=
ref=3D"http://open-estuary.org/">http://open-estuary.org/</a> to test it
    myself.<br>
    <br>
    Cheers<br>
    <br>
    <blockquote
cite=3D"mid:BECE94944F67D640AA66E9BA499F7CE853A15185@SZXEMA509-MBX.china.=
huawei.com"
      type=3D"cite">
      <div class=3D"WordSection1">
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p></o:p></span></p=
>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><b><span lang=3D"EN-US">shell log:<o:p></o=
:p></span></b></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">-bash-4.3# lttng -v
            create=C2=A0=C2=A0 <o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 00:03:59.845=
027
            [2462/2462]: Auto session name set to auto-19700101-000359
            (in create_session() at commands/create.c:249)<o:p></o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 - 00:03:59.845=
136
            [2462/2462]: URI string:
            <a class=3D"moz-txt-link-freetext" href=3D"file:///root/lttng=
-traces/auto-19700101-000359">file:///root/lttng-traces/auto-19700101-000=
359</a> (in
            uri_parse() at uri.c:292)<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 - 00:03:59.845=
198
            [2462/2462]: URI file destination:
            /root/lttng-traces/auto-19700101-000359 (in uri_parse() at
            uri.c:329)<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG3 - 00:03:59.845=
223
            [2462/2462]: URI dtype: 3, proto: 0, host: , subdir: , ctrl:
            0, data: 0 (in uri_parse() at uri.c:506)<o:p></o:p></span></p=
>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 00:03:59.845=
300
            [2462/2462]: LSM cmd type : 8 (in send_session_msg() at
            lttng-ctl.c:135)<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Session
            auto-19700101-000359 created.<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Traces will be writte=
n
            in /root/lttng-traces/auto-19700101-000359<o:p></o:p></span><=
/p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 00:03:59.846=
076
            [2462/2462]: Init config session in /root (in config_init()
            at conf.c:323)<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">-bash-4.3# lttng -v
            enable-event -a -k<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 00:04:19.762=
761
            [2463/2463]: Session name found: auto-19700101-000359 (in
            _get_session_name() at utils.c:64)<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 00:04:19.763=
042
            [2463/2463]: LSM cmd type : 6 (in send_session_msg() at
            lttng-ctl.c:135)<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
            =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/////////////////this
            step wait for many seconds ,but failed last<o:p></o:p></span>=
</p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Error: Events: Kernel
            consumer start failed (channel channel0, session
            auto-19700101-000359)<o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">Error: Command error<=
o:p></o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US">DEBUG1 - 00:04:49.768=
267
            [2463/2463]: Clean exit (in clean_exit() at lttng.c:149)<o:p>=
</o:p></span></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:p></sp=
an></p>
        <p class=3D"MsoNormal"><span
style=3D"font-size:10.5pt;font-family:&quot;Calibri&quot;,&quot;sans-seri=
f&quot;;color:#1F497D"
            lang=3D"EN-US"><o:p>=C2=A0</o:p></span></p>
        <div style=3D"border:none;border-top:solid #B5C4DF
          1.0pt;padding:3.0pt 0cm 0cm 0cm">
          <p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt">=E5=8F=
=91=E4=BB=B6=E4=BA=BA<span
                  lang=3D"EN-US">:</span></span></b><span
              style=3D"font-size:10.0pt" lang=3D"EN-US"> Jonathan Rajotte
              [<a class=3D"moz-txt-link-freetext" href=3D"mailto:jonathan=
.r.julien@gmail.com">mailto:jonathan.r.julien@gmail.com</a>]
              <br>
            </span><b><span style=3D"font-size:10.0pt">=E5=8F=91=E9=80=81=
=E6=97=B6=E9=97=B4<span
                  lang=3D"EN-US">:</span></span></b><span
              style=3D"font-size:10.0pt" lang=3D"EN-US"> 2016</span><span
              style=3D"font-size:10.0pt">=E5=B9=B4<span lang=3D"EN-US">4<=
/span>=E6=9C=88<span
                lang=3D"EN-US">15</span>=E6=97=A5<span lang=3D"EN-US"> 3:=
30<br>
              </span><b>=E6=94=B6=E4=BB=B6=E4=BA=BA<span lang=3D"EN-US">:=
</span></b><span
                lang=3D"EN-US"> Lichuanbao<br>
              </span><b>=E6=8A=84=E9=80=81<span lang=3D"EN-US">:</span></=
b><span
                lang=3D"EN-US"> Jonathan Rajotte Julien;
                <a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttn=
g-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a>; Zhanweitao<br>
              </span><b>=E4=B8=BB=E9=A2=98<span lang=3D"EN-US">:</span></=
b><span
                lang=3D"EN-US"> Re: [lttng-dev] </span>
              =E7=AD=94=E5=A4=8D<span lang=3D"EN-US">: lttng trace kernel=
 on arm64<o:p></o:p></span></span></p>
        </div>
        <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:p></sp=
an></p>
        <div>
          <p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Lichuanbao<o:p><=
/o:p></span></p>
          <div>
            <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:p>=
</span></p>
            <div>
              <p class=3D"MsoNormal"><span lang=3D"EN-US">On Tue, Apr 12,
                  2016 at 4:30 AM, Lichuanbao &lt;<a
                    moz-do-not-send=3D"true"
                    href=3D"mailto:lichuanbao@hisilicon.com"
                    target=3D"_blank"><a class=3D"moz-txt-link-abbreviate=
d" href=3D"mailto:lichuanbao@hisilicon.com">lichuanbao@hisilicon.com</a><=
/a>&gt;
                  wrote:<o:p></o:p></span></p>
              <p class=3D"MsoNormal"><span lang=3D"EN-US">Hi Jonathan ,Th=
ank
                  you for your kind help<br>
                  <br>
                  &gt;You got me curious: D02 ? D03 hisilicon board ? :)<=
br>
                  Ha. You know it? It's D02.<o:p></o:p></span></p>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</=
o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">From name hop=
e
                    to see one in flesh some day.<o:p></o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</=
o:p></span></p>
              </div>
              <blockquote style=3D"border:none;border-left:solid #CCCCCC
                1.0pt;padding:0cm 0cm 0cm
                6.0pt;margin-left:4.8pt;margin-right:0cm">
                <p class=3D"MsoNormal"><span lang=3D"EN-US"><br>
                    &gt;Does "lttng list -k" return a list of events ?<br=
>
                    Yes.it works,list many event name<o:p></o:p></span></=
p>
              </blockquote>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</=
o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">Then you have=
 a
                    live lttng-sessiond.<o:p></o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0<o:p></=
o:p></span></p>
              </div>
              <blockquote style=3D"border:none;border-left:solid #CCCCCC
                1.0pt;padding:0cm 0cm 0cm
                6.0pt;margin-left:4.8pt;margin-right:0cm">
                <p class=3D"MsoNormal"><span lang=3D"EN-US"><br>
                    &gt;This line suggest that another instance was
                    running.<br>
                    &gt;Make sure to kill all lttng-sessiond instance
                    before starting one to<br>
                    &gt;make sure you have the actual log of the used
                    sessiond.<br>
                    <br>
                    <br>
                    Yes ,I tried,reboot the board,and "ps -A|grep lttng"
                    ,here is no lttng session.<br>
                    after " lttng create mysession ",there is an error "
                    Error: Could not get lock file
                    /var/run/lttng/lttng-sessiond.lck, another instance
                    is running."<br>
                    I used "2.8.0-rc1" version this time. Same problem.<b=
r>
                    <br>
                    Logs:<br>
                    <br>
                    -bash-4.3# ps -A|grep lttng<br>
                    -bash-4.3# lttng create mysession<br>
                    Spawning a session daemon<br>
                    Session mysession created.<br>
                    Traces will be written in
                    /root/lttng-traces/mysession-19700101-015353<o:p></o:=
p></span></p>
              </blockquote>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</=
o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">The following
                    command "lttng-sessiond -vvv" will necessarily fail
                    since the previous command "=C2=A0lttng create mysess=
ion"
                    just spawned one.<o:p></o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</=
o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">Could you try
                    these on a rebooted board as root:<o:p></o:p></span><=
/p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</=
o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">(Make sure th=
ere
                    is no sessiond running)<o:p></o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</=
o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">lttng-session=
d
                    -vvv &gt; sessiond.log 2&gt;&amp;1<o:p></o:p></span><=
/p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">lttng create=C2=
=A0<o:p></o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">lttng
                    enable-event -a -k<o:p></o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">lttng start<o=
:p></o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">sleep 1<o:p><=
/o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">lttng stop<o:=
p></o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">lttng view<o:=
p></o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</=
o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">If on "lttng
                    view" there is no events or any of the commands fail
                    make sure to include their output and the
                    sessiond.log file so we can pinpoint the problem.<o:p=
></o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</=
o:p></span></p>
              </div>
              <div>
                <p class=3D"MsoNormal"><span lang=3D"EN-US">=C2=A0<o:p></=
o:p></span></p>
              </div>
              <blockquote style=3D"border:none;border-left:solid #CCCCCC
                1.0pt;padding:0cm 0cm 0cm
                6.0pt;margin-left:4.8pt;margin-right:0cm">
                <p class=3D"MsoNormal"><span lang=3D"EN-US">-bash-4.3#
                    lttng-sessiond -vvv<br>
                    DEBUG1 - 01:54:06.834954 [2687/2687]: Resetting
                    run_as worker signal handlers to default (in
                    reset_sighandler() at runas.c:536)<br>
                    DEBUG1 - 01:54:06.835249 [2687/2687]: run_as signal
                    handler set for SIGTERM and SIGINT (in
                    set_worker_sighandlers() at runas.c:593)<br>
                    DEBUG1 - 01:54:06.835345 [2686/2686]: Health check
                    time delta in seconds set to 20 (in health_init() at
                    health.c:73)<br>
                    DEBUG1 - 01:54:06.835614 [2686/2686]: epoll set max
                    size is 27037798 (in compat_epoll_set_max_size() at
                    compat-epoll.c:288)<br>
                    DEBUG3 - 01:54:06.835798 [2686/2686]: Creating LTTng
                    run directory: /var/run/lttng (in
                    create_lttng_rundir() at main.c:5246)<br>
                    DEBUG1 - 01:54:06.835812 [2686/2688]: [ht-thread]
                    startup. (in thread_ht_cleanup() at ht-cleanup.c:36)<=
br>
                    DEBUG3 - 01:54:06.835979 [2686/2688]: [ht-thread]
                    Polling. (in thread_ht_cleanup() at ht-cleanup.c:66)<=
br>
                    DEBUG2 - 01:54:06.835996 [2686/2686]: Kernel
                    consumer err path: /var/run/lttng/kconsumerd/error
                    (in main() at main.c:5688)<br>
                    DEBUG2 - 01:54:06.836145 [2686/2686]: Kernel
                    consumer cmd path: /var/run/lttng/kconsumerd/command
                    (in main() at main.c:5690)<br>
                    PERROR - 01:54:06.836251 [2686/2686]: fcntl lock
                    file: Resource temporarily unavailable (in
                    utils_create_lock_file() at utils.c:541)<br>
                    Error: Could not get lock file
                    /var/run/lttng/lttng-sessiond.lck, another instance
                    is running.<br>
                    DEBUG1 - 01:54:06.836379 [2686/2686]: Cleanup
                    sessiond (in sessiond_cleanup() at main.c:624)<br>
                    DEBUG1 - 01:54:06.836456 [2686/2686]: Removing
                    sessiond and consumerd content of directory
                    /var/run/lttng (in sessiond_cleanup() at main.c:643)<=
br>
                    DEBUG1 - 01:54:06.836514 [2686/2686]: Removing
                    /var/run/lttng/lttng-sessiond.pid (in
                    sessiond_cleanup() at main.c:649)<br>
                    DEBUG1 - 01:54:06.836609 [2686/2686]: Removing
                    /var/run/lttng/agent.port (in sessiond_cleanup() at
                    main.c:654)<br>
                    DEBUG1 - 01:54:06.836719 [2686/2686]: Removing
                    /var/run/lttng/kconsumerd/error (in
                    sessiond_cleanup() at main.c:661)<br>
                    DEBUG1 - 01:54:06.836805 [2686/2686]: Removing
                    directory /var/run/lttng/kconsumerd (in
                    sessiond_cleanup() at main.c:667)<br>
                    DEBUG1 - 01:54:06.836893 [2686/2686]: Removing
                    /var/run/lttng/ustconsumerd32/error (in
                    sessiond_cleanup() at main.c:674)<br>
                    DEBUG1 - 01:54:06.836991 [2686/2686]: Removing
                    directory /var/run/lttng/ustconsumerd32 (in
                    sessiond_cleanup() at main.c:680)<br>
                    DEBUG1 - 01:54:06.837075 [2686/2686]: Removing
                    /var/run/lttng/ustconsumerd64/error (in
                    sessiond_cleanup() at main.c:687)<br>
                    DEBUG1 - 01:54:06.837169 [2686/2686]: Removing
                    directory /var/run/lttng/ustconsumerd64 (in
                    sessiond_cleanup() at main.c:693)<br>
                    DEBUG1 - 01:54:06.837253 [2686/2686]: Cleaning up
                    all sessions (in sessiond_cleanup() at main.c:696)<br=
>
                    DEBUG1 - 01:54:06.837331 [2686/2686]: Cleaning up
                    all agent apps (in sessiond_cleanup() at main.c:713)<=
br>
                    DEBUG1 - 01:54:06.837397 [2686/2686]: Closing all
                    UST sockets (in sessiond_cleanup() at main.c:716)<br>
                    DEBUG2 - 01:54:06.837488 [2686/2686]: UST app
                    cleaning registered apps hash table (in
                    ust_app_clean_list() at ust-app.c:3818)<br>
                    DEBUG3 - 01:54:06.846332 [2686/2686]: Buffer
                    registry destroy all registry (in
                    buffer_reg_destroy_registries() at
                    buffer-registry.c:753)<br>
                    DEBUG2 - 01:54:06.846414 [2686/2686]: Closing kernel
                    fd (in sessiond_cleanup() at main.c:721)<br>
                    DEBUG1 - 01:54:06.846481 [2686/2686]: Unloading
                    kernel modules (in sessiond_cleanup() at main.c:728)<=
br>
                    DEBUG1 - 01:54:06.892609 [2686/2686]: Modprobe
                    removal successful
                    lttng-ring-buffer-metadata-mmap-client (in
                    modprobe_remove_lttng() at modprobe.c:371)<br>
                    DEBUG1 - 01:54:06.940557 [2686/2686]: Modprobe
                    removal successful
                    lttng-ring-buffer-client-mmap-overwrite (in
                    modprobe_remove_lttng() at modprobe.c:371)<br>
                    DEBUG1 - 01:54:06.996528 [2686/2686]: Modprobe
                    removal successful
                    lttng-ring-buffer-client-mmap-discard (in
                    modprobe_remove_lttng() at modprobe.c:371)<br>
                    DEBUG1 - 01:54:07.405263 [2686/2686]: Modprobe
                    removal successful lttng-ring-buffer-metadata-client
                    (in modprobe_remove_lttng() at modprobe.c:371)<br>
                    DEBUG1 - 01:54:07.805463 [2686/2686]: Modprobe
                    removal successful
                    lttng-ring-buffer-client-overwrite (in
                    modprobe_remove_lttng() at modprobe.c:371)<br>
                    DEBUG1 - 01:54:07.124584 [2686/2686]: Modprobe
                    removal successful lttng-ring-buffer-client-discard
                    (in modprobe_remove_lttng() at modprobe.c:371)<br>
                    DEBUG3 - 01:54:07.124716 [2686/2688]: [ht-thread]
                    Returning from poll on 2 fds. (in
                    thread_ht_cleanup() at ht-cleanup.c:73)<br>
                    DEBUG1 - 01:54:07.124831 [2686/2688]: [ht-cleanup]
                    quit. (in thread_ht_cleanup() at ht-cleanup.c:152)<br=
>
                    DEBUG1 - 01:54:07.124916 [2686/2688]: [ht-cleanup]
                    Thread terminates. (in thread_ht_cleanup() at
                    ht-cleanup.c:163)<br>
                    DEBUG1 - 01:54:07.125084 [2686/2686]: Cleaning up
                    options (in sessiond_cleanup_options() at
                    main.c:775)<br>
                    DEBUG1 - 01:54:07.125161 [2686/2686]: Destroying
                    run_as worker (in run_as_destroy_worker() at
                    runas.c:705)<br>
                    DEBUG1 - 01:54:07.125236 [2686/2686]: Closing run_as
                    worker socket (in run_as_destroy_worker() at
                    runas.c:711)<br>
                    DEBUG1 - 01:54:07.125343 [2687/2687]: run_as worker
                    exiting (ret =3D 0) (in run_as_create_worker() at
                    runas.c:655)<br>
                    DEBUG1 - 01:54:07.126301 [2686/2686]: lttng-runas
                    terminated with status code 0 (in
                    run_as_destroy_worker() at runas.c:733)<br>
                    DEBUG1 - 01:54:07.126332 [2686/2686]: *** assert
                    failed :-) *** =3D=3D&gt; Matthew, BEET driven
                    development works! (in sessiond_cleanup_options() at
                    main.c:807)<br>
                    -bash-4.3# ps -A|grep lttng<br>
                    =C2=A02582 ?=C2=A0 =C2=A0 =C2=A0 =C2=A0 00:00:00 lttn=
g-sessiond<br>
                    =C2=A02583 ?=C2=A0 =C2=A0 =C2=A0 =C2=A0 00:00:00 lttn=
g-runas<br>
                    -bash-4.3# lttng list -k<br>
                    Kernel events:<br>
                    -------------<br>
                    =C2=A0 =C2=A0 =C2=A0 lttng_logger (loglevel: TRACE_EM=
ERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_touch_buffer (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_dirty_buffer (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_rq_abort (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_rq_requeue (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_rq_complete (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_rq_insert (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_rq_issue (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_bio_bounce (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_bio_complete (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_bio_backmerge (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_bio_frontmerge (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_bio_queue (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_getrq (loglevel: TRACE_EME=
RG (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_sleeprq (loglevel: TRACE_E=
MERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_plug (loglevel: TRACE_EMER=
G (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_unplug (loglevel: TRACE_EM=
ERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_split (loglevel: TRACE_EME=
RG (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_bio_remap (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 block_rq_remap (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_transaction_commit (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_inode_new (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_inode_request (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_inode_evict (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_get_extent (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_ordered_extent_add (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_ordered_extent_remove (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_ordered_extent_start (logl=
evel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_ordered_extent_put (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs__extent_writepage (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_writepage_end_io_hook (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_sync_file (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_sync_fs (loglevel: TRACE_E=
MERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_delayed_tree_ref (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_delayed_data_ref (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_delayed_ref_head (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_chunk_alloc (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_chunk_free (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_cow_block (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_space_reservation (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_reserved_extent_alloc (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_reserved_extent_free (logl=
evel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_find_free_extent (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_reserve_extent (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_reserve_extent_cluster (lo=
glevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_find_cluster (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_failed_cluster_setup (logl=
evel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_setup_cluster (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_alloc_extent_state (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 btrfs_free_extent_state (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 compaction_isolate_migratepages =
(loglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 compaction_isolate_freepages (lo=
glevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 compaction_migratepages (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_free_inode (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_request_inode (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_allocate_inode (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_evict_inode (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_drop_inode (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_mark_inode_dirty (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_write_begin (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_ordered_write_end (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_writeback_write_end (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_journalled_write_end (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_ordered_writepage (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_writeback_writepage (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_journalled_writepage (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_readpage (loglevel: TRACE_E=
MERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_releasepage (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_invalidatepage (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_discard_blocks (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_request_blocks (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_allocate_blocks (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_free_blocks (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_sync_file_enter (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_sync_file_exit (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_sync_fs (loglevel: TRACE_EM=
ERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_rsv_window_add (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_discard_reservation (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_alloc_new_reservation (logl=
evel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_reserved (loglevel: TRACE_E=
MERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_forget (loglevel: TRACE_EME=
RG (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_read_block_bitmap (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_direct_IO_enter (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_direct_IO_exit (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_unlink_enter (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_unlink_exit (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_truncate_enter (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_truncate_exit (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_get_blocks_enter (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_get_blocks_exit (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext3_load_inode (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_free_inode (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_request_inode (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_allocate_inode (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_evict_inode (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_drop_inode (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mark_inode_dirty (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_begin_ordered_truncate (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_write_begin (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_da_write_begin (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ordered_write_end (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_writeback_write_end (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_journalled_write_end (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_da_write_end (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_da_writepages (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_da_write_pages (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_da_write_pages_extent (logl=
evel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_da_writepages_result (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_writepage (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_readpage (loglevel: TRACE_E=
MERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_releasepage (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_invalidatepage (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_journalled_invalidatepage (=
loglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_discard_blocks (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mb_new_inode_pa (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mb_new_group_pa (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mb_release_inode_pa (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mb_release_group_pa (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_discard_preallocations (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mb_discard_preallocations (=
loglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_request_blocks (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_allocate_blocks (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_free_blocks (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_sync_file_enter (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_sync_file_exit (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_sync_fs (loglevel: TRACE_EM=
ERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_alloc_da_blocks (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mballoc_alloc (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mballoc_prealloc (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mballoc_discard (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mballoc_free (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_forget (loglevel: TRACE_EME=
RG (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_da_update_reserve_space (lo=
glevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_da_reserve_space (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_da_release_space (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mb_bitmap_load (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_mb_buddy_bitmap_load (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_read_block_bitmap_load (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_load_inode_bitmap (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_direct_IO_enter (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_direct_IO_exit (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_fallocate_exit (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_fallocate_enter (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_punch_hole (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_zero_range (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_unlink_enter (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_unlink_exit (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_truncate_enter (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_truncate_exit (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_convert_to_initialized_=
enter
                    (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_convert_to_initialized_=
fastpath
                    (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_map_blocks_enter (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ind_map_blocks_enter (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_map_blocks_exit (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ind_map_blocks_exit (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_load_extent (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_load_inode (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_journal_start (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_journal_start_reserved (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_handle_uninitialized_ex=
tents
                    (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_get_implied_cluster_alloc_e=
xit (loglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_put_in_cache (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_in_cache (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_find_delalloc_range (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_get_reserved_cluster_alloc =
(loglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_show_extent (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_remove_blocks (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_rm_leaf (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_rm_idx (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_remove_space (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_ext_remove_space_done (logl=
evel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_es_insert_extent (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 ext4_es_cache_extent (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 gpio_direction (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 gpio_value (loglevel: TRACE_EMER=
G (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 irq_handler_entry (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 irq_handler_exit (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 irq_softirq_entry (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 irq_softirq_exit (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 irq_softirq_raise (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd_checkpoint (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd_start_commit (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd_commit_locking (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd_commit_flushing (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd_commit_logging (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd_drop_transaction (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd_end_commit (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd_do_submit_data (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd_cleanup_journal_tail (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd_journal_write_superblock (lo=
glevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_checkpoint (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_start_commit (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_commit_locking (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_commit_flushing (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_commit_logging (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_drop_transaction (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_end_commit (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_submit_inode_data (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_run_stats (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_checkpoint_stats (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_update_log_tail (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 jbd2_write_superblock (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_kmalloc (loglevel: TRACE_EM=
ERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_cache_alloc (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_kmalloc_node (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_cache_alloc_node (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_kfree (loglevel: TRACE_EMER=
G (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_cache_free (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_mm_page_free (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_mm_page_free_batched (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_mm_page_alloc (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_mm_page_alloc_zone_locked (=
loglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_mm_page_pcpu_drain (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kmem_mm_page_alloc_extfrag (logl=
evel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kvm_userspace_exit (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kvm_set_irq (loglevel: TRACE_EME=
RG (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kvm_mmio (loglevel: TRACE_EMERG =
(0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kvm_fpu (loglevel: TRACE_EMERG (=
0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 kvm_age_page (loglevel: TRACE_EM=
ERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 module_load (loglevel: TRACE_EME=
RG (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 module_free (loglevel: TRACE_EME=
RG (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 module_get (loglevel: TRACE_EMER=
G (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 module_put (loglevel: TRACE_EMER=
G (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 module_request (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 napi_poll (loglevel: TRACE_EMERG=
 (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 net_dev_xmit (loglevel: TRACE_EM=
ERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 net_dev_queue (loglevel: TRACE_E=
MERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 net_if_receive_skb (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 net_if_rx (loglevel: TRACE_EMERG=
 (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 power_cpu_idle (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 power_cpu_frequency (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 power_machine_suspend (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 power_wakeup_source_activate (lo=
glevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 power_wakeup_source_deactivate (=
loglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 power_clock_enable (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 power_clock_disable (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 power_clock_set_rate (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 power_domain_target (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 printk_console (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 random_mix_pool_bytes (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 random_mix_pool_bytes_nolock (lo=
glevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 random_credit_entropy_bits (logl=
evel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 random_get_random_bytes (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 random_extract_entropy (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 random_extract_entropy_user (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 rcu_utilization (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regmap_reg_write (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regmap_reg_read (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regmap_reg_read_cache (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regmap_hw_read_start (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regmap_hw_read_done (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regmap_hw_write_start (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regmap_hw_write_done (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regmap_regcache_sync (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regmap_cache_only (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regmap_cache_bypass (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regulator_enable (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regulator_enable_delay (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regulator_enable_complete (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regulator_disable (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regulator_disable_complete (logl=
evel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regulator_set_voltage (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 regulator_set_voltage_complete (=
loglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_kthread_stop (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_kthread_stop_ret (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_wakeup (loglevel: TRACE_EM=
ERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_wakeup_new (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_switch (loglevel: TRACE_EM=
ERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_migrate_task (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_process_free (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_process_exit (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_wait_task (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_process_wait (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_process_fork (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_process_exec (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_stat_wait (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_stat_sleep (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_stat_iowait (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_stat_blocked (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_stat_runtime (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sched_pi_setprio (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 scsi_dispatch_cmd_start (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 scsi_dispatch_cmd_error (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 scsi_dispatch_cmd_done (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 scsi_dispatch_cmd_timeout (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 scsi_eh_wakeup (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 signal_generate (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 signal_deliver (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 skb_kfree (loglevel: TRACE_EMERG=
 (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 skb_consume (loglevel: TRACE_EME=
RG (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 skb_copy_datagram_iovec (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sock_rcvqueue_full (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 sock_exceed_buf_limit (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 lttng_statedump_start (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 lttng_statedump_end (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 lttng_statedump_process_state (l=
oglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 lttng_statedump_file_descriptor =
(loglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 lttng_statedump_vm_map (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 lttng_statedump_network_interfac=
e (loglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 lttng_statedump_block_device (lo=
glevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 lttng_statedump_interrupt (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 rpc_call_status (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 rpc_bind_status (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 rpc_connect_status (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 rpc_task_begin (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 rpc_task_run_action (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 rpc_task_complete (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 rpc_task_sleep (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 rpc_task_wakeup (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_init (loglevel: TRACE_EMER=
G (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_start (loglevel: TRACE_EME=
RG (0)) (type:
                    tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_expire_entry (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_expire_exit (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_cancel (loglevel: TRACE_EM=
ERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_hrtimer_init (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_hrtimer_start (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_hrtimer_expire_entry (logl=
evel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_hrtimer_expire_exit (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_hrtimer_cancel (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_itimer_state (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 timer_itimer_expire (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 udp_fail_queue_rcv_skb (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_kswapd_sleep (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_kswapd_wake (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_wakeup_kswapd (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_direct_reclaim_begin (=
loglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_memcg_reclaim_begin (l=
oglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_memcg_softlimit_reclai=
m_begin
                    (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_direct_reclaim_end (lo=
glevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_memcg_reclaim_end (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_memcg_softlimit_reclai=
m_end
                    (loglevel: TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_shrink_slab_start (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_shrink_slab_end (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_lru_isolate (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_memcg_isolate (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_writepage (loglevel: T=
RACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 mm_vmscan_lru_shrink_inactive (l=
oglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 workqueue_queue_work (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 workqueue_activate_work (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 workqueue_execute_start (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 workqueue_execute_end (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_dirty_page (loglevel: =
TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_dirty_inode_start (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_dirty_inode (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_mark_inode_dirty (logl=
evel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_write_inode_start (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_write_inode (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_nothread (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_queue (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_exec (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_start (loglevel: TRACE=
_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_written (loglevel: TRA=
CE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_wait (loglevel: TRACE_=
EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_pages_written (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_bdi_register (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_nowork (loglevel: TRAC=
E_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_wake_background (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_wake_thread (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_wake_forker_thread (lo=
glevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_bdi_unregister (loglev=
el:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_thread_start (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_thread_stop (loglevel:=
 TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_wbc_writepage (logleve=
l: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_queue_io (loglevel: TR=
ACE_EMERG (0))
                    (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_global_dirty_state (lo=
glevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_bdi_dirty_ratelimit (l=
oglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_balance_dirty_pages (l=
oglevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_sb_inodes_requeue (log=
level:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_congestion_wait (logle=
vel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_wait_iff_congested (lo=
glevel:
                    TRACE_EMERG (0)) (type: tracepoint)<br>
                    =C2=A0 =C2=A0 =C2=A0 writeback_single_inode (loglevel=
: TRACE_EMERG
                    (0)) (type: tracepoint)<br>
                    <br>
                    <br>
                    <br>
                    -----</span>=E9=82=AE=E4=BB=B6=E5=8E=9F=E4=BB=B6<span=
 lang=3D"EN-US">-----<br>
                  </span>=E5=8F=91=E4=BB=B6=E4=BA=BA<span lang=3D"EN-US">=
: lttng-dev [mailto:<a
                      moz-do-not-send=3D"true"
                      href=3D"mailto:lttng-dev-bounces@lists.lttng.org"><=
a class=3D"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev-bounces@lis=
ts.lttng.org">lttng-dev-bounces@lists.lttng.org</a></a>]
                  </span>=E4=BB=A3=E8=A1=A8<span lang=3D"EN-US"> Jonathan=
 Rajotte Julien<br>
                  </span>=E5=8F=91=E9=80=81=E6=97=B6=E9=97=B4<span lang=3D=
"EN-US">: 2016</span>=E5=B9=B4<span
                    lang=3D"EN-US">4</span>=E6=9C=88<span lang=3D"EN-US">=
11</span>=E6=97=A5<span
                    lang=3D"EN-US"> 22:14<br>
                  </span>=E6=94=B6=E4=BB=B6=E4=BA=BA<span lang=3D"EN-US">=
: <a
                      moz-do-not-send=3D"true"
                      href=3D"mailto:lttng-dev@lists.lttng.org"><a class=3D=
"moz-txt-link-abbreviated" href=3D"mailto:lttng-dev@lists.lttng.org">lttn=
g-dev@lists.lttng.org</a></a><br>
                  </span>=E4=B8=BB=E9=A2=98<span lang=3D"EN-US">: Re: [lt=
tng-dev] lttng
                    trace kernel on arm64<o:p></o:p></span></p>
                <div>
                  <div>
                    <p class=3D"MsoNormal"><span lang=3D"EN-US"><br>
                        Hi,<br>
                        <br>
                        On 2016-04-08 02:28 AM, Lichuanbao wrote:<br>
                        &gt;<br>
                        &gt; Hi,<br>
                        &gt;<br>
                        &gt;=C2=A0 =C2=A0 I want to use lttng trace kerne=
l event,I
                        installed lttng-tools<br>
                        &gt; 2.7.1 lttng-ust 2.7.2 lttng-modules 2.7.2
                        on my arm64 board,<br>
                        &gt;<br>
                        <br>
                        You got me curious: D02 ? D03 hisilicon board ?
                        :)<br>
                        <br>
                        &gt; And then I create my session like sub
                        command as root,but there is<br>
                        &gt; nothing result to view.<br>
                        &gt;<br>
                        &gt;=C2=A0 =C2=A0 =C2=A0# lttng create<br>
                        &gt;<br>
                        &gt;=C2=A0 =C2=A0 =C2=A0# lttng enable-event --ke=
rnel --all<br>
                        &gt;<br>
                        &gt;=C2=A0 =C2=A0 =C2=A0# lttng start<br>
                        &gt;<br>
                        &gt;=C2=A0 =C2=A0 =C2=A0# sleep 10=C2=A0 =C2=A0 =C2=
=A0 =C2=A0# let the system
                        generate some activity<br>
                        &gt;<br>
                        &gt;=C2=A0 =C2=A0 =C2=A0# lttng stop<br>
                        &gt;<br>
                        &gt;=C2=A0 =C2=A0 =C2=A0# lttng view<br>
                        &gt;<br>
                        &gt; # lttng destroy<br>
                        &gt;<br>
                        <br>
                        Does "lttng list -k" return a list of events ?<br=
>
                        <br>
                        &gt; -bash-4.3# lttng view<br>
                        &gt;<br>
                        &gt; Trace directory:
                        /root/lttng-traces/auto-20160407-211248<br>
                        &gt;<br>
                        &gt; [error] Cannot open any trace for reading.<b=
r>
                        &gt;<br>
                        &gt; [error] opening trace
                        "/root/lttng-traces/auto-20160407-211248" for<br>
                        &gt; reading.<br>
                        &gt;<br>
                        &gt; [error] none of the specified trace paths
                        could be opened.<br>
                        &gt;<br>
                        &gt; Get thes session daemon log as follow:<br>
                        &gt;<br>
                        &gt; bash-4.3# lttng-sessiond -vvv<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.396991 [5621/5621]:
                        run_as signal handler set for<br>
                        &gt; SIGTERM and SIGINT (in
                        set_worker_sighandlers() at runas.c:600)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.397410 [5620/5620]:
                        Health check time delta in<br>
                        &gt; seconds set to 20 (in health_init() at
                        health.c:74)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.397661 [5620/5620]: epoll
                        set max size is 27037798<br>
                        &gt; (in compat_epoll_set_max_size() at
                        compat-epoll.c:290)<br>
                        &gt;<br>
                        &gt; DEBUG3 - 21:52:15.397838 [5620/5620]:
                        Creating LTTng run directory:<br>
                        &gt; /var/run/lttng (in create_lttng_rundir() at
                        main.c:5156)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.397852 [5620/5622]:
                        [ht-thread] startup. (in<br>
                        &gt; thread_ht_cleanup() at ht-cleanup.c:37)<br>
                        &gt;<br>
                        &gt; DEBUG2 - 21:52:15.397986 [5620/5620]:
                        Kernel consumer err path:<br>
                        &gt; /var/run/lttng/kconsumerd/error (in main()
                        at main.c:5601)<br>
                        &gt;<br>
                        &gt; DEBUG2 - 21:52:15.398070 [5620/5620]:
                        Kernel consumer cmd path:<br>
                        &gt; /var/run/lttng/kconsumerd/command (in
                        main() at main.c:5603)<br>
                        &gt;<br>
                        &gt; DEBUG3 - 21:52:15.398034 [5620/5622]:
                        [ht-thread] Polling. (in<br>
                        &gt; thread_ht_cleanup() at ht-cleanup.c:67)<br>
                        &gt;<br>
                        &gt; Error: Could not get lock file
                        /var/run/lttng/lttng-sessiond.lck,<br>
                        &gt; another instance is running.<br>
                        &gt;<br>
                        <br>
                        This line suggest that another instance was
                        running.<br>
                        <br>
                        Make sure to kill all lttng-sessiond instance
                        before starting one to<br>
                        make sure you have the actual log of the used
                        sessiond.<br>
                        <br>
                        Cheers<br>
                        <br>
                        <br>
                        &gt; DEBUG1 - 21:52:15.398240 [5620/5620]:
                        Cleanup sessiond (in<br>
                        &gt; sessiond_cleanup() at main.c:622)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398294 [5620/5620]:
                        Removing sessiond and consumerd<br>
                        &gt; content of directory /var/run/lttng (in
                        sessiond_cleanup() at main.c:641)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398321 [5620/5620]:
                        Removing<br>
                        &gt; /var/run/lttng/lttng-sessiond.pid (in
                        sessiond_cleanup() at main.c:647)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398372 [5620/5620]:
                        Removing<br>
                        &gt; /var/run/lttng/agent.port (in
                        sessiond_cleanup() at main.c:652)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398420 [5620/5620]:
                        Removing<br>
                        &gt; /var/run/lttng/kconsumerd/error (in
                        sessiond_cleanup() at main.c:659)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398472 [5620/5620]:
                        Removing directory<br>
                        &gt; /var/run/lttng/kconsumerd (in
                        sessiond_cleanup() at main.c:665)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398526 [5620/5620]:
                        Removing<br>
                        &gt; /var/run/lttng/ustconsumerd32/error (in
                        sessiond_cleanup() at main.c:672)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398579 [5620/5620]:
                        Removing directory<br>
                        &gt; /var/run/lttng/ustconsumerd32 (in
                        sessiond_cleanup() at main.c:678)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398620 [5620/5620]:
                        Removing<br>
                        &gt; /var/run/lttng/ustconsumerd64/error (in
                        sessiond_cleanup() at main.c:685)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398673 [5620/5620]:
                        Removing directory<br>
                        &gt; /var/run/lttng/ustconsumerd64 (in
                        sessiond_cleanup() at main.c:691)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398734 [5620/5620]:
                        Cleaning up all sessions (in<br>
                        &gt; sessiond_cleanup() at main.c:694)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398765 [5620/5620]:
                        Cleaning up all agent apps (in<br>
                        &gt; sessiond_cleanup() at main.c:711)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398789 [5620/5620]:
                        Closing all UST sockets (in<br>
                        &gt; sessiond_cleanup() at main.c:714)<br>
                        &gt;<br>
                        &gt; DEBUG2 - 21:52:15.398813 [5620/5620]: UST
                        app cleaning registered apps<br>
                        &gt; hash table (in ust_app_clean_list() at
                        ust-app.c:3702)<br>
                        &gt;<br>
                        &gt; DEBUG3 - 21:52:15.398837 [5620/5620]:
                        Buffer registry destroy all<br>
                        &gt; registry (in
                        buffer_reg_destroy_registries() at
                        buffer-registry.c:716)<br>
                        &gt;<br>
                        &gt; DEBUG2 - 21:52:15.398861 [5620/5620]:
                        Closing kernel fd (in<br>
                        &gt; sessiond_cleanup() at main.c:719)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.398884 [5620/5620]:
                        Unloading kernel modules (in<br>
                        &gt; sessiond_cleanup() at main.c:726)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.403580 [5620/5620]:
                        Modprobe removal successful<br>
                        &gt; lttng-kretprobes (in
                        modprobe_remove_lttng() at modprobe.c:126)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.407855 [5620/5620]:
                        Modprobe removal successful<br>
                        &gt; lttng-kprobes (in modprobe_remove_lttng()
                        at modprobe.c:126)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.412073 [5620/5620]:
                        Modprobe removal successful<br>
                        &gt; lttng-ftrace (in modprobe_remove_lttng() at
                        modprobe.c:126)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.416256 [5620/5620]:
                        Modprobe removal successful<br>
                        &gt; lttng-types (in modprobe_remove_lttng() at
                        modprobe.c:126)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.420593 [5620/5620]:
                        Modprobe removal successful<br>
                        &gt; lttng-ring-buffer-metadata-mmap-client (in
                        modprobe_remove_lttng() at<br>
                        &gt; modprobe.c:126)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.425108 [5620/5620]:
                        Modprobe removal successful<br>
                        &gt; lttng-ring-buffer-client-mmap-overwrite (in
                        modprobe_remove_lttng() at<br>
                        &gt; modprobe.c:126)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.429745 [5620/5620]:
                        Modprobe removal successful<br>
                        &gt; lttng-ring-buffer-client-mmap-discard (in
                        modprobe_remove_lttng() at<br>
                        &gt; modprobe.c:126)<br>
                        &gt;<br>
                        &gt; Error: Unable to remove module
                        lttng-ring-buffer-metadata-client<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.438779 [5620/5620]:
                        Modprobe removal successful<br>
                        &gt; lttng-ring-buffer-client-overwrite (in
                        modprobe_remove_lttng() at<br>
                        &gt; modprobe.c:126)<br>
                        &gt;<br>
                        &gt; Error: Unable to remove module
                        lttng-ring-buffer-client-discard<br>
                        &gt;<br>
                        &gt; Error: Unable to remove module
                        lttng-lib-ring-buffer<br>
                        &gt;<br>
                        &gt; Error: Unable to remove module lttng-tracer<=
br>
                        &gt;<br>
                        &gt; DEBUG3 - 21:52:15.452135 [5620/5622]:
                        [ht-thread] Returning from poll<br>
                        &gt; on 2 fds. (in thread_ht_cleanup() at
                        ht-cleanup.c:74)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.452186 [5620/5622]:
                        [ht-cleanup] quit. (in<br>
                        &gt; thread_ht_cleanup() at ht-cleanup.c:153)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.452225 [5620/5622]:
                        [ht-cleanup] Thread terminates.<br>
                        &gt; (in thread_ht_cleanup() at
                        ht-cleanup.c:164)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.452333 [5620/5620]:
                        Cleaning up options (in<br>
                        &gt; sessiond_cleanup_options() at main.c:773)<br=
>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.453308 [5620/5620]:
                        lttng-runas terminated with<br>
                        &gt; status code 0 (in run_as_destroy_worker()
                        at runas.c:737)<br>
                        &gt;<br>
                        &gt; DEBUG1 - 21:52:15.453349 [5620/5620]: ***
                        assert failed :-) *** =3D=3D&gt;<br>
                        &gt; Matthew, BEET driven development works! (in
                        sessiond_cleanup_options()<br>
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
                        &gt;
                        _______________________________________________<b=
r>
                        &gt; lttng-dev mailing list<br>
                        &gt; <a moz-do-not-send=3D"true"
                          href=3D"mailto:lttng-dev@lists.lttng.org">lttng=
-dev@lists.lttng.org</a><br>
                        &gt; <a moz-do-not-send=3D"true"
                          href=3D"https://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev"
                          target=3D"_blank">
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
                        <br>
                        --<br>
                        Jonathan R. Julien<br>
                        Efficios<br>
                        <br>
                        _______________________________________________<b=
r>
                        lttng-dev mailing list<br>
                        <a moz-do-not-send=3D"true"
                          href=3D"mailto:lttng-dev@lists.lttng.org">lttng=
-dev@lists.lttng.org</a><br>
                        <a moz-do-not-send=3D"true"
                          href=3D"https://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev"
                          target=3D"_blank">https://lists.lttng.org/cgi-b=
in/mailman/listinfo/lttng-dev</a><br>
                        _______________________________________________<b=
r>
                        lttng-dev mailing list<br>
                        <a moz-do-not-send=3D"true"
                          href=3D"mailto:lttng-dev@lists.lttng.org">lttng=
-dev@lists.lttng.org</a><br>
                        <a moz-do-not-send=3D"true"
                          href=3D"https://lists.lttng.org/cgi-bin/mailman=
/listinfo/lttng-dev"
                          target=3D"_blank">https://lists.lttng.org/cgi-b=
in/mailman/listinfo/lttng-dev</a><o:p></o:p></span></p>
                  </div>
                </div>
              </blockquote>
            </div>
            <p class=3D"MsoNormal"><span lang=3D"EN-US"><br>
                <br clear=3D"all">
                <o:p></o:p></span></p>
            <div>
              <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=A0</o:=
p></span></p>
            </div>
            <p class=3D"MsoNormal"><span lang=3D"EN-US">-- <o:p></o:p></s=
pan></p>
            <div>
              <div>
                <div>
                  <div>
                    <p class=3D"MsoNormal"><span lang=3D"EN-US">Jonathan
                        Rajotte Julien<o:p></o:p></span></p>
                    <div>
                      <p class=3D"MsoNormal"><span lang=3D"EN-US"><o:p>=C2=
=A0</o:p></span></p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
    <pre class=3D"moz-signature" cols=3D"72">--=20
Jonathan R. Julien
Efficios</pre>
  </body>
</html>

--------------050907000301070402070901--

--===============0608021966670293921==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbHR0bmctZGV2
IG1haWxpbmcgbGlzdApsdHRuZy1kZXZAbGlzdHMubHR0bmcub3JnCmh0dHBzOi8vbGlzdHMubHR0
bmcub3JnL2NnaS1iaW4vbWFpbG1hbi9saXN0aW5mby9sdHRuZy1kZXYK

--===============0608021966670293921==--
