From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Can't get any event output from the demo exe
Date: Mon, 23 Mar 2015 15:58:56 +0000 (UTC)
Message-ID: <430207063.77873.1427126336840.JavaMail.zimbra__40729.0784446106$1427126404$gmane$org@efficios.com>
References: <trinity-e73e3633-440b-429c-ad5e-bf48c3413989-1426531801924@3capp-gmx-bs44>
 <55073522.6080006@efficios.com>
 <trinity-6a4fab60-3c7e-4785-a2f2-e42bba49fcb4-1426578599498@3capp-gmx-bs25>
 <1948116446.75706.1427119102220.JavaMail.zimbra@efficios.com>
 <trinity-7f4e3d2c-257e-4b0c-92c6-b4db5e00c863-1427125168642@3capp-gmx-bs67>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <compudj@efficios.com>) id 1Ya4kn-00005h-Lq
 for lttng-dev@lists.lttng.org; Mon, 23 Mar 2015 11:59:04 -0400
In-Reply-To: <trinity-7f4e3d2c-257e-4b0c-92c6-b4db5e00c863-1427125168642@3capp-gmx-bs67>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Wolfgang Rostek <wolfgang.rostek@gmx.de>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

It looks like the UST application cannot talk to the session daemon
over the communication unix socket at all.

Normally, there would be activity in the session daemon when the
application is started.

Please double-check that the ust and tools versions used are
compatible. If needed, uninstall and reinstall them, following
the http://lttng.org/docs documentation.

Thanks,

Mathieu

