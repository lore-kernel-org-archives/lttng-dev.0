From: =?UTF-8?Q?J=C3=A9r=C3=A9mie_Galarneau?= <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.7.0-rc1
Date: Wed, 15 Jul 2015 23:56:45 -0400
Message-ID: <CA+jJMxttDqFcpJc9La3h_UqYhYfbMgMMGMuijCaH-UT=bFXyug__19074.9733047143$1437019081$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0798874009=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jeremie.galarneau@gmail.com>) id 1ZFaHz-0001gn-Hx
 for lttng-dev@lists.lttng.org; Wed, 15 Jul 2015 23:56:55 -0400
Received: by pactm7 with SMTP id tm7so35486642pac.2
 for <lttng-dev@lists.lttng.org>; Wed, 15 Jul 2015 20:56:45 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============0798874009==
Content-Type: multipart/alternative; boundary=047d7b162bc55f0806051af60f96

--047d7b162bc55f0806051af60f96
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Oy=C3=A9 Oy=C3=A9, dear LTTng fellows!

I am proud to announce the availability of the first LTTng-Tools 2.7 -
"Herbe =C3=A0 D=C3=A9tourne" release candidate. As per usual, this release =
bears the
codename of a Qu=C3=A9bec-brewed beer.

Brewed with unrestrained amounts of Citra hop, the Herbe =C3=A0 D=C3=A9tour=
ne is a
fantastic New World Tripel brewed by "Dieu du Ciel!". Aromas of mango,
cantaloupe melon and passion fruit, combined with a controlled bitter
finish,
unite in making this smooth golden-orange beer stand apart.

We are still hard at work fixing a handful of last-minute issues (see our
bug
tracker), integrating more tests for the latest features, and updating the
documentation before we make a final release available.

However, that doesn't mean you can't try out the latest features today!

--- Process (PID) Tracker ---
The new "track" and "untrack" commands allows the tracking of events
associated
with specific PIDs, both in user space and kernel space.

For example, the following commands may be used to track all user space
events
of PID "1234":
$ lttng create my_session
$ lttng track --userspace --pid 1234
$ lttng enable-event --userspace --all
$ lttng start

--- Python Logging Support ---
Following in the footsteps of the Java Util Logging and Log4J logging
backend
support, which were introduced as part of LTTng 2.4 and LTTng 2.6
respectively,
this new version adds support for the Python logging backend. This means
that
logging statements emitted by the Python logging module can now be
collected as
part of user space traces by enabling events from the "python" domain.

$ lttng create my_session
$ lttng enable-event --python --all
$ lttng start

The lttngust Python module is provided as part of LTTng-UST 2.7.
https://github.com/lttng/lttng-ust/tree/master/liblttng-ust-python-agent

--- Kernel tracer filtering support ---
While LTTng-UST has provided support for event filtering for a long time,
it was not possible to perform kernel-side event filtering until now. As of
this version,
Kernel space filters can be used in the same way as user space filters.

For instance, to trace only read() syscalls requesting more than 100 bytes:
$ lttng create my_session
$ lttng enable-event --kernel --syscall read --filter "count > 100"
$ lttng start

--- Kernel tracer wildcard support ---
Support for wildcards in event names is another feature that has been
brought
from the user space tracer to the kernel tracer. This means that groups of
kernel space events can be enabled at once using the wildcard notation.

The tracing of all block device or scheduling events can be enabled using a
single command:

$ lttng enable-event --kernel block*
or
$ lttng enable-event --kernel sched*

--- File-backed user space buffers ---
This new LTTng-UST feature allows the mapping of ring buffers onto
filesystems.
This proves useful in combination with pramfs or DAX+pmem (Linux kernels
4.1+
for DAX and 4.2+ for pmem) to store tracer ring buffers in persistent memor=
y
upon
an unexpected system reboot.

These buffers can be salvaged and converted to regular CTF traces using the
newly introduced lttng-crash utility to see the events that led to a crash.

--- Support for clock and getcpu plugins ---
In the interest of keeping LTTng as unintrusive as possible, LTTng 2.7
introduces support for platform-specific plug-ins providing custom
implementations of getcpu() (user space) and clock sources for both kernel
and
user space tracers.

getcpu override plugins can prove useful in cases where direct hardware
access
is available for architecture-specific registers storing the CPU number, an=
d
where those should be used instead of the Linux kernel sched_getcpu()
vDSO/syscall.

clock override plugins, which may be implemented as shared objects (user
space)
or kernel modules (kernel space) may prove userful in cases where direct
hardware access to architecture-specific clocks is available, and when it
should
be used in place of the Linux kernel Monotonic clock.

--- tracelog() support ---
LTTng-UST 2.7 provides a number of facilities to smoothen the transition of
applications from logging to tracing in the form of tracelog() tracepoints.
LTTng-UST 2.7's announcement covers this feature in more detail:

http://lists.lttng.org/pipermail/lttng-dev/2015-July/024757.html

Of course, we will cover all of these new features in depth in an upcoming
post
on the official LTTng blog at lttng.org/blog in time for the final release.

