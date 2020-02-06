From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-tools 2.11.1 - Lafontaine
Date: Thu, 6 Feb 2020 16:09:11 -0500
Message-ID: <20200206210911.GB11112@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 by lists.lttng.org (Postfix) with ESMTPS id 48D9zH1ngRz10HW
 for <lttng-dev@lists.lttng.org>; Thu,  6 Feb 2020 16:09:15 -0500 (EST)
Received: by mail-qt1-f195.google.com with SMTP id w8so202236qts.11
 for <lttng-dev@lists.lttng.org>; Thu, 06 Feb 2020 13:09:15 -0800 (PST)
Received: from gmail.com (192-222-181-218.qc.cable.ebox.net. [192.222.181.218])
 by smtp.gmail.com with ESMTPSA id z1sm253025qtq.69.2020.02.06.13.09.12
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 13:09:13 -0800 (PST)
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

Hi all,

The first bug-fix release of LTTng-tools 2.11 - Lafontaine has just
been released. This release addresses a number of issues listed below.

2020-02-05 lttng-tools 2.11.1 (National Chocolate Fondue Day)
	* Fix: sessiond: snapshot errors don't clear session's trace chunk
	* Fix: sessiond: bounded snapshot record fails when no streams exist
	* session-descriptor: fix comment typos in session-descriptor.h
	* Fix: include stdlib.h in compat/string.h
	* Fix: lttng: sanity check of `--probe` description
	* Fix: update context types for Python bindings
	* Fix: lttng: placing probe on symbol starting with `_`
	* Fix: build failure with -fno-common
	* doc: Fix bind address example for lttng-relayd
	* Test: rotate_utils.sh: consider chunk archive with ust/ as empty
	* Fix: consumer: do not flush on transition from NULL chunk
	* Fix: consumer: honor "active" flush flag
	* Fix: sessiond cmd.h: include missing lttng-sessiond.h
	* Fix: sessiond: ust-app: per-pid buffers: Create empty ust/ directory
	* Fix: utils: utils_stream_file_path separator
	* Fix: consumerd: use packet sequence number for rotation position
	* align.h: Implement ALIGN_FLOOR macro
	* Fix: relayd: per-pid live: no new metadata vs close
	* Fix: relayd: use packet sequence number for rotation position
	* Fix: relayd stream.c: LTTNG_OPTIONAL_GET address confusion
	* Fix: optional.h macro missing parentheses and guards
	* dynamic-array: fix documentation of lttng_dynamic_pointer_array_get_pointer
	* Fix: make dist fails on sdt-probe test with autotools v1.16+
	* Fix: tests: metadata presence on relayd is not deterministic
	* Fix: move testpoint after state update
	* doc: fix typo in lttng-enable-event man page
	* Fix: sessiond: RCU read lock imbalance on get trace chunk id error
	* Fix: build: ust -> kernel mix-up in noinst_SCRIPTS
	* Fix: relayd: missing metadata stream causes all traces to be skipped
	* configure.ac: Remove duplicated CMD_DESCR_ROTATE definition
	* Fix: relayd: fully initialize viewer stream before publishing it
	* Fix: relayd: don't send streams if there is no metadata
	* Fix: update apps on untrack only when session is active
	* Fix: consumerd: assert on null trace chunk on session restart
	* Fix: sessiond: don't wait for a rotation from a null chunk to finish
	* Fix: sessiond: duplicated rotation notification sent
	* Fix: relayd: remove assert of non-null stream trace chunk on rotate
	* Docs: verb/noun confusion in comment
	* Fix: sessiond: no rotation performed from null chunk to new chunk
	* Fix: invalid use of destructor in dynamic pointer array
	* Fix: relayd: check for a trace chunk before writing a packet
	* Fix: relayd: viewer session trace chunk not released on detach
	* Require automake >= 1.12
	* Fix: relayd: session trace chunk is copied too late
	* Fix: relayd: disallow 0-length session names for 2.4+ peers
	* Fix: sessiond: ust: deadlock with per-pid buffers
	* relayd: close viewer stream trace chunk earlier on release
	* Fix: relayd: put chunk reference when closing stream
	* Fix: relayd: tracefile rotation: viewer opening missing index file
	* Tests: fix shellcheck warning
	* Tests: base path: lttng load for session configuration
	* Cleanup: remove unused internal lttng_session_descriptor_get_base_path
	* Refactor: Move set session path to own function
	* Fix: move set base_path of session to URI configuration
	* Fix: lttng: initialize sessions pointer to NULL
	* Fix: check for dtrace and sdt.h before enabling SDT uprobe tests
	* Fix: consumerd: crash occurs when taking snapshot of ust channel
	* Fix: trace-chunk: log the cause of file open failures
	* Fix: relayd: live: crash when creating viewer streams
	* Fix: relayd: live: crash on attach to a session without trace chunk
	* Fix: relayd: live: some listed sessions are not attacheable
	* Fix: relayd: don't put un-acquired trace chunk reference
	* Fix: relayd: don't put un-acquired viewer trace chunk reference
	* Fix: consumerd: NULL pointer dereference during metadata sync
	* consumerd: clean-up: stream attribute accessed without locking stream
	* Fix: check for lttng-ust >= 2.11 at configure
	* Typo: occured -> occurred
	* Fix typo 'Attemp' -> 'Attempt'
	* Fix: sessiond: use system LTTng-UST headers when available
	* doc/man: use specific revision date for each manual page
	* lttng-rotate.1.txt: update voice and document the `archives` subdir.

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.1.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.1.tar.bz2.asc
