From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng Tools 2.3.0-rc1
Date: Wed, 17 Jul 2013 22:32:18 -0400
Message-ID: <20130718023218.GA6551__44182.404902722$1374114790$gmane$org@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1Uze0y-00032Z-Jk
	for lttng-dev@lists.lttng.org; Wed, 17 Jul 2013 22:32:24 -0400
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

The lttng-tools project provides a session daemon (lttng-sessiond)
that acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd
for network streaming.

Since David Goulet is currently on vacation, I'm acting as backup
maintainer for lttng-tools.

Noteworthy feature in LTTng Tools 2.3.x: flight recorder and snapshot
support !

See lttng(1) for details on the "lttng snapshot" set of commands.

LTTng Tools 2.3.x needs to be updated in locked-step with LTTng-UST and
LTTng modules.

Changelog:
2013-07-17 lttng-tools 2.3.0-rc1
	* Fix: add missing snapshot header to dist tarball
	* Documentation: fix thread quit pipe comment
	* Test for presence of bison and flex when building from git
	* Test UST snapshot with large metadata
	* Add test application with large metadata
	* Cleanup: remove redundant assignment
	* Fix: use per-uid buffer registry for UID buffer snapshots
	* cmd.c: fix typos in snapshot commands
	* Test snapshot per-uid post-mortem
	* Remove leftover fprintf
	* Fix deadlock: don't take channel lock in timer
	* Introduce channel timer lock
	* document lttng_ustconsumer_request_metadata locking constraints
	* consumer: remove unused lttng_ustconsumer_push_metadata
	* Document metadata_socket_lock nesting
	* lttng_ustconsumer_recv_metadata does not need all those locks
	* document metadata_switch_timer() deadlock
	* Fix: add missing metadata socket lock
	* document metadata_switch_timer() locking constraints
	* consumer: remove timeout for UST metadata
	* Introduce pipe for UST metadata cache and stream
	* consumer: replace DBG2() instances by DBG()
	* Introduce utils_create_pipe_cloexec_nonblock()
	* ust consumer: data_pending check is endpoint active
	* Fix: kernel consumer: data_pending check if endpoint active
	* consumer: explicitly set endpoint status to active at init
	* document consumer_metadata_cache_flushed use of consumer_data.lock
	* consumer: introduce channel lock
	* Merge branch 'master' of git://git.lttng.org/lttng-tools
	* Fix: update lttng snapshot help output
	* Man: fix part of snapshot documentation
	* Fix: set tracefile size test with PID buffers
	* Fix: Babelstats fail to parse output with no process name or pid
	* Missing NULL pointer init in tap.c
	* Fix: Unchecked asprintf/vasprintf return values
	* Add snapshots test to fast regression
	* Fix: kernel data unit test
	* Fix: snapshot returned valid LTTNG_ERR code
	* Add the number of snapshot taken to the output path
	* Fix: RCU read side lock unbalanced
	* Fix: zeroed snapshot output at init
	* Support del-output with an output name
	* Update man page with snapshot command
	* New UST default buffers is now per UID
	* Bump UST ABI major version for 2.3 release
	* Add snapshot mode to lttng list session
	* Fix: support temporary snapshot max size and name
	* Support snapshot max-size limitation
	* Tests: per-UID UST snapshot
	* Fix: snapshot support for UST and kernel in same session
	* Implement lttng create --snapshot command
	* Add create session snapshot API in lttng-sessiond
	* Add snapshot output init call that uses URIs
	* Fix: consumer err_sock cloexec
	* Callsite: add "ip" context
	* Fix: possible consumer sockets double close on cleanup
	* Automatically load kvm-x86 and kvm-x86-mmu probes.
	* Fix: consumer: use uint64_t for all sessiond_id
	* Fix: add gpl and lgpl files to tarball
	* Fix: don't install libtap system wide
	* Fix: close consumer sockets in sessiond cleanup
	* Fix: set globally visible flag to kernel stream
	* Fix: lttng: memory leak in snapshot record command
	* Fix: kernel-consumer: double-close
	* Fix: consumer: incorrect size zmalloc
	* Fix: don't try to send stream to relayd if not in streaming
	* Fix: relayd refcount updates for stream
	* Fix: don't send error to sessiond on orderly shutdown
	* Fix: bad pathname used when sending kernel stream to relayd
	* Fix: add globally visible flag in stream
	* Fix: destroy metadata stream on setup metadata error path
	* Fix: send kernel stream to relayd only if needed
	* Fix: destroy streams for kernel snapshot sessions as well
	* Fix: close and destroy metadata stream after a kernel snapshot
	* Fix: print errno message on connect() error
	* Fix: possible double-close on stream out_fd
	* Fix: session ID signess to uin64_t in sessiond
	* Tests: fix validation trace path in kernel snapshot
	* Tests: Add UST snapshot local and streaming
	* Add UST snapshot support
	* Fix: consumer_add_relayd_socket() report errors to sessiond
	* Fix: add missing enum lttcomm_return_code entries
	* Fix: UST per-UID channels persist across application teardown
	* Fix: kernel snapshot metadata handling and error paths
	* Fix: coding style and debug statement
	* Fix: put subbuffer back in kernel snapshot error path
	* Fix: overflow in uri_to_str_url
	* Fix: detect the correct version of LTTng-UST
	* Fix: sessiond: use uint64_t for all session ids
	* Tests: add kernel snapshot streaming to root regression
	* Tests: remove debug output from test
	* Tests: Add kernel snapshot streaming
	* Fix: use snapshot consumer output for kernel
	* Fix: periodical flush check trace before stop
	* Fix: consumer: 64-bit index for relayd rather than 32-bit (v2)
	* Fix UST channel/stream output assignation
	* Fix: send per-pid session id in channel creation
	* Fix: consumer double-close on error
	* Update URCU detection to correctly check for a 0.7 version
	* Fix: snapshot path
	* Add utils function to format current time as a string
	* Fix: set hidden attribute to utils_* calls
	* Fix: consumer handling of metadata for relayd
	* Add kernel snapshot support
	* Support flight recorder mode for a session
	* Implement snapshot commands in lttng-sessiond
	* Add snapshot command to lttng UI
	* Initial import of the snapshot ABI/API in lttng-ctl
	* Use the consumer stream API in consumer_del_stream()
	* Add consumer-stream.c/.h in libconsumer
	* Move multiple URLs parsing fct from lttng-ctl to uri.c
	* Add a lttng-ctl header to facilitate code separation

Project website: http://lttng.org
Download link: http://lttng.org/download
(please refer to the README file for installation instructions)

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