2015-07-15 lttng-tools 2.7.0-rc1 (Pet Fire Safety Day)
* Update version to v2.7.0-rc1
* Tests: lttng-ust-getcpu-override-test cache and error-check sysconf()
* Tests: lttng-ust-getcpu-override coding-style adjustments
* Add CPU_ID LTTng-UST context to enum lttng_ust_context_type
* Bump LTTNG_UST_ABI_MAJOR_VERSION to 6
* Tests: Ust getcpu override plugin
* Fix: Follow struct dirent allocation guidelines of READDIR(3)
* Update comments regarding the power of 2 constraint on sub-buffer sizes
* Build: add Flex version check
* Build: add Bison version check
* Fix: handle sys_futex() FUTEX_WAIT interrupted by signal
* Fix: metadata push -EPIPE should be recoverable
* Fix: destroy session removes the default config file
* Build: bump autoconf version requirement to 2.64
* Fix: Memory leak in setup of relayd_path
* Fix: update liburcu URL
* Fix: test: use "$@" to pass and quote argument
* Refactor: test: wrapper for lttng_snapshot_del_output
* Refactor: test: wrapper for lttng_snapshot_add_output
* Refactor: test: wrapper for destroy_lttng_session
* Refactor: test: wrapper for stop_lttng_tracing
* Refactor: test: wrapper for start_lttng_tracing
* Refactor: test: wrapper for enable_ust_lttng_event
* Refactor: test: wrapper for enable_ust_lttng_channel
* Refactor: test: wrapper for create_lttng_session
* Fix: Memory allocated by xmlNodeGetContent() must be freed by xmlFree()
* Save/load: add support for shared memory path
* Fix: get_cmdline_by_pid path length assumes a max pid of 65535
* Clean-up: Remove ifdef-ed out lttng list options
* Test: mi: test for greater or equal to a minimum of events on ust listing=
.
* Fix: update regression tests involving UST
* Clean-up: Remove ifdef-ed out function:entry feature
* Fix: Mark MI and Config string declarations as extern
* Clean-up append_list_to_probes()
* Fix: modprobe.c: fix tmp_list memory leak
* Fix: append_list_to_probes(): increment index
* Docs: LTTNG(1) filtering is now supported by the kernel tracer
* Fix: live_test regression on large number of cpus
* Fix: set UST register timeout to -1 as test default
* Man page: reference lttng-crash under --shm-path option
* Tests: Don't rely on implicit scalar expression dereference
* man pages: use standard NAME format
* Fix python bindings' Makefile for out-of-tree builds
* Fix: use LIBS instead of AM_LDFLAGS for dl and c linking
* Fix: Add missing -ldl when checking for lttng-ust
* clock plugin: increase offset measurement accuracy
* Implement UST clock override plugin support
* Fix: ownership of filter and filter_expression
* Fix: zero memory passed to create channel kernel ioctl
* Fix: Check that lttng create --live's time is not zero
* Fix: Validate lttng_create_session_live's timer is > 0
* UI: Only show live timer when the session is in live mode
* UI: Only show tracker PID state when enabled
* Implement kernel filter support
* syscall tracing: update tests
* Support lttng-modules syscall wildcards
* Implement lttng-modules tracepoint wildcard support
* Fix build when configuring with --disable-lttng-ust
* Fix: add missing function prototype to trace-ust.h header
* Implement PID tracker content listing
* Implement UST PID tracker
* Cleanup: Remove unimplemented UST domains
* Implement PID tracking for kernel tracing
* Fix: leak on error in lttng-crash
* Man page fixes: missing --version option and typo
* Docs: add lttng-crash(1) man page
* Docs: lttng-crash refers to "lttng"
* Fix: possible use of uninitialized data in loglevel conversion funcs
* Fix: possible evaluation of garbage values in fini_validation_ctx()
* Cleanup: Remove stale #ifdef-ed-out code from spawn_viewer()
* Fix: Possible call to execvp with NULL argument on allocation failure
* Fix: Possible call to strtoul() with NULL argument
* Docs: clarify lttng.1 shm-path section
* Fix: Missing return value check in extract_trace_recursive()
* Fix: recursive_rmdir: empty all empty subdir
* Move file creation/unlink from liblttng-ust-ctl to consumerd
* lttng-crash: support recursive traces
* shm-path: remove directory hierarchy on destroy
* Implement --shm-path option for UST sessions (per-uid channels)
* Cleanup: Reduce scope of connections in main relayd thread
* Cleanup: Reduce scope of relayd connections in live thread
* Docs: connection_find_by_sock() must be called with rcu_read_lock
* Rename current release as 2.7.0-pre
* Docs: grammar fix in Makefile
* Change release name to master
* configure: add type availability checking
* configure: add check for compiler inline keyword support
* configure: missing check for needed header
* configure: missing check of functions
* Fix: test: log4j: missing static test files for dist and out of tree buil=
d
* Fix: test: java-jul:missing static test files for dist and out of tree
build
* Fix: out-of-tree build: missing xsd file for mi test execution
* Fix: out-of-tree build: missing xsd file for save-load test execution
* Cleanup: remove unused end_no_session label in ust_app_flush_session()
* Cleanup: Remove unused "end" label in push_metadata()
* Tests: Run health check test_thread_ok as part of root_regression
* Fix: deadlock between UST registry lock and consumer lock
* Fix: uninitialized return value
* Fix: build failure using disable-lttng-ust configure option
* Cleanup: Remove unused variable
* Fix: setuid/setgid daemons should not get sensitive env. var./args
* Fix: grab more than one packet for snapshots
* Fix: per-uid flush and ust registry locking
* Docs: Missing optional dependency on lttng-ust in README.md
* Docs: Grammar fixes in the lttng manpage
* Fix: add missing UST perf counter support check
* Fix: tests: integer too large for long type
* Fix: undefined operation on last_relay_viewer_session_id
* Fix: print format type mismatch
* Fix: print format type mismatch
* Fix: Remove structurally dead code from relayd
* Cleanup: Remove logically dead code
* Cleanup: Remove unused label
* Fix: Remove unused argument in debug statement
* Fix: exit threads not only on goto restart
* Fix: poll: show the correct number of fds
* Fix: call lttng_poll_set_max_size before start threads
* Fix: compat poll: add missing empty revents checks
* Fix: various compat poll/epoll issues
* Add debugging output to ht-cleanup thread
* Fix: mi: snapshot: missing error handling for session name
* Fix: ust-app: per-PID app unregister vs tracing stop races
* Fix: data pending: allow empty streams
* Fix: ust snapshot: cleanup after error
* Fix: Mismatching return type in ust_app_ht_alloc() stub
* Cleanup: lock file already taken is error, not warning
* Fix: ust-app null pointer check needed for main refactoring
* Cleanup: relayd: centralize thread stopping function
* Cleanup: Replace all perror() uses by the PERROR macro
* Refactor relayd main/set_options/cleanup
* Refactor consumerd main/cleanup
* Refactor sessiond main/cleanup/ht-cleanup
* Missing error handling: consumer_signal_init should return its error
status
* Cleanup: consumerd: lines over 80 columns
* Cleanup: consumerd: use PERROR rather than perror
* Cleanup: lttng-consumerd: remove stale TODO comment
* Misleading error handling: utils_create_pid_file() should return 0 on
success
* Missing error handling: consumerd parse_args should return errors to
caller
* Missing error handling: ust_app_ht_alloc should return error status
* Fix: ust app leak on UST buffer creation error
* Fix: leak on UST buffer registry creation error
* Fix: agents ht leaks on destroy session
* Fix: add missing RCU read unlock
* Fix: help message for Python agent mentions Java
* Fix: don't destroy the sockets if the snapshot was successful
* Fix: Missing RCU read locks in syscall_list_channel()
* Fix: Missing RCU read lock in kernel_destroy_session()
* Fix: channel names are not validated
* Cleanup: Missing whitespace
* Fix: Apply consumer URI changes to all domains
* Cleanup: Fix a typo in the MI tests
* Test fix: Don't invoke the system's lttng client
* Tests: Add a test to check disabled events are loaded in the correct stat=
e
* Fix: Don't leave events enabled if they were saved in a disabled state
* Fix: "Any" loglevel's value is -1 and not 0
* Test fix: LTTNG_SESSION_CONFIG_XSD_PATH expects an absolute path
* Fix: Memory leak on error in alloc_argv_from_user_opts()
* Cleanup: Unchecked close() return value in utils_create_lock_file()
* Cleanup: No check of the return value of lttng_ht_del()
* Cleanup: Mixed enums used for return code in send_sessiond_channel()
* Cleanup: Cast poll() return value to void
* Fix: Unreachable error logging in set_option()
* Fix: OOM leaks in sessiond modprobe.c
* Cleanup: sessiond modprobe.c: coding style
* Cleanup: test_utils_expand_path.c prototypes
* Fix: test_utils_expand_path.c: out of memory error handling
* Fix: test test_ust_data.c: check OOM
* Fix: test libc-wrapper: check malloc OOM
* Cleanup: test libc-wrapper: main parameters
* Fix: lttng-ctl: use zmalloc(), missing OOM check
* Fix: filter-parser.y: use zmalloc(), missing OOM check
* Fix: utils.c: check str*dup OOM
* Cleanup: implement zmalloc as static inline
* Fix: rculfhash: use zmalloc()
* Fix: ini.c: use zmalloc()
* Fix: lttng lttng.c: check strdup OOM
* Fix: lttng conf.c: use zmalloc()
* Fix: lttng view.c missing strdup OOM check
* Fix: use zmalloc() in lttng view.c
* Fix: use zmalloc() in lttng list.c
* Fix: oom error check, realloc oom leak
* Fix: use zmalloc in lttng enable_events.c
* Fix: missing strdup oom check in lttng create.c
* Fix: lttng add_context.c: use zmalloc
* Cleanup: add missing static to function modprobe_remove_lttng()
* Fix: add missing str*dup oom check in sessiond main.c
* Fix: add missing sessiond kernel-consumer missing str*dup oom checks
* Fix: add missing strdup OOM check
* Fix: add missing synchronization point for before app test case
* Fix: tests: wait output hide Terminate errors
* Fix: tests: remove killall, add missing SIGTERM handlers
* Fix: high throughput test: reset bw limit on sigterm
* Fix: tests: add missing wait, document missing synchro
* Document test anti-patterns
* Fix: test flaky sleep and wait patterns
* Fix: tests: don't use pidof to wait for test apps
* Fix: Live tracing does not honor live timer after first tracefile with
tracefile rotation
* Fix: Handle empty daemon configuration file lines
* Docs: Add -f/--config option to lttng-sessiond man page
* Cleanup: spaghetti function return path
* Fix: relayd: unbalanced RCU read-side lock/unlock
* Fix: relayd: unbalanced RCU read lock/unlock
* Fix: lttng-relayd: unhandled out of memory error
* Fix: relayd viewer stream: unhandled out of memory error
* Build fix: Apps defining _LGPL_SOURCE must link to urcu-bp
* Define _LGPL_SOURCE in test apps' tracepoint provider files
* Define _LGPL_SOURCE in test applications
* Fix: Missing rcu_read_lock in cmd_list_events()
* Fix: Missing rcu_read_lock in list_lttng_agent_events()
* Fix: Missing rcu_read_lock in cmd_list_channels()
* Fix: Missing rcu_read_locks in cmd_list_domains()
* Fix: Missing rcu_read_lock in cmd_snapshot_list_outputs()
* Fix: Missing rcu_read_lock in save_domains()
* Fix: Missing rcu_read_lock in ust_app_get_nb_stream()
* Fix: UST subbuffers silently dropped on moderate trace traffic
* Fix: Missing rcu_read_lock in get_session_max_subbuf_size()
* Fix: create/destroy a splice_pipe per stream
* Note find_ust_app_context must be called with RCU read lock
* Fix: empty indexes_ht before destroying it.
* Fix: removed useless key from relay_index
* Fix: Ambiguous agent event filter bytecode ownership
* Fix: filter bytecode and string memory leak on error
* Fix: define _LGPL_SOURCE in C files
* Fix: HT must not be destroyed with a rcu_read_lock held
* Fix: agent events HT should be destroyed from the cleanup thread
* Fix: missing rcu_read_lock in trace_ust_destroy_session()
* Fix: missing rcu_read_lock when calling trace_ust_find_agent()
* Fix: missing rcu_read_lock in cmd_start_trace()
* Cleanup: remove "disabled" flag for new release cycle
* Fix: filter attach vs event enable race
* Fix: Mark libxml2 as a mandatory dependency
* Fix: Warn the user when enabling an event in a new domain
* Fix: Don't report an error when listing a session with no channels
* Bypass 0 byte allocation when no domains are enabled
* Fix: Add missing URCU_TLS access to error_log_time
* Fix: check userspace perf counter name when looking up contexts
* Update maintainer section of the man pages
* Update maintainer section of README.md
* Fix: add README.md to documentation files
* Fix: UST consumer sync all available metadata
* Test: remove bogus argument from prove invocation
* Fix: typo in pythong test Makefile
* Fix: memory leak in libconfig
* Add Python agent support
* Fix: return EINVAL if agent registration fails
* Use lttng-modules ABI version ioctl
* Fix: syscall list ioctl number conflict
* Update master ChangeLog with 2.5.1 release

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download links:
https://lttng.org/files/lttng-tools/lttng-tools-2.7.0-rc1.tar.bz2
GPG sig:
https://lttng.org/files/lttng-tools/lttng-tools-2.7.0-rc1.tar.bz2.asc

