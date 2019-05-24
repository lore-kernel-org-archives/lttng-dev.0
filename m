From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-tools (2.11.0-rc2) and LTTng-UST
 (2.11.0-rc3) - Lafontaine
Date: Fri, 24 May 2019 17:25:20 -0400
Message-ID: <20190524212519.GA9974__49420.5600743712$1558733349$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52])
 by lists.lttng.org (Postfix) with ESMTPS id 459fY10xgJz12R4
 for <lttng-dev@lists.lttng.org>; Fri, 24 May 2019 17:25:24 -0400 (EDT)
Received: by mail-ua1-f52.google.com with SMTP id t18so4204537uar.4
 for <lttng-dev@lists.lttng.org>; Fri, 24 May 2019 14:25:24 -0700 (PDT)
Received: from gmail.com (192-222-181-218.qc.cable.ebox.net. [192.222.181.218])
 by smtp.gmail.com with ESMTPSA id 2sm4137757vke.27.2019.05.24.14.25.22
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 24 May 2019 14:25:22 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi everyone!

Today marks the release of two new release candidates of the LTTng
2.11 "Lafontaine" release cycle:
  * LTTng-UST   2.11.0-rc3
  * LTTng-tools 2.11.0-rc2

Please note that if you wish to try the new features introduced in
2.11, you must upgrade both LTTng-tools and LTTng-UST to these new
versions simultaneously. This is due to a bug fix that affects the ABI
between both projects.

Failing to upgrade both components at once will cause user space
tracing to fail.

This simultaneous upgrade requirement is unusual as mixing releases of
the various LTTng projects (tools, UST, and modules) within a given
release cycle is normally allowed. An exception is made since 2.11 is
still in its "release candidate" phase.

Note that it will remain possible to mix patch-level versions of the
LTTng components within a given release cycle. The same will apply to
2.11 once its final releases are made available.


This release is named after a modern Saison beer from Montr=E9al's
Oshlag microbrewery. It is a refreshing, zesty, rice beer with hints
of fruit and spices. Some even say it makes for a great Somaek when
mixed with Chamisul Soju, not that we've tried!

Lafontaine is also a tongue-in-cheek reference to a water leak that
affected EfficiOS's offices during the development of this release.

A summary of the new features introduced in LTTng 2.11 is available
here:
https://github.com/lttng/lttng-tools/releases/tag/v2.11.0-rc1

2019-05-24 (Scavenger Hunt Day) lttng-ust 2.11.0-rc3
	* Cleanup: bitfields: streamline use of underscores
	* Silence compiler "always false comparison" warning
	* Fix: bitfield: shift undefined/implementation defined behaviors
	* Fix: Update coding style link
	* Fix: alignment of ring buffer shm space reservation
	* Fix: allocate ts_end in ringbuffer shared memory
	* Fix: timestamp_end field should include all events within sub-buffer
	* ust-ctl API: clarify getter usage requirements
	* Fix: don't access packet header for stream_id and stream_instance_id get=
ters
	* compat: work around broken _SC_NPROCESSORS_CONF on MUSL libc
	* doc: remove repeated word in coding style
	* tap-driver.sh: flush stdout after each test result
	* Move wait_shm_mmap initialization to library constructor

