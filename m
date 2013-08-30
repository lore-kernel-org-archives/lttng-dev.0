From: David Goulet <dgoulet@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.3.0-rc3
Date: Fri, 30 Aug 2013 15:15:49 -0400
Message-ID: <20130830191549.GA29649__35159.0409795337$1377890222$gmane$org@ev0ke.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.ini-tech.com ([5.9.158.244])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <dgoulet@efficios.com>) id 1VFUAn-00077g-7x
	for lttng-dev@lists.lttng.org; Fri, 30 Aug 2013 15:16:03 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by smtp.ini-tech.com (Postfix) with ESMTP id 22FF8A1DC5
	for <lttng-dev@lists.lttng.org>; Fri, 30 Aug 2013 19:15:36 +0000 (UTC)
Received: from smtp.ini-tech.com ([127.0.0.1])
	by localhost (smtp.ini-tech.com [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ZOKThHFPYphj for <lttng-dev@lists.lttng.org>;
	Fri, 30 Aug 2013 19:15:35 +0000 (UTC)
Received: from ev0ke.net (cable-10.246.173-146.electronicbox.net
	[173.246.10.146])
	by smtp.ini-tech.com (Postfix) with ESMTPSA id BCEFDA1D9C
	for <lttng-dev@lists.lttng.org>; Fri, 30 Aug 2013 19:15:34 +0000 (UTC)
Content-Disposition: inline
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Greetings everyone (including LTTng elves),

The lttng-tools project provides a session daemon (lttng-sessiond) that
acts as a tracing registry, the "lttng" command line for tracing
control, a lttng-ctl library for tracing control and a lttng-relayd for
network streaming.

This is most probably the last release candidate before the 2.3.0 stable
version. (Watch out, lots of fixes! ;)

2013-08-30 lttng-tools 2.3.0-rc3
	* Fix: hashtable: take split_count_order into account
	* Fix: remove wrong doing asserts in sessiond
	* Tests: fix periodical flush tests to stop app
	* Fix: correctly close metadata on sessiond thread shutdown
	* Fix: delete the trace directory used for the test
	* Fix: remove bad check after epoll wait in consumer
	* Fix: missing data pending signess conversion
	* Fix: consumer data pending for empty streams
	* Fix: hash table growth (for small tables) should be limited (v2)
	* Fix: run_as gid/uid test should return result to parent
	* Fix: missing check for metadata data pending
	* Tests: change buffers UID test to PID
	* Tests: fix health tests to use custom socket timeout
	* Fix: remove health test from fast regression
	* Use socket timeout value for tcp timeout if available
	* Fix: set the health delta tcp timeout aware
	* Get the maximum TCP timeout in sessiond
	* Fix: don't report error if UST app dies
	* Fix: support VPATH build for tests
	* Improve comments after review
	* Rename consumer socket fd to fd_ptr
	* Lock consumer data before fd check during destroy
	* Use single callsite for send/recv ops. for consumer in sessiond
	* Use consumer fd reference in consumer socket obj
	* Update bash completion
	* Add --list-commands option to the snapshot command
	* Reorder functions _lttng_cmd_* functions in bash completion
	* Use parse_size_suffix in snapshot
	* Fix: snapshot record error handling
	* Fix: improve error message when UST support is disabled
	* Fix: add missing short filter option in help
	* Fix: typo in configure.ac for version check
	* Fix: remove calibrate syscall option from code
	* Fix: snapshot should fail if no successful snapshot is taken
	* Fix: check UST float field mantissa length
	* Fix: add UST context in the same order the user enabled them
	* Introduce configure --with-lttng-system-rundir
	* Add .dirstamp to gitignore file
	* Fix: snapshot with multiple UIDs
	* Prepare for automake deprecation of missing subdir-objects
	* Fix: typos in --help and manpage
	* Fix: add-context without -c apply to all channels
	* Fix: channels can be _enabled_ after tracing is started, but not created
	* Fix filter parser segmentation fault with bison 3.0
	* Fix: typo in error msg
	* Fix: imprecise error message about root sessiond/tracing group
	* Fix: don't skip chmod if tracing group is not found
	* Tracepoint probes don't need extern C
	* Fix: Snapshot should be taken asap in core handler script
	* Fix: reset out_fd_offset when we rotate the trace file
	* Fix: LTTNG_ERR_NEED_ROOT_SESSIOND error message
	* inet/inet6 sockets: apply timeout
	* Implement timeout for connect ipv4/ipv6
	* Introduce LTTNG_NETWORK_SOCKET_TIMEOUT env. var
	* bash completion: add calls to _lttng_complete_sessions
	* bash completion: Fix copy-paste typo
	* Extras: Remove deprecated consumer commands in bash completion
	* bash completion: Remove underscores in handler function names
	* bash completion: Remove --event for add-context
	* Update gitignore
	* relayd: use version macros from build rather than scanf
	* sessiond: use version major/minor from build for communication with relayd
	* build: export major/minor/patchlevel numbers
	* Fix: Dead code when checking return value from (ust_app|kernel)_snapshot_record
	* Test: enable kernel events after start
	* Fix: kernel ctl error codes are based on errno
	* Fix: format string mismatch
	* test: test_periodical_metadata_flush shrink timer period, kill app
	* Fix: format string type mismatch
	* snapshot howto: update text
	* Add snapshot howto

Using it is testing it!

Project website: http://lttng.org/lttng2.0
Download link:
http://lttng.org/files/lttng-tools/lttng-tools-2.3.0-rc3.tar.bz2 (for
the PGP signature, same file with .asc appended)

Cheers!
David