Looking forward to your feedback!

J=C3=A9r=C3=A9mie

--=20
J=C3=A9r=C3=A9mie Galarneau
EfficiOS Inc.
http://www.efficios.com

--047d7b162bc55f0806051af60f96
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Oy=C3=A9 Oy=C3=A9, dear LTTng fellows!</div><div><br>=
</div><div>I am proud to announce the availability of the first LTTng-Tools=
 2.7 -</div><div>&quot;Herbe =C3=A0 D=C3=A9tourne&quot; release candidate. =
As per usual, this release bears the</div><div>codename of a Qu=C3=A9bec-br=
ewed beer.</div><div><br></div><div>Brewed with unrestrained amounts of Cit=
ra hop, the Herbe =C3=A0 D=C3=A9tourne is a</div><div>fantastic New World T=
ripel brewed by &quot;Dieu du Ciel!&quot;. Aromas of mango,</div><div>canta=
loupe melon and passion fruit, combined with a controlled bitter finish,</d=
iv><div>unite in making this smooth golden-orange beer stand apart.</div><d=
iv><br></div><div>We are still hard at work fixing a handful of last-minute=
 issues (see our bug</div><div>tracker), integrating more tests for the lat=
est features, and updating the</div><div>documentation before we make a fin=
al release available.</div><div><br></div><div>However, that doesn&#39;t me=
an you can&#39;t try out the latest features today!</div><div><br></div><di=
v>--- Process (PID) Tracker ---</div><div>The new &quot;track&quot; and &qu=
ot;untrack&quot; commands allows the tracking of events associated</div><di=
v>with specific PIDs, both in user space and kernel space.</div><div><br></=
div><div>For example, the following commands may be used to track all user =
space events</div><div>of PID &quot;1234&quot;:</div><div>$ lttng create my=
_session</div><div>$ lttng track --userspace --pid 1234</div><div>$ lttng e=
nable-event --userspace --all</div><div>$ lttng start</div><div><br></div><=
div>--- Python Logging Support ---</div><div>Following in the footsteps of =
the Java Util Logging and Log4J logging backend<br></div><div>support, whic=
h were introduced as part of LTTng 2.4 and LTTng 2.6 respectively,</div><di=
v>this new version adds support for the Python logging backend. This means =
that</div><div>logging statements emitted by the Python logging module can =
now be collected as</div><div>part of user space traces by enabling events =
from the &quot;python&quot; domain.</div><div><br></div><div>$ lttng create=
 my_session</div><div>$ lttng enable-event --python --all</div><div>$ lttng=
 start</div><div><br></div><div>The lttngust Python module is provided as p=
