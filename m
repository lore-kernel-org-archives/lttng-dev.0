From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: =?iso-8859-1?q?=5BRELEASE=5D_LTTng-Tools_2=2E9=2E11_?=
 =?iso-8859-1?q?-_Joann=E8s?=
Date: Tue, 22 Jan 2019 15:59:27 -0500
Message-ID: <20190122205926.GA3124__25108.970601444$1548190788$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by lists.lttng.org (Postfix) with ESMTPS id 43kglR6h0XznkM
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 15:59:31 -0500 (EST)
Received: by mail-qt1-f169.google.com with SMTP id n32so29245656qte.11
 for <lttng-dev@lists.lttng.org>; Tue, 22 Jan 2019 12:59:31 -0800 (PST)
Received: from gmail.com (192-222-157-41.qc.cable.ebox.net. [192.222.157.41])
 by smtp.gmail.com with ESMTPSA id
 g189sm49338785qkb.3.2019.01.22.12.59.28
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 22 Jan 2019 12:59:29 -0800 (PST)
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

The eleventh bug-fix release of LTTng-Tools 2.9 - Joann=E8s has just been
released. This release addresses a number of issues listed below.

2019-01-22 lttng-tools 2.9.11 (Blonde Brownie Day)
        * Fix: worker structure is leaked in run_as process
        * Fix: leak of filter bytecode and expression on agent event re-ena=
ble
        * Fix: only free trace_path when it is dynamically allocated
        * Fix: tests: test_crash should start sessions
        * Add *.exe to gitignore for Cygwin
        * Fix: warning 'fd' may be used uninitialized
        * Fix: max_t/min_t macros are missing cast on input
        * Fix: Connect timeout arithmetic in inet/inet6 (v4)
        * Fix: channel_ust_create: remove channel on agent error
        * Always choose large event header for UST channels
        * Fix: perform local data pending before checking data pending with=
 relayd
        * Fix: double put on error path
        * Fix: holding the stream lock does not equate to having data pendi=
ng
        * Fix: skip uid registry when metadata key is 0
        * Docs: document the meaning of a ust app channel key set to 0
        * Fix: acquire stream lock during kernel metadata snapshot
        * Fix: skip closed session on viewer listing
        * Fix: use LTTNG_VIEWER_ATTACH_UNK to report a closed session
        * Fix: expand load path to an absolute path before daemonizing
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
        * Fix: passing null to closedir() on error
        * Fix: unchecked access to pids array
        * Fix: returned pids may be uninitialized
        * Fix: lttng-save command producing wrong XML fields
        * Fix: possible NULL dereference in uri_parse_str_urls()
        * Set consumer's verbosity to the max level on --verbose-consumer
        * Tests: added test_autoload to noinst_SCRIPTS

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.9.11.tar.bz2

GPG sig:
https://lttng.org/files/lttng-tools/lttng-tools-2.9.11.tar.bz2.asc