2019-05-24 lttng-tools 2.11.0-rc2 (Asparagus Day)
	* Update base test for binding
	* Fix: python binding: expose domain buffer type
	* Clean-up: correct typo from epoll to poll
	* Clean code base from redundant verification
	* Change lttng_poll_wait behaviour of compat-poll to match compat-epoll
	* Fix: hang in thread_rotation when using compat-poll
	* Adapt poll layer behaviour to match the epoll layer
	* Change LTTNG_POLL_GETNB behaviour for poll flavor
	* Add Unit test to poll compatibility layer
	* Fix: lttng_poll_mod calls compat_(e)poll_add
	* Fix: getenv can return null
	* Bump LTTNG_UST_ABI to 8.0
	* Fix: directory handle credentials parameter is not const
	* doc: Add reference to USDT probes
	* Clean-up: Remove double buffer initialisation
	* Fix: getgrnam is not MT-Safe, use getgrnam_r
	* Fix: logging: log_add_time() save/restore errno
	* Fix relayd: initialize beacon to -1ULL
	* Fix: relayd: handling of lttng_read errors >=3D 0
	* Harmonize pprint macro across projects
	* Update the ac_define_dir macro from the autoconf archive
	* Harmonize rw_prog_cxx_works macro across projects
	* Namespace check_sdt_works custom macro
	* Update macros from the autoconf archive
	* Fix: relayd not spawned on default-url live session creation
	* Clean-up: remove empty line in lttng create command
	* Add mkdirat utils and runas wrappers
	* Clean-up: remove commented code from test
	* Fix tests: NULL pointer dereference in ltt_session unit tests
	* Fix tests: NULL pointer dereference in ust channel unit tests
	* Fix tests: NULL pointer dereference in ltt_ust_context unit tests
	* Fix tests: NULL pointer dereference in ltt_session unit tests
	* Log the wait-shm's path on shm_open failure
	* Generate session name and default output on sessiond's end
	* Move completed trace archive chunks to an "archives" sub-folder
	* Fix: lttng_rotate_session does not handle socket close
	* Fix: hide internal libcommon time utilities
	* lttng: make the configuration file interface const correct
	* Fix: command reply message is leaked for variable-len replies
	* Fix: skip test when ust doesn't have perf support
	* Tests: check for lttng-modules presence
	* Fix: Properly sanitize input parameter
	* Fix tests: link libpause_consumer on liblttng-ctl
	* tap-driver.sh: flush stdout after each test result
	* Fix tests: snapshot size validation failure runs too many test cases
	* Fix tests: the tree origin can be a symlink itself
	* Fix tests: skip test_getcpu_override on single core systems
	* Enforce DL_LIBS value instead of hard coded -ldl
	* Fix: Add POPT_CFLAGS to lttng_CFLAGS
	* Fix: consumer snapshot: handle unsigned long overflow
	* Clean-up: hide internal kernel_consumer_add_channel() symbol
	* Fix: no-output sessions do not enforce snapshot constraints
	* Fix: wrong error code returned by kernel_snapshot_record()
	* Clarify incorrect channel output type logging message
	* Mark lttng_kconsumer_snapshot_channel as static
	* Docs: clarify the meaning of the snapshot_mode flag in ltt_session
	* lttng: clean-up the printout of snapshot outputs
	* lttng: clean-up printout of session output destination
	* Docs: document the format of the lttng_session path member
	* Docs: lttng-ctl has no default live timer period
	* Fix: missing include can cause structures to not be packed
	* Fix: check illegal combinations of ctrl-url/data-url/ouput/set-url
	* Fix: lttng_uri structure must be packed as it is used for IPC
	* Fix: missing mentions of tracing session rotation in basic help
	* Fix: release reference to ltt_session on error instead of free()
	* Fix relayd: session leaked on communication error during creation
	* Prevent channel buffer allocation larger than memory
	* Fix: destroy called twice on quit pipe
	* Remove duplicate check for dlopen
	* Tests: take multiple snapshots in streaming mode
	* Fix: don't destroy the sockets if the snapshot was successful
	* Fix: run-as thread deadlock on itself in restart error path
	* Fix: session list lock must be held on session put operation
	* Support minute and hour as time suffixes
	* Test fix: passing bool argument to va_start is undefined
	* Fix: missing rcu read locking in trigger "unregister all" command
	* Fix: create_kernel_session asserts on failure
	* Fix: only free trace_path when it is dynamically allocated
	* Fix: wrong error check on kernel session creation
	* Fix: don't put() thread on shutdown failure
	* Fix: dereference on NULL pointer on allocation failure
	* Fix: leak of filter bytecode and expression on agent event re-enable
	* Test fix: python logging test spams its output
	* Fix: leak of lttng-consumerd global HTs in run-as worker
	* Fix: leak of sessiond configuration on launch of run-as worker
	* Fix: leak of rundir config string
	* Fix: only synchronize application configuration on tracing start
	* Fix: run_command_wait() handle partial write
	* Fix: do not repurpose iterator while it is being used
	* Fix: handle_notification_thread_command: handle partial read
	* Fix: notification thread: free session trigger list on error
	* Fix: notification thread: RCU-safe reclaim of hash table nodes
	* Fix: error logged on partial recvmsg() in MSG_DONTWAIT
	* Print UTF-8 SI suffix only when allowed by the locale
	* Cleanup: duplicate LDADD of libcommon for utils unit tests
	* Move time utils to their own time.c file
	* Fix: sessiond: don't allocate buffers and files for inactive sessions
	* Cleanup: ust start/stop trace
	* Fix: relayd: rotation pending off-by-one
	* Fix: tests: test_crash should start sessions
	* Fix: missing session reference release on kernel poll update
	* Fix: set client socket permissions after launch of client thread
	* Fix: use assignment-suppression for unused sscanf arguments
	* Fix: report initialization error of app registration thread
	* Fix: report initialization error of client thread
	* Cleanup: consumer socket creation debug msg always prints fd:-1
	* Cleanup: remove unused label
	* Fix: may be used uninitialized warnings
	* userspace-probe: tests: add testcase for unsupported instrumentation
	* userspace-probe: Print error on binary not found
	* userspace-probe: Print error for unsupported instrumentation mode
	* Fix: use sys/types.h for ssize_t on Cygwin
	* Add *.exe to gitignore for Cygwin
	* Revert stubbing of runas functions
	* Revert stubbing of unix socket functions
	* Fix: warning 'fd' may be used uninitialized
	* Fix: worker structure is leaked in run_as process
	* Fix: ensure the ht clean pipe is empty before processing quit pipe
	* Perform the clean-up of application notify sockets in main thread
	* Clean-up: remove redundant exit labels from sessiond initialization
	* Make the launch of the application registration thread blocking
	* Stop the application registration thread before orphaned threads
	* Rename ust-thread to notify-apps
	* Teardown the notification thread after the sessiond clean-up
	* Launch the consumer management thread using lttng_thread
	* Stop sessions before destroying on teardown of session daemon
	* Remove the sessiond "ready" counter mechanism
	* Load session configurations from lttng-sessiond's main thread
	* Launch the kernel management thread using lttng_thread
	* Launch agent management thread using lttng_thread
	* Mark lttng_pipe as const where possible
	* Launch the application notification thread using lttng_thread
	* Launch the application management thread with lttng_thread
	* Launch application registration thread using lttng_thread
	* Launch the ust registration dispatch thread using lttng_thread
	* Launch the client management thread using lttng_thread
	* Launch the timer thread using lttng_thread
	* Launch the rotation thread using lttng_thread
	* Fix: flush the rotation thread's job queue on exit
	* Stop rotation pending check timer from the rotation thread
	* Launch the notification thread using lttng_thread
	* Launch the health management thread using lttng_thread
	* Launch the ht-cleanup thread using lttng_thread util
	* Add a thread utility class and thread list
	* Don't perform an implicit rotation on session stop
	* Wait for the destruction of sessions before tearing down main thread
	* Fix: rotation_unavailable returned on failure to read time
	* Fix: mark rotation pending check timer is never marked as disabled
	* Acquire a reference to a session when a timer is active
	* Reference count ltt_session objects
	* Fix: session info reference is not put on unhandled condition type
	* Fix: typo 'occured' -> 'occurred'
	* Fix: typo 'retrive' -> 'retrieve'
	* Fix: typo 'convet' -> 'convert'
	* Fix: typo 'leat' -> 'least'
	* Fix: max_t/min_t macros are missing cast on input
	* Fix: Connect timeout arithmetic in inet/inet6 (v4)
	* Fix: cmd_snapshot_record can return unexpected error codes
	* Docs: document why a negative socket may be passed
	* lttng-enable-event.1.txt: fix SDT acronym, add missing "are supported"
	* lttng-enable-rotation.1.txt: --timer option should be fairly precise
	* doc/man: remove AUTHORS section
	* lttng-enable-event.1.txt: uprobe: update style and content
	* doc/man: add links between man pages about session rotation
	* lttng-enable-event.1.txt: document dynamic user space probes
	* lttng-{enable,disable}-rotation.1.txt: both types can be specified
	* lttng-disable-rotation.1.txt: remove LIMITATIONS section
	* lttng-enable-rotation.1.txt: add that SIZE/PERIOD are approximations
	* lttng-rotate.1.txt: lttng-relayd(8) also has --output option
	* Fix: sessiond: ust_app_rotate_session error handling
	* Fix: sessiond: snapshot: handle consumer return codes
	* Fix: consumer: snapshot error return code
	* Fix: sessiond: consumer.c: rotation error handling
	* Fix: consumer: rotation error return codes
	* Fix: create_channel_per_pid: remove channel on error
	* Fix: channel errors on local stress-tests
	* Fix: channel_ust_create: remove channel on agent error
	* Fix: cmd_rotate_session() returns unexpected error codes
	* Fix: session rotation logging statement references snapshot
	* Clean-up: typo in logging message Totation -> Rotation
	* Fix: rotation error may leave session in "ONGOING" state
	* Fix: session_list lock must be held to launch a rotation
	* Add an ASSERT_LOCKED(lock) macro
	* Clean-up: move global sessiond symbols out of main.o
	* Fix: split index and data file rotation logic
	* Fix: trace_archive_id is not sent in add_stream command
	* Fix: condition unsubscription error leaves session locked
	* Fix: rotation thread does not unregister from RCU on init error
	* Remove unused nr_stream_rotate_pending from consumer channel
	* Fix: session destruction blocks indefinitely if rotation is ongoing
	* Clean-up: remove non-existent function's declaration
	* Always choose large event header for UST channels
	* Fix relayd: stream index file created in the wrong directory
	* relayd: add payload logging to session rotation commands
	* relayd: rename stream prev_seq to prev_data_seq
	* Fix: take index seq number into account for rotation pending check
	* Fix: take index sequence number into account for data pending check
	* relayd: keep track of prev_index_seq in relayd_stream
	* Fix: session conditions not evaluated at subscription/registration
	* Remove unnecessary check of output parameter
	* Allow get_next_notification to return when interrupted
	* Fix: register rotation thread as RCU thread
	* Docs: comment typo fix (accomodates -> accommodates)
	* Fix: uninitialized variable may be used in local rotation check
	* Rename sessiond-timer.[hc] to timer.[hc]
	* Fix: rotation may never complete in per-PID buffering mode
	* Fix: perform local data pending before checking data pending with relayd
	* Fix: missing header breaks the cygwin build
	* Fix: double put on error path
	* Fix: holding the stream lock does not equate to having data pending
	* Fix: skip uid registry when metadata key is 0
	* Docs: document the meaning of a ust app channel key set to 0
	* Fix: acquire stream lock during kernel metadata snapshot
	* Fix: skip closed session on viewer listing
	* Fix: use LTTNG_VIEWER_ATTACH_UNK to report a closed session
	* Doc: withinin -> within
	* Fix: cleanup relayd sockets on rotation command communication error
	* Fix: perform relayd socket pair cleanup on control socket error
	* Fix: relayd control socket mutex is not destroyed
	* Tests: do not bound test app iterations when in background mode
	* Tests: add missing rotation and autoload tests to check target
	* Tests: remove temporary folder
	* Tests: remove mi result files when done
	* Tests: Remove unused set +x
	* Tests: Kill relayd after sessiond to ensure a clean tear down
	* Tests: Remove unused variable
	* Tests: Use stop relayd from utils.sh
	* Tests: remove declaration already present in utils.sh
	* Tests: added test_autoload to noinst_SCRIPTS
	* Fix: Memory leak on run_as worker restart error path
	* Fix: non-zero return of open handled as error
	* Fix: global run_as worker lock released during restart
	* Fix: runas worker attempts to send invalid fd to master
	* Fix runas: don't attempt close negative fd
	* Fix: tests: missing frame pointer for callstack test on some compiler
	* Add release name and description to configure.ac

Links
---

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.0-rc2.tar.bz2
https://lttng.org/files/lttng-ust/lttng-ust-2.11.0-rc3.tar.bz2

J=E9r=E9mie