art of LTTng-UST 2.7.</div><div><a href=3D"https://github.com/lttng/lttng-u=
st/tree/master/liblttng-ust-python-agent">https://github.com/lttng/lttng-us=
t/tree/master/liblttng-ust-python-agent</a></div><div><br></div><div>--- Ke=
rnel tracer filtering support ---</div><div>While LTTng-UST has provided su=
pport for event filtering for a long time,</div><div>it was not possible to=
 perform kernel-side event filtering until now. As of this version,</div><d=
iv>Kernel space filters can be used in the same way as user space filters.<=
/div><div><br></div><div>For instance, to trace only read() syscalls reques=
ting more than 100 bytes:</div><div>$ lttng create my_session</div><div>$ l=
ttng enable-event --kernel --syscall read --filter &quot;count &gt; 100&quo=
t;</div><div>$ lttng start</div><div><br></div><div>--- Kernel tracer wildc=
ard support ---</div><div>Support for wildcards in event names is another f=
eature that has been brought</div><div>from the user space tracer to the ke=
rnel tracer. This means that groups of</div><div>kernel space events can be=
 enabled at once using the wildcard notation.</div><div><br></div><div>The =
tracing of all block device or scheduling events can be enabled using a</di=
v><div>single command:</div><div><br></div><div>$ lttng enable-event --kern=
el block*</div><div>or</div><div>$ lttng enable-event --kernel sched*</div>=
<div><br></div><div>--- File-backed user space buffers ---</div><div><span =
style=3D"font-size:12.8000001907349px">This new LTTng-UST feature allows th=
e mapping of ring buffers onto filesystems.</span></div><div><span style=3D=
"font-size:12.8000001907349px">This proves useful</span><span style=3D"font=
-size:12.8000001907349px">=C2=A0in combination with pramfs or DAX+pmem (Lin=
ux kernels 4.1+</span></div><div><span style=3D"font-size:12.8000001907349p=
x">for DAX and=C2=A0</span><span style=3D"font-size:12.8000001907349px">4.2=
+ for pmem) to store tracer ring buffers in persistent=C2=A0</span><span st=
yle=3D"font-size:12.8000001907349px">memory upon</span></div><div><span sty=
le=3D"font-size:12.8000001907349px">an unexpected system reboot.</span></di=
v><div><span style=3D"font-size:12.8000001907349px"><br></span></div><div><=
span style=3D"font-size:12.8000001907349px">These buffers can be salvaged a=
nd converted to regular CTF traces using the</span></div><div><span style=
=3D"font-size:12.8000001907349px">newly introduced lttng-crash utility to s=
ee the events that led to a crash.</span></div><div><br></div><div>--- Supp=
ort for clock and getcpu plugins ---</div><div>In the interest of keeping L=
TTng as unintrusive as possible, LTTng 2.7</div><div>introduces support for=
 platform-specific plug-ins providing custom</div><div>implementations of g=
etcpu() (user space) and clock sources for both kernel and</div><div>user s=
pace tracers.</div><div><br></div><div>getcpu override plugins can prove us=
eful in cases where direct hardware access</div><div>is available for archi=
tecture-specific registers storing the CPU number, and</div><div>where thos=
e should be used instead of the Linux kernel sched_getcpu()</div><div>vDSO/=
syscall.</div><div><br></div><div>clock override plugins, which may be impl=
emented as shared objects (user space)</div><div>or kernel modules (kernel =
space) may prove userful in cases where direct</div><div>hardware access to=
 architecture-specific clocks is available, and when it should</div><div>be=
 used in place of the Linux kernel Monotonic clock.</div><div><br></div><di=
v>--- tracelog() support ---</div><div>LTTng-UST 2.7 provides a number of f=
acilities to smoothen the transition of</div><div>applications from logging=
 to tracing in the form of tracelog() tracepoints.</div><div>LTTng-UST 2.7&=
#39;s announcement covers this feature in more detail:</div><div><br></div>=
<div><a href=3D"http://lists.lttng.org/pipermail/lttng-dev/2015-July/024757=
.html">http://lists.lttng.org/pipermail/lttng-dev/2015-July/024757.html</a>=
</div><div><br></div><div>Of course, we will cover all of these new feature=
s in depth in an upcoming post</div><div>on the official LTTng blog at <a h=
ref=3D"http://lttng.org/blog">lttng.org/blog</a> in time for the final rele=
ase.</div><div><br></div><div>2015-07-15 lttng-tools 2.7.0-rc1 (Pet Fire Sa=
fety Day)</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Up=
date version to v2.7.0-rc1</div><div><span class=3D"" style=3D"white-space:=
pre">	</span>* Tests: lttng-ust-getcpu-override-test cache and error-check =
sysconf()</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Te=
sts: lttng-ust-getcpu-override coding-style adjustments</div><div><span cla=
ss=3D"" style=3D"white-space:pre">	</span>* Add CPU_ID LTTng-UST context to=
 enum lttng_ust_context_type</div><div><span class=3D"" style=3D"white-spac=
e:pre">	</span>* Bump LTTNG_UST_ABI_MAJOR_VERSION to 6</div><div><span clas=
s=3D"" style=3D"white-space:pre">	</span>* Tests: Ust getcpu override plugi=
n</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: Follo=
w struct dirent allocation guidelines of READDIR(3)</div><div><span class=
=3D"" style=3D"white-space:pre">	</span>* Update comments regarding the pow=
er of 2 constraint on sub-buffer sizes</div><div><span class=3D"" style=3D"=
white-space:pre">	</span>* Build: add Flex version check</div><div><span cl=
ass=3D"" style=3D"white-space:pre">	</span>* Build: add Bison version check=
</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: handle=
 sys_futex() FUTEX_WAIT interrupted by signal</div><div><span class=3D"" st=
yle=3D"white-space:pre">	</span>* Fix: metadata push -EPIPE should be recov=
erable</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: =
destroy session removes the default config file</div><div><span class=3D"" =
style=3D"white-space:pre">	</span>* Build: bump autoconf version requiremen=
t to 2.64</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fi=
x: Memory leak in setup of relayd_path</div><div><span class=3D"" style=3D"=
white-space:pre">	</span>* Fix: update liburcu URL</div><div><span class=3D=
"" style=3D"white-space:pre">	</span>* Fix: test: use &quot;$@&quot; to pas=
s and quote argument</div><div><span class=3D"" style=3D"white-space:pre">	=
</span>* Refactor: test: wrapper for lttng_snapshot_del_output</div><div><s=
pan class=3D"" style=3D"white-space:pre">	</span>* Refactor: test: wrapper =
for lttng_snapshot_add_output</div><div><span class=3D"" style=3D"white-spa=
ce:pre">	</span>* Refactor: test: wrapper for destroy_lttng_session</div><d=
iv><span class=3D"" style=3D"white-space:pre">	</span>* Refactor: test: wra=
pper for stop_lttng_tracing</div><div><span class=3D"" style=3D"white-space=
:pre">	</span>* Refactor: test: wrapper for start_lttng_tracing</div><div><=
span class=3D"" style=3D"white-space:pre">	</span>* Refactor: test: wrapper=
 for enable_ust_lttng_event</div><div><span class=3D"" style=3D"white-space=
