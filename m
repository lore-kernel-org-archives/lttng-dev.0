From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
        <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-tools 2.11.3 - Lafontaine
Date: Thu, 16 Apr 2020 17:58:59 -0400
Message-ID: <20200416215859.GA61343@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-trace-users-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

The third bug-fix release of LTTng-tools 2.11 - Lafontaine has just
been released. This release addresses a number of issues listed below.

2020-04-16 lttng-tools 2.11.3 (National Eggs Benedict Day)
	* Fix: lttng-destroy: missing newline on session destruction message
	* Fix: common: add `void` parameter to log_add_time declaration
	* Fix: lttng-list: don't warn when the kernel domain has no channels
	* Fix: sessiond: occasional badfd error on repeated SIGTERM
	* Fix: lttng: incorrect domain list printed when no domain is provided
	* directory-handle: print `errno` reason on `unlinkat()` error
	* Fix: lttng-ctl: _handle can be NULL
	* Silence `POSIX Yacc` warnings
	* Fix: relayd: use of relay_session ref count before initialization
	* Fix: lttng: uninitialized pointer free'd when no sessiond is present

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.3.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.3.tar.bz2.asc