----- Original Message -----
> Hi Mathieu,
> 
> thanks for looking at it.
> 
> Here the complete log of both sides
> 
> 
> 
> row@cobra7:~$ lttng create
> Session auto-20150323-162735 created.
> Traces will be written in
> /home/local/ESG_GMBH/row/lttng-traces/auto-20150323-162735
> 
> 
> DEBUG1 [2915/2921]: Wait for client response (in thread_manage_clients() at
> main.c:3815)
> DEBUG1 [2915/2921]: Receiving data from client ... (in
> thread_manage_clients() at main.c:3860)
> DEBUG1 [2915/2921]: Nothing recv() from client... continuing (in
> thread_manage_clients() at main.c:3864)
> DEBUG1 [2915/2921]: Clean command context structure (in clean_command_ctx()
> at main.c:608)
> DEBUG1 [2915/2921]: Accepting client command ... (in thread_manage_clients()
> at main.c:3773)
> DEBUG1 [2915/2921]: Wait for client response (in thread_manage_clients() at
> main.c:3815)
> DEBUG1 [2915/2921]: Receiving data from client ... (in
> thread_manage_clients() at main.c:3860)
> DEBUG1 [2915/2921]: Processing client command 8 (in process_client_msg() at
> main.c:2637)
> DEBUG1 [2915/2921]: Waiting for 1 URIs from client ... (in
> process_client_msg() at main.c:3201)
> DEBUG2 [2915/2921]: Trying to find session by name auto-20150323-162735 (in
> session_find_by_name() at session.c:169)
> DEBUG3 [2915/2921]: Created hashtable size 4 at 0xb2a05a28 of type 1 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG1 [2915/2921]: Tracing session auto-20150323-162735 created with ID 0 by
> UID 1548223785 GID 1548222977 (in session_create() at session.c:276)
> DEBUG2 [2915/2921]: Trying to find session by name auto-20150323-162735 (in
> session_find_by_name() at session.c:169)
> DEBUG3 [2915/2921]: Created hashtable size 4 at 0xb2a0ad80 of type 1 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG2 [2915/2921]: Setting trace directory path from URI to
> /home/local/ESG_GMBH/row/lttng-traces/auto-20150323-162735 (in
> add_uri_to_consumer() at cmd.c:481)
> DEBUG1 [2915/2921]: Sending response (size: 16, retcode: Success) (in
> thread_manage_clients() at main.c:3909)
> DEBUG1 [2915/2921]: Clean command context structure (in clean_command_ctx()
> at main.c:608)
> DEBUG1 [2915/2921]: Accepting client command ... (in thread_manage_clients()
> at main.c:3773)
> 
> row@cobra7:~$ lttng enable-event -u -a
> All UST events are enabled in channel channel0
> 
> DEBUG1 [2915/2921]: Wait for client response (in thread_manage_clients() at
> main.c:3815)
> DEBUG1 [2915/2921]: Receiving data from client ... (in
> thread_manage_clients() at main.c:3860)
> DEBUG1 [2915/2921]: Nothing recv() from client... continuing (in
> thread_manage_clients() at main.c:3864)
> DEBUG1 [2915/2921]: Clean command context structure (in clean_command_ctx()
> at main.c:608)
> DEBUG1 [2915/2921]: Accepting client command ... (in thread_manage_clients()
> at main.c:3773)
> DEBUG1 [2915/2921]: Wait for client response (in thread_manage_clients() at
> main.c:3815)
> DEBUG1 [2915/2921]: Receiving data from client ... (in
> thread_manage_clients() at main.c:3860)
> DEBUG1 [2915/2921]: Processing client command 6 (in process_client_msg() at
> main.c:2637)
> DEBUG1 [2915/2921]: Getting session auto-20150323-162735 by name (in
> process_client_msg() at main.c:2716)
> DEBUG2 [2915/2921]: Trying to find session by name auto-20150323-162735 (in
> session_find_by_name() at session.c:169)
> DEBUG1 [2915/2921]: Creating UST session (in create_ust_session() at
> main.c:2517)
> DEBUG3 [2915/2921]: Created hashtable size 4 at 0xb2a039f0 of type 0 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG3 [2915/2921]: Created hashtable size 4 at 0xb2a03d18 of type 0 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG3 [2915/2921]: Created hashtable size 4 at 0xb2a04040 of type 1 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG2 [2915/2921]: UST trace session create successful (in
> trace_ust_create_session() at trace-ust.c:263)
> DEBUG3 [2915/2921]: Copying tracing session consumer output in UST session
> (in copy_session_consumer() at main.c:2466)
> DEBUG3 [2915/2921]: Created hashtable size 4 at 0xb2a04368 of type 1 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG3 [2915/2921]: Copy session consumer subdir /ust (in
> copy_session_consumer() at main.c:2484)
> DEBUG1 [2915/2921]: Spawning consumerd (in spawn_consumerd() at main.c:2158)
> DEBUG2 [2915/2921]: Consumer pid 2987 (in start_consumerd() at main.c:2340)
> DEBUG2 [2915/2921]: Spawning consumer control thread (in start_consumerd() at
> main.c:2343)
> DEBUG3 [2915/2918]: [ht-thread] Polling on 2 fds. (in thread_ht_cleanup() at
> ht-cleanup.c:64)
> DEBUG1 [2987/2987]: Using 32-bit UST consumer at:
> /usr/lib/i386-linux-gnu/lttng/libexec/lttng-consumerd (in spawn_consumerd()
> at main.c:2278)
> DEBUG1 [2915/2988]: [thread] Manage consumer started (in
> thread_manage_consumer() at main.c:994)
> DEBUG2 [2915/2988]: Receiving code from consumer err_sock (in
> thread_manage_consumer() at main.c:1079)
> DEBUG1 [2915/2988]: Consumer command socket ready (fd: 26 (in
> thread_manage_consumer() at main.c:1113)
> DEBUG1 [2915/2988]: Consumer metadata socket ready (fd: 27) (in
> thread_manage_consumer() at main.c:1115)
> DEBUG3 [2915/2921]: Consumer socket created (fd: 26) and added to output (in
> consumer_create_socket() at consumer.c:301)
> DEBUG1 [2915/2921]: Setting relayd for session auto-20150323-162735 (in
> cmd_setup_relayd() at cmd.c:722)
> DEBUG2 [2915/2921]: Trace UST channel channel0 not found by name (in
> trace_ust_find_channel_by_name() at trace-ust.c:162)
> DEBUG1 [2915/2921]: Enabling channel  for session auto-20150323-162735 (in
> cmd_enable_channel() at cmd.c:910)
> DEBUG2 [2915/2921]: Trace UST channel channel0 not found by name (in
> trace_ust_find_channel_by_name() at trace-ust.c:162)
> DEBUG3 [2915/2921]: Created hashtable size 4 at 0xb2a04910 of type 0 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG3 [2915/2921]: Created hashtable size 4 at 0xb2a04bf0 of type 1 (in
> lttng_ht_new() at hashtable.c:127)
> DEBUG2 [2915/2921]: Trace UST channel channel0 created (in
> trace_ust_create_channel() at trace-ust.c:331)
> DEBUG2 [2915/2921]: Channel channel0 is being created for UST with buffer 1
> and id 0 (in channel_ust_create() at channel.c:348)
> DEBUG2 [2915/2921]: UST app adding channel channel0 to UST domain for session
> id 0 (in ust_app_create_channel_glb() at ust-app.c:3536)
> DEBUG2 [2915/2921]: Channel channel0 created successfully (in
> channel_ust_create() at channel.c:383)
> DEBUG2 [2915/2921]: Trace UST channel channel0 found by name (in
> trace_ust_find_channel_by_name() at trace-ust.c:157)
> DEBUG2 [2915/2921]: Trace UST event * NOT found (in trace_ust_find_event() at
> trace-ust.c:198)
> DEBUG2 [2915/2921]: Trace UST event *, loglevel (0,-1) created (in
> trace_ust_create_event() at trace-ust.c:405)
> DEBUG1 [2915/2921]: UST app creating event * for all apps for session id 0
> (in ust_app_create_event_glb() at ust-app.c:3687)
> DEBUG1 [2915/2921]: Event UST * created in channel channel0 (in
> event_ust_enable_tracepoint() at event.c:469)
> DEBUG1 [2915/2921]: Sending response (size: 16, retcode: Success) (in
> thread_manage_clients() at main.c:3909)
> DEBUG1 [2915/2921]: Clean command context structure (in clean_command_ctx()
> at main.c:608)
> DEBUG1 [2915/2921]: Accepting client command ... (in thread_manage_clients()
> at main.c:3773)
> 
> row@cobra7:~$ lttng start
> Tracing started for session auto-20150323-162735
> 
> DEBUG1 [2915/2921]: Wait for client response (in thread_manage_clients() at
> main.c:3815)
> DEBUG1 [2915/2921]: Receiving data from client ... (in
> thread_manage_clients() at main.c:3860)
> DEBUG1 [2915/2921]: Nothing recv() from client... continuing (in
> thread_manage_clients() at main.c:3864)
> DEBUG1 [2915/2921]: Clean command context structure (in clean_command_ctx()
> at main.c:608)
> DEBUG1 [2915/2921]: Accepting client command ... (in thread_manage_clients()
> at main.c:3773)
> DEBUG1 [2915/2921]: Wait for client response (in thread_manage_clients() at
> main.c:3815)
> DEBUG1 [2915/2921]: Receiving data from client ... (in
> thread_manage_clients() at main.c:3860)
> DEBUG1 [2915/2921]: Processing client command 16 (in process_client_msg() at
> main.c:2637)
> DEBUG1 [2915/2921]: Getting session auto-20150323-162735 by name (in
> process_client_msg() at main.c:2716)
> DEBUG2 [2915/2921]: Trying to find session by name auto-20150323-162735 (in
> session_find_by_name() at session.c:169)
> DEBUG1 [2915/2921]: Starting all UST traces (in ust_app_start_trace_all() at
> ust-app.c:4034)
> DEBUG1 [2915/2921]: Sending response (size: 16, retcode: Success) (in
> thread_manage_clients() at main.c:3909)
> DEBUG1 [2915/2921]: Clean command context structure (in clean_command_ctx()
> at main.c:608)
> DEBUG1 [2915/2921]: Accepting client command ... (in thread_manage_clients()
> at main.c:3773)
> 
> 
> row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo$ ./demo-trace
> liblttng_ust_tracepoint[3581/3581]: just registered a tracepoints section
> from 0xb757c780 and having 2 tracepoints (in tracepoint_register_lib() at
> tracepoint.c:767)
> liblttng_ust_tracepoint[3581/3581]: registered tracepoint:
> ust_baddr_statedump:soinfo (in tracepoint_register_lib() at
> tracepoint.c:772)
> liblttng_ust_tracepoint[3581/3581]: registered tracepoint:
> lttng_ust_tracef:event (in tracepoint_register_lib() at tracepoint.c:772)
> libust[3581/3581]: Provider "ust_baddr_statedump" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version()
> at lttng-probes.c:174)
> libust[3581/3581]: adding probe ust_baddr_statedump containing 1 events to
> lazy registration list (in lttng_probe_register() at lttng-probes.c:216)
> libust[3581/3581]: LTT : ltt ring buffer client "relay-metadata-mmap" init
> (in lttng_ring_buffer_metadata_client_init() at
> lttng-ring-buffer-metadata-client.h:330)
> libust[3581/3581]: LTT : ltt ring buffer client "relay-overwrite-mmap" init
> (in lttng_ring_buffer_client_overwrite_init() at
> lttng-ring-buffer-client.h:681)
> libust[3581/3581]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap"
> init
> (in lttng_ring_buffer_client_overwrite_rt_init() at
> lttng-ring-buffer-client.h:681)
> libust[3581/3581]: LTT : ltt ring buffer client "relay-discard-mmap" init
> (in lttng_ring_buffer_client_discard_init() at
> lttng-ring-buffer-client.h:681)
> libust[3581/3581]: LTT : ltt ring buffer client "relay-discard-rt-mmap" init
> (in lttng_ring_buffer_client_discard_rt_init() at
> lttng-ring-buffer-client.h:681)
> libust[3581/3582]: Info: sessiond not accepting connections to global apps
> socket (in ust_listener_thread() at lttng-ust-comm.c:1221)
> libust[3581/3583]: Info: sessiond not accepting connections to local apps
> socket (in ust_listener_thread() at lttng-ust-comm.c:1221)
> libust[3581/3582]: Waiting for global apps sessiond (in wait_for_sessiond()
> at lttng-ust-comm.c:1132)
> libust[3581/3581]: Provider "lttng_ust_tracef" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version()
> at lttng-probes.c:174)
> libust[3581/3583]: Waiting for local apps sessiond (in wait_for_sessiond() at
> lttng-ust-comm.c:1132)
> libust[3581/3581]: just registered probe ust_baddr_statedump containing 1
> events (in lttng_lazy_probe_register() at lttng-probes.c:115)
> libust[3581/3581]: adding probe lttng_ust_tracef containing 1 events to lazy
> registration list (in lttng_probe_register() at lttng-probes.c:216)
> libust[3581/3581]: Provider "ust_tests_demo3" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version()
> at lttng-probes.c:174)
> libust[3581/3581]: just registered probe lttng_ust_tracef containing 1 events
> (in lttng_lazy_probe_register() at lttng-probes.c:115)
> libust[3581/3581]: adding probe ust_tests_demo3 containing 1 events to lazy
> registration list (in lttng_probe_register() at lttng-probes.c:216)
> libust[3581/3581]: Provider "ust_tests_demo" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version()
> at lttng-probes.c:174)
> libust[3581/3581]: just registered probe ust_tests_demo3 containing 1 events
> (in lttng_lazy_probe_register() at lttng-probes.c:115)
> libust[3581/3581]: adding probe ust_tests_demo containing 2 events to lazy
> registration list (in lttng_probe_register() at lttng-probes.c:216)
> libust[3581/3581]: Provider "ust_tests_demo2" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version()
> at lttng-probes.c:174)
> libust[3581/3581]: just registered probe ust_tests_demo containing 2 events
> (in lttng_lazy_probe_register() at lttng-probes.c:115)
> libust[3581/3581]: adding probe ust_tests_demo2 containing 1 events to lazy
> registration list (in lttng_probe_register() at lttng-probes.c:216)
> liblttng_ust_tracepoint[3581/3581]: just registered a tracepoints section
> from 0x804b144 and having 4 tracepoints (in tracepoint_register_lib() at
> tracepoint.c:767)
> liblttng_ust_tracepoint[3581/3581]: registered tracepoint:
> ust_tests_demo:starting (in tracepoint_register_lib() at tracepoint.c:772)
> liblttng_ust_tracepoint[3581/3581]: registered tracepoint:
> ust_tests_demo:done (in tracepoint_register_lib() at tracepoint.c:772)
> liblttng_ust_tracepoint[3581/3581]: registered tracepoint:
> ust_tests_demo2:loop (in tracepoint_register_lib() at tracepoint.c:772)
> liblttng_ust_tracepoint[3581/3581]: registered tracepoint:
> ust_tests_demo3:done (in tracepoint_register_lib() at tracepoint.c:772)
> Demo program starting.
> Tracing...  done.
> liblttng_ust_tracepoint[3581/3581]: just unregistered a tracepoints section
> from 0x804b144 (in tracepoint_unregister_lib() at tracepoint.c:797)
> libust[3581/3581]: Provider "ust_tests_demo2" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version()
> at lttng-probes.c:174)
> libust[3581/3581]: just unregistered probe ust_tests_demo2 (in
> lttng_probe_unregister() at lttng-probes.c:245)
> libust[3581/3581]: Provider "ust_tests_demo" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version()
> at lttng-probes.c:174)
> libust[3581/3581]: just unregistered probe ust_tests_demo (in
> lttng_probe_unregister() at lttng-probes.c:245)
> libust[3581/3581]: Provider "ust_tests_demo3" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version()
> at lttng-probes.c:174)
> libust[3581/3581]: just unregistered probe ust_tests_demo3 (in
> lttng_probe_unregister() at lttng-probes.c:245)
> libust[3581/3581]: Provider "lttng_ust_tracef" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version()
> at lttng-probes.c:174)
> libust[3581/3581]: just unregistered probe lttng_ust_tracef (in
> lttng_probe_unregister() at lttng-probes.c:245)
> libust[3581/3581]: LTT : ltt ring buffer client "relay-discard-rt-mmap" exit
> (in lttng_ring_buffer_client_discard_rt_exit() at
> lttng-ring-buffer-client.h:688)
> libust[3581/3581]: LTT : ltt ring buffer client "relay-discard-mmap" exit
> (in lttng_ring_buffer_client_discard_exit() at
> lttng-ring-buffer-client.h:688)
> libust[3581/3581]: LTT : ltt ring buffer client "relay-overwrite-rt-mmap"
> exit
> (in lttng_ring_buffer_client_overwrite_rt_exit() at
> lttng-ring-buffer-client.h:688)
> libust[3581/3581]: LTT : ltt ring buffer client "relay-overwrite-mmap" exit
> (in lttng_ring_buffer_client_overwrite_exit() at
> lttng-ring-buffer-client.h:688)
> libust[3581/3581]: LTT : ltt ring buffer client "relay-metadata-mmap" exit
> (in lttng_ring_buffer_metadata_client_exit() at
> lttng-ring-buffer-metadata-client.h:337)
> libust[3581/3581]: Provider "ust_baddr_statedump" accepted, version 1.0 is
> compatible with LTTng UST provider version 1.0. (in check_provider_version()
> at lttng-probes.c:174)
> libust[3581/3581]: just unregistered probe ust_baddr_statedump (in
> lttng_probe_unregister() at lttng-probes.c:245)
> liblttng_ust_tracepoint[3581/3581]: just unregistered a tracepoints section
> from 0xb757c780 (in tracepoint_unregister_lib() at tracepoint.c:797)
> row@cobra7:~/lttng_source/lttng-ust/doc/examples/demo$
> 
> 
> => no log in sessiond shell
> 
> 

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