:pre">	</span>* Refactor: test: wrapper for enable_ust_lttng_channel</div><=
div><span class=3D"" style=3D"white-space:pre">	</span>* Refactor: test: wr=
apper for create_lttng_session</div><div><span class=3D"" style=3D"white-sp=
ace:pre">	</span>* Fix: Memory allocated by xmlNodeGetContent() must be fre=
ed by xmlFree()</div><div><span class=3D"" style=3D"white-space:pre">	</spa=
n>* Save/load: add support for shared memory path</div><div><span class=3D"=
" style=3D"white-space:pre">	</span>* Fix: get_cmdline_by_pid path length a=
ssumes a max pid of 65535</div><div><span class=3D"" style=3D"white-space:p=
re">	</span>* Clean-up: Remove ifdef-ed out lttng list options</div><div><s=
pan class=3D"" style=3D"white-space:pre">	</span>* Test: mi: test for great=
er or equal to a minimum of events on ust listing.</div><div><span class=3D=
"" style=3D"white-space:pre">	</span>* Fix: update regression tests involvi=
ng UST</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Clean=
-up: Remove ifdef-ed out function:entry feature</div><div><span class=3D"" =
style=3D"white-space:pre">	</span>* Fix: Mark MI and Config string declarat=
ions as extern</div><div><span class=3D"" style=3D"white-space:pre">	</span=
>* Clean-up append_list_to_probes()</div><div><span class=3D"" style=3D"whi=
te-space:pre">	</span>* Fix: modprobe.c: fix tmp_list memory leak</div><div=
><span class=3D"" style=3D"white-space:pre">	</span>* Fix: append_list_to_p=
robes(): increment index</div><div><span class=3D"" style=3D"white-space:pr=
e">	</span>* Docs: LTTNG(1) filtering is now supported by the kernel tracer=
</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: live_t=
est regression on large number of cpus</div><div><span class=3D"" style=3D"=
white-space:pre">	</span>* Fix: set UST register timeout to -1 as test defa=
ult</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Man page=
: reference lttng-crash under --shm-path option</div><div><span class=3D"" =
style=3D"white-space:pre">	</span>* Tests: Don&#39;t rely on implicit scala=
r expression dereference</div><div><span class=3D"" style=3D"white-space:pr=
e">	</span>* man pages: use standard NAME format</div><div><span class=3D""=
 style=3D"white-space:pre">	</span>* Fix python bindings&#39; Makefile for =
out-of-tree builds</div><div><span class=3D"" style=3D"white-space:pre">	</=
span>* Fix: use LIBS instead of AM_LDFLAGS for dl and c linking</div><div><=
span class=3D"" style=3D"white-space:pre">	</span>* Fix: Add missing -ldl w=
hen checking for lttng-ust</div><div><span class=3D"" style=3D"white-space:=
pre">	</span>* clock plugin: increase offset measurement accuracy</div><div=
><span class=3D"" style=3D"white-space:pre">	</span>* Implement UST clock o=
verride plugin support</div><div><span class=3D"" style=3D"white-space:pre"=
>	</span>* Fix: ownership of filter and filter_expression</div><div><span c=
lass=3D"" style=3D"white-space:pre">	</span>* Fix: zero memory passed to cr=
eate channel kernel ioctl</div><div><span class=3D"" style=3D"white-space:p=
re">	</span>* Fix: Check that lttng create --live&#39;s time is not zero</d=
iv><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: Validate =
lttng_create_session_live&#39;s timer is &gt; 0</div><div><span class=3D"" =
style=3D"white-space:pre">	</span>* UI: Only show live timer when the sessi=
on is in live mode</div><div><span class=3D"" style=3D"white-space:pre">	</=
span>* UI: Only show tracker PID state when enabled</div><div><span class=
=3D"" style=3D"white-space:pre">	</span>* Implement kernel filter support</=
div><div><span class=3D"" style=3D"white-space:pre">	</span>* syscall traci=
ng: update tests</div><div><span class=3D"" style=3D"white-space:pre">	</sp=
an>* Support lttng-modules syscall wildcards</div><div><span class=3D"" sty=
le=3D"white-space:pre">	</span>* Implement lttng-modules tracepoint wildcar=
d support</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fi=
x build when configuring with --disable-lttng-ust</div><div><span class=3D"=
" style=3D"white-space:pre">	</span>* Fix: add missing function prototype t=
o trace-ust.h header</div><div><span class=3D"" style=3D"white-space:pre">	=
</span>* Implement PID tracker content listing</div><div><span class=3D"" s=
tyle=3D"white-space:pre">	</span>* Implement UST PID tracker</div><div><spa=
n class=3D"" style=3D"white-space:pre">	</span>* Cleanup: Remove unimplemen=
ted UST domains</div><div><span class=3D"" style=3D"white-space:pre">	</spa=
n>* Implement PID tracking for kernel tracing</div><div><span class=3D"" st=
yle=3D"white-space:pre">	</span>* Fix: leak on error in lttng-crash</div><d=
iv><span class=3D"" style=3D"white-space:pre">	</span>* Man page fixes: mis=
sing --version option and typo</div><div><span class=3D"" style=3D"white-sp=
ace:pre">	</span>* Docs: add lttng-crash(1) man page</div><div><span class=
=3D"" style=3D"white-space:pre">	</span>* Docs: lttng-crash refers to &quot=
;lttng&quot;</div><div><span class=3D"" style=3D"white-space:pre">	</span>*=
 Fix: possible use of uninitialized data in loglevel conversion funcs</div>=
<div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: possible eva=
luation of garbage values in fini_validation_ctx()</div><div><span class=3D=
"" style=3D"white-space:pre">	</span>* Cleanup: Remove stale #ifdef-ed-out =
code from spawn_viewer()</div><div><span class=3D"" style=3D"white-space:pr=
e">	</span>* Fix: Possible call to execvp with NULL argument on allocation =
failure</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix:=
 Possible call to strtoul() with NULL argument</div><div><span class=3D"" s=
tyle=3D"white-space:pre">	</span>* Docs: clarify lttng.1 shm-path section</=
div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: Missing =
return value check in extract_trace_recursive()</div><div><span class=3D"" =
style=3D"white-space:pre">	</span>* Fix: recursive_rmdir: empty all empty s=
ubdir</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Move f=
ile creation/unlink from liblttng-ust-ctl to consumerd</div><div><span clas=
s=3D"" style=3D"white-space:pre">	</span>* lttng-crash: support recursive t=
races</div><div><span class=3D"" style=3D"white-space:pre">	</span>* shm-pa=
th: remove directory hierarchy on destroy</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Implement --shm-path option for UST sessions=
 (per-uid channels)</div><div><span class=3D"" style=3D"white-space:pre">	<=
