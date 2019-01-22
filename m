From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.10.6 - KeKriek
Date: Tue, 22 Jan 2019 15:42:53 -0500
Message-ID: <20190122204252.GA1927__32627.9479939089$1548189795$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 by lists.lttng.org (Postfix) with ESMTPS id 43kgNL0q2FznhP
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:42:57 -0500 (EST)
Received: by mail-qk1-f176.google.com with SMTP id m17so251287qki.5
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 12:42:57 -0800 (PST)
Received: from gmail.com (192-222-157-41.qc.cable.ebox.net. [192.222.157.41])
 by smtp.gmail.com with ESMTPSA id
 b134sm53038559qkg.78.2019.01.22.12.42.55
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Jan 2019 12:42:55 -0800 (PST)
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

The sixth bug-fix release of LTTng-Tools 2.10 - KeKriek has just been
released. This release addresses a number of issues listed below.

2019-01-22 lttng-tools 2.10.6 (Blonde Brownie Day)
        * Fix: worker structure is leaked in run_as process
        * Fix: only free trace_path when it is dynamically allocated
        * Fix: leak of filter bytecode and expression on agent event re-enable
        * Test fix: python logging test spams its output
        * Fix: leak of rundir config string
        * Fix: do not repurpose iterator while it is being used
        * Fix: run_command_wait() handle partial write
        * Fix: tests: test_crash should start sessions
        * Add *.exe to gitignore for Cygwin
        * Fix: warning 'fd' may be used uninitialized
        * Fix: max_t/min_t macros are missing cast on input
        * Fix: Connect timeout arithmetic in inet/inet6 (v4)
        * Fix: create_channel_per_pid: remove channel on error
        * Fix: channel errors on local stress-tests
        * Fix: channel_ust_create: remove channel on agent error
        * Always choose large event header for UST channels
        * Remove unnecessary check of output parameter
        * Fix: perform local data pending before checking data pending with relayd
        * Fix: double put on error path
        * Fix: holding the stream lock does not equate to having data pending
        * Fix: skip uid registry when metadata key is 0
        * Docs: document the meaning of a ust app channel key set to 0
        * Fix: acquire stream lock during kernel metadata snapshot
        * Fix: skip closed session on viewer listing
        * Fix: use LTTNG_VIEWER_ATTACH_UNK to report a closed session
        * Doc: withinin -> within
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
        * Fix: incorrect error message on regenerate missing argument
        * Fix: incorrect error message on metadata missing argument
        * Fix: snapshot command mishandles missing arguments
        * Fix: potential use of NULL path in stat() use
        * Fix: passing null to closedir() on error
        * Fix: unchecked access to pids array
        * Fix: returned pids may be uninitialized
        * Fix: lttng-save command producing wrong XML fields
        * Fix: memory is not zeroed on first set_capacity
        * Fix: dynamic buffer mishandles setting capacity to 0
        * Fix: client_list_element leak on failure to evaluate a condition
        * Fix: possible NULL dereference in uri_parse_str_urls()
        * Fix: clean-up sessiond condig structure on initialization error
        * Fix: unchecked return value in sessiond path configuration
        * Set consumer's verbosity to the max level on --verbose-consumer
        * Tests: added test_autoload to noinst_SCRIPTS

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.10.6.tar.bz2

GPG sig:
https://lttng.org/files/lttng-tools/lttng-tools-2.10.6.tar.bz2.asc