/span>* Cleanup: Reduce scope of connections in main relayd thread</div><di=
v><span class=3D"" style=3D"white-space:pre">	</span>* Cleanup: Reduce scop=
e of relayd connections in live thread</div><div><span class=3D"" style=3D"=
white-space:pre">	</span>* Docs: connection_find_by_sock() must be called w=
ith rcu_read_lock</div><div><span class=3D"" style=3D"white-space:pre">	</s=
pan>* Rename current release as 2.7.0-pre</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Docs: grammar fix in Makefile</div><div><spa=
n class=3D"" style=3D"white-space:pre">	</span>* Change release name to mas=
ter</div><div><span class=3D"" style=3D"white-space:pre">	</span>* configur=
e: add type availability checking</div><div><span class=3D"" style=3D"white=
-space:pre">	</span>* configure: add check for compiler inline keyword supp=
ort</div><div><span class=3D"" style=3D"white-space:pre">	</span>* configur=
e: missing check for needed header</div><div><span class=3D"" style=3D"whit=
e-space:pre">	</span>* configure: missing check of functions</div><div><spa=
n class=3D"" style=3D"white-space:pre">	</span>* Fix: test: log4j: missing =
static test files for dist and out of tree build</div><div><span class=3D""=
 style=3D"white-space:pre">	</span>* Fix: test: java-jul:missing static tes=
t files for dist and out of tree build</div><div><span class=3D"" style=3D"=
white-space:pre">	</span>* Fix: out-of-tree build: missing xsd file for mi =
test execution</div><div><span class=3D"" style=3D"white-space:pre">	</span=
>* Fix: out-of-tree build: missing xsd file for save-load test execution</d=
iv><div><span class=3D"" style=3D"white-space:pre">	</span>* Cleanup: remov=
e unused end_no_session label in ust_app_flush_session()</div><div><span cl=
ass=3D"" style=3D"white-space:pre">	</span>* Cleanup: Remove unused &quot;e=
nd&quot; label in push_metadata()</div><div><span class=3D"" style=3D"white=
-space:pre">	</span>* Tests: Run health check test_thread_ok as part of roo=
t_regression</div><div><span class=3D"" style=3D"white-space:pre">	</span>*=
 Fix: deadlock between UST registry lock and consumer lock</div><div><span =
class=3D"" style=3D"white-space:pre">	</span>* Fix: uninitialized return va=
lue</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: bui=
ld failure using disable-lttng-ust configure option</div><div><span class=
=3D"" style=3D"white-space:pre">	</span>* Cleanup: Remove unused variable</=
div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: setuid/s=
etgid daemons should not get sensitive env. var./args</div><div><span class=
=3D"" style=3D"white-space:pre">	</span>* Fix: grab more than one packet fo=
r snapshots</div><div><span class=3D"" style=3D"white-space:pre">	</span>* =
Fix: per-uid flush and ust registry locking</div><div><span class=3D"" styl=
e=3D"white-space:pre">	</span>* Docs: Missing optional dependency on lttng-=
ust in README.md</div><div><span class=3D"" style=3D"white-space:pre">	</sp=
an>* Docs: Grammar fixes in the lttng manpage</div><div><span class=3D"" st=
yle=3D"white-space:pre">	</span>* Fix: add missing UST perf counter support=
 check</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: =
tests: integer too large for long type</div><div><span class=3D"" style=3D"=
white-space:pre">	</span>* Fix: undefined operation on last_relay_viewer_se=
ssion_id</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix=
: print format type mismatch</div><div><span class=3D"" style=3D"white-spac=
e:pre">	</span>* Fix: print format type mismatch</div><div><span class=3D""=
 style=3D"white-space:pre">	</span>* Fix: Remove structurally dead code fro=
m relayd</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Cle=
anup: Remove logically dead code</div><div><span class=3D"" style=3D"white-=
space:pre">	</span>* Cleanup: Remove unused label</div><div><span class=3D"=
" style=3D"white-space:pre">	</span>* Fix: Remove unused argument in debug =
statement</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fi=
x: exit threads not only on goto restart</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Fix: poll: show the correct number of fds</d=
iv><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: call lttn=
g_poll_set_max_size before start threads</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Fix: compat poll: add missing empty revents =
checks</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: =
various compat poll/epoll issues</div><div><span class=3D"" style=3D"white-=
space:pre">	</span>* Add debugging output to ht-cleanup thread</div><div><s=
pan class=3D"" style=3D"white-space:pre">	</span>* Fix: mi: snapshot: missi=
ng error handling for session name</div><div><span class=3D"" style=3D"whit=
e-space:pre">	</span>* Fix: ust-app: per-PID app unregister vs tracing stop=
 races</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: =
data pending: allow empty streams</div><div><span class=3D"" style=3D"white=
-space:pre">	</span>* Fix: ust snapshot: cleanup after error</div><div><spa=
n class=3D"" style=3D"white-space:pre">	</span>* Fix: Mismatching return ty=
pe in ust_app_ht_alloc() stub</div><div><span class=3D"" style=3D"white-spa=
ce:pre">	</span>* Cleanup: lock file already taken is error, not warning</d=
iv><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: ust-app n=
ull pointer check needed for main refactoring</div><div><span class=3D"" st=
yle=3D"white-space:pre">	</span>* Cleanup: relayd: centralize thread stoppi=
ng function</div><div><span class=3D"" style=3D"white-space:pre">	</span>* =
Cleanup: Replace all perror() uses by the PERROR macro</div><div><span clas=
s=3D"" style=3D"white-space:pre">	</span>* Refactor relayd main/set_options=
/cleanup</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Ref=
actor consumerd main/cleanup</div><div><span class=3D"" style=3D"white-spac=
e:pre">	</span>* Refactor sessiond main/cleanup/ht-cleanup</div><div><span =
class=3D"" style=3D"white-space:pre">	</span>* Missing error handling: cons=
umer_signal_init should return its error status</div><div><span class=3D"" =
style=3D"white-space:pre">	</span>* Cleanup: consumerd: lines over 80 colum=
ns</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Cleanup: =
consumerd: use PERROR rather than perror</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Cleanup: lttng-consumerd: remove stale TODO =
comment</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Misl=
eading error handling: utils_create_pid_file() should return 0 on success</=
div><div><span class=3D"" style=3D"white-space:pre">	</span>* Missing error=
 handling: consumerd parse_args should return errors to caller</div><div><s=
pan class=3D"" style=3D"white-space:pre">	</span>* Missing error handling: =
ust_app_ht_alloc should return error status</div><div><span class=3D"" styl=
e=3D"white-space:pre">	</span>* Fix: ust app leak on UST buffer creation er=
ror</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: lea=
k on UST buffer registry creation error</div><div><span class=3D"" style=3D=
"white-space:pre">	</span>* Fix: agents ht leaks on destroy session</div><d=
iv><span class=3D"" style=3D"white-space:pre">	</span>* Fix: add missing RC=
U read unlock</div><div><span class=3D"" style=3D"white-space:pre">	</span>=
* Fix: help message for Python agent mentions Java</div><div><span class=3D=
"" style=3D"white-space:pre">	</span>* Fix: don&#39;t destroy the sockets i=
f the snapshot was successful</div><div><span class=3D"" style=3D"white-spa=
ce:pre">	</span>* Fix: Missing RCU read locks in syscall_list_channel()</di=
v><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: Missing RC=
U read lock in kernel_destroy_session()</div><div><span class=3D"" style=3D=
"white-space:pre">	</span>* Fix: channel names are not validated</div><div>=
<span class=3D"" style=3D"white-space:pre">	</span>* Cleanup: Missing white=
space</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: A=
pply consumer URI changes to all domains</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Cleanup: Fix a typo in the MI tests</div><di=
v><span class=3D"" style=3D"white-space:pre">	</span>* Test fix: Don&#39;t =
invoke the system&#39;s lttng client</div><div><span class=3D"" style=3D"wh=
ite-space:pre">	</span>* Tests: Add a test to check disabled events are loa=
ded in the correct state</div><div><span class=3D"" style=3D"white-space:pr=
e">	</span>* Fix: Don&#39;t leave events enabled if they were saved in a di=
sabled state</div><div><span class=3D"" style=3D"white-space:pre">	</span>*=
 Fix: &quot;Any&quot; loglevel&#39;s value is -1 and not 0</div><div><span =
class=3D"" style=3D"white-space:pre">	</span>* Test fix: LTTNG_SESSION_CONF=
IG_XSD_PATH expects an absolute path</div><div><span class=3D"" style=3D"wh=
ite-space:pre">	</span>* Fix: Memory leak on error in alloc_argv_from_user_=
opts()</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Clean=
up: Unchecked close() return value in utils_create_lock_file()</div><div><s=
pan class=3D"" style=3D"white-space:pre">	</span>* Cleanup: No check of the=
 return value of lttng_ht_del()</div><div><span class=3D"" style=3D"white-s=
pace:pre">	</span>* Cleanup: Mixed enums used for return code in send_sessi=
ond_channel()</div><div><span class=3D"" style=3D"white-space:pre">	</span>=
* Cleanup: Cast poll() return value to void</div><div><span class=3D"" styl=
e=3D"white-space:pre">	</span>* Fix: Unreachable error logging in set_optio=
n()</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: OOM=
 leaks in sessiond modprobe.c</div><div><span class=3D"" style=3D"white-spa=
ce:pre">	</span>* Cleanup: sessiond modprobe.c: coding style</div><div><spa=
n class=3D"" style=3D"white-space:pre">	</span>* Cleanup: test_utils_expand=
_path.c prototypes</div><div><span class=3D"" style=3D"white-space:pre">	</=
span>* Fix: test_utils_expand_path.c: out of memory error handling</div><di=
v><span class=3D"" style=3D"white-space:pre">	</span>* Fix: test test_ust_d=
ata.c: check OOM</div><div><span class=3D"" style=3D"white-space:pre">	</sp=
an>* Fix: test libc-wrapper: check malloc OOM</div><div><span class=3D"" st=
yle=3D"white-space:pre">	</span>* Cleanup: test libc-wrapper: main paramete=
rs</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: lttn=
g-ctl: use zmalloc(), missing OOM check</div><div><span class=3D"" style=3D=
"white-space:pre">	</span>* Fix: filter-parser.y: use zmalloc(), missing OO=
M check</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix:=
 utils.c: check str*dup OOM</div><div><span class=3D"" style=3D"white-space=
:pre">	</span>* Cleanup: implement zmalloc as static inline</div><div><span=
 class=3D"" style=3D"white-space:pre">	</span>* Fix: rculfhash: use zmalloc=
()</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: ini.=
c: use zmalloc()</div><div><span class=3D"" style=3D"white-space:pre">	</sp=
an>* Fix: lttng lttng.c: check strdup OOM</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Fix: lttng conf.c: use zmalloc()</div><div><=
span class=3D"" style=3D"white-space:pre">	</span>* Fix: lttng view.c missi=
ng strdup OOM check</div><div><span class=3D"" style=3D"white-space:pre">	<=
/span>* Fix: use zmalloc() in lttng view.c</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Fix: use zmalloc() in lttng list.c</div><div=
><span class=3D"" style=3D"white-space:pre">	</span>* Fix: oom error check,=
 realloc oom leak</div><div><span class=3D"" style=3D"white-space:pre">	</s=
pan>* Fix: use zmalloc in lttng enable_events.c</div><div><span class=3D"" =
style=3D"white-space:pre">	</span>* Fix: missing strdup oom check in lttng =
create.c</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix=
: lttng add_context.c: use zmalloc</div><div><span class=3D"" style=3D"whit=
e-space:pre">	</span>* Cleanup: add missing static to function modprobe_rem=
ove_lttng()</div><div><span class=3D"" style=3D"white-space:pre">	</span>* =
Fix: add missing str*dup oom check in sessiond main.c</div><div><span class=
=3D"" style=3D"white-space:pre">	</span>* Fix: add missing sessiond kernel-=
consumer missing str*dup oom checks</div><div><span class=3D"" style=3D"whi=
te-space:pre">	</span>* Fix: add missing strdup OOM check</div><div><span c=
lass=3D"" style=3D"white-space:pre">	</span>* Fix: add missing synchronizat=
ion point for before app test case</div><div><span class=3D"" style=3D"whit=
e-space:pre">	</span>* Fix: tests: wait output hide Terminate errors</div><=
div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: tests: remove=
 killall, add missing SIGTERM handlers</div><div><span class=3D"" style=3D"=
white-space:pre">	</span>* Fix: high throughput test: reset bw limit on sig=
term</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: te=
sts: add missing wait, document missing synchro</div><div><span class=3D"" =
style=3D"white-space:pre">	</span>* Document test anti-patterns</div><div><=
span class=3D"" style=3D"white-space:pre">	</span>* Fix: test flaky sleep a=
nd wait patterns</div><div><span class=3D"" style=3D"white-space:pre">	</sp=
an>* Fix: tests: don&#39;t use pidof to wait for test apps</div><div><span =
class=3D"" style=3D"white-space:pre">	</span>* Fix: Live tracing does not h=
onor live timer after first tracefile with tracefile rotation</div><div><sp=
an class=3D"" style=3D"white-space:pre">	</span>* Fix: Handle empty daemon =
configuration file lines</div><div><span class=3D"" style=3D"white-space:pr=
e">	</span>* Docs: Add -f/--config option to lttng-sessiond man page</div><=
div><span class=3D"" style=3D"white-space:pre">	</span>* Cleanup: spaghetti=
 function return path</div><div><span class=3D"" style=3D"white-space:pre">=
	</span>* Fix: relayd: unbalanced RCU read-side lock/unlock</div><div><span=
 class=3D"" style=3D"white-space:pre">	</span>* Fix: relayd: unbalanced RCU=
 read lock/unlock</div><div><span class=3D"" style=3D"white-space:pre">	</s=
pan>* Fix: lttng-relayd: unhandled out of memory error</div><div><span clas=
s=3D"" style=3D"white-space:pre">	</span>* Fix: relayd viewer stream: unhan=
dled out of memory error</div><div><span class=3D"" style=3D"white-space:pr=
e">	</span>* Build fix: Apps defining _LGPL_SOURCE must link to urcu-bp</di=
v><div><span class=3D"" style=3D"white-space:pre">	</span>* Define _LGPL_SO=
URCE in test apps&#39; tracepoint provider files</div><div><span class=3D""=
 style=3D"white-space:pre">	</span>* Define _LGPL_SOURCE in test applicatio=
ns</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: Miss=
ing rcu_read_lock in cmd_list_events()</div><div><span class=3D"" style=3D"=
white-space:pre">	</span>* Fix: Missing rcu_read_lock in list_lttng_agent_e=
vents()</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix:=
 Missing rcu_read_lock in cmd_list_channels()</div><div><span class=3D"" st=
yle=3D"white-space:pre">	</span>* Fix: Missing rcu_read_locks in cmd_list_d=
omains()</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix=
: Missing rcu_read_lock in cmd_snapshot_list_outputs()</div><div><span clas=
s=3D"" style=3D"white-space:pre">	</span>* Fix: Missing rcu_read_lock in sa=
ve_domains()</div><div><span class=3D"" style=3D"white-space:pre">	</span>*=
 Fix: Missing rcu_read_lock in ust_app_get_nb_stream()</div><div><span clas=
s=3D"" style=3D"white-space:pre">	</span>* Fix: UST subbuffers silently dro=
pped on moderate trace traffic</div><div><span class=3D"" style=3D"white-sp=
ace:pre">	</span>* Fix: Missing rcu_read_lock in get_session_max_subbuf_siz=
e()</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: cre=
ate/destroy a splice_pipe per stream</div><div><span class=3D"" style=3D"wh=
ite-space:pre">	</span>* Note find_ust_app_context must be called with RCU =
read lock</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fi=
x: empty indexes_ht before destroying it.</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Fix: removed useless key from relay_index</d=
iv><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: Ambiguous=
 agent event filter bytecode ownership</div><div><span class=3D"" style=3D"=
white-space:pre">	</span>* Fix: filter bytecode and string memory leak on e=
rror</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: de=
fine _LGPL_SOURCE in C files</div><div><span class=3D"" style=3D"white-spac=
e:pre">	</span>* Fix: HT must not be destroyed with a rcu_read_lock held</d=
iv><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: agent eve=
nts HT should be destroyed from the cleanup thread</div><div><span class=3D=
"" style=3D"white-space:pre">	</span>* Fix: missing rcu_read_lock in trace_=
ust_destroy_session()</div><div><span class=3D"" style=3D"white-space:pre">=
	</span>* Fix: missing rcu_read_lock when calling trace_ust_find_agent()</d=
iv><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: missing r=
cu_read_lock in cmd_start_trace()</div><div><span class=3D"" style=3D"white=
-space:pre">	</span>* Cleanup: remove &quot;disabled&quot; flag for new rel=
ease cycle</div><div><span class=3D"" style=3D"white-space:pre">	</span>* F=
ix: filter attach vs event enable race</div><div><span class=3D"" style=3D"=
white-space:pre">	</span>* Fix: Mark libxml2 as a mandatory dependency</div=
><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: Warn the us=
er when enabling an event in a new domain</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Fix: Don&#39;t report an error when listing =
a session with no channels</div><div><span class=3D"" style=3D"white-space:=
pre">	</span>* Bypass 0 byte allocation when no domains are enabled</div><d=
iv><span class=3D"" style=3D"white-space:pre">	</span>* Fix: Add missing UR=
CU_TLS access to error_log_time</div><div><span class=3D"" style=3D"white-s=
pace:pre">	</span>* Fix: check userspace perf counter name when looking up =
contexts</div><div><span class=3D"" style=3D"white-space:pre">	</span>* Upd=
ate maintainer section of the man pages</div><div><span class=3D"" style=3D=
"white-space:pre">	</span>* Update maintainer section of README.md</div><di=
v><span class=3D"" style=3D"white-space:pre">	</span>* Fix: add README.md t=
o documentation files</div><div><span class=3D"" style=3D"white-space:pre">=
	</span>* Fix: UST consumer sync all available metadata</div><div><span cla=
ss=3D"" style=3D"white-space:pre">	</span>* Test: remove bogus argument fro=
m prove invocation</div><div><span class=3D"" style=3D"white-space:pre">	</=
span>* Fix: typo in pythong test Makefile</div><div><span class=3D"" style=
=3D"white-space:pre">	</span>* Fix: memory leak in libconfig</div><div><spa=
n class=3D"" style=3D"white-space:pre">	</span>* Add Python agent support</=
div><div><span class=3D"" style=3D"white-space:pre">	</span>* Fix: return E=
INVAL if agent registration fails</div><div><span class=3D"" style=3D"white=
-space:pre">	</span>* Use lttng-modules ABI version ioctl</div><div><span c=
lass=3D"" style=3D"white-space:pre">	</span>* Fix: syscall list ioctl numbe=
r conflict</div><div><span class=3D"" style=3D"white-space:pre">	</span>* U=
pdate master ChangeLog with 2.5.1 release</div><div><br></div><div>As alway=
s, please report any issue you may encounter to <a href=3D"http://bugs.lttn=
g.org">bugs.lttng.org</a></div><div>or on this mailing list.</div><div><br>=
</div><div>Project website: <a href=3D"https://lttng.org">https://lttng.org=
</a></div><div><br></div><div>Download links:</div><div><a href=3D"https://=
lttng.org/files/lttng-tools/lttng-tools-2.7.0-rc1.tar.bz2">https://lttng.or=
g/files/lttng-tools/lttng-tools-2.7.0-rc1.tar.bz2</a></div><div>GPG sig: <a=
 href=3D"https://lttng.org/files/lttng-tools/lttng-tools-2.7.0-rc1.tar.bz2.=
asc">https://lttng.org/files/lttng-tools/lttng-tools-2.7.0-rc1.tar.bz2.asc<=
/a></div><div><br></div><div>Looking forward to your feedback!</div><div><b=
r></div><div>J=C3=A9r=C3=A9mie</div><div><br></div>-- <br><div class=3D"gma=
il_signature">J=C3=A9r=C3=A9mie Galarneau<br>EfficiOS Inc.<br><a href=3D"ht=
tp://www.efficios.com" target=3D"_blank">http://www.efficios.com</a></div>
</div>

--047d7b162bc55f0806051af60f96--


--===============0798874009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0798874009==--
