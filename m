From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: [RELEASE] LTTng-modules and LTTng-UST 2.10.0 (KeKriek)
Date: Tue, 1 Aug 2017 20:19:10 +0000 (UTC)
Message-ID: <979220567.3317.1501618750014.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, linux-kernel <linux-kernel@vger.kernel.org>
Cc: lwn <lwn@lwn.net>
List-Id: lttng-dev@lists.lttng.org

Hi,

Today, we release the 2.10 stable versions of LTTng kernel and user-space
tracers. This release is named "KeKriek", which is a sour mashed
golden wheat ale brewed by the Dunham microbrewery in Quebec.

The new features included are:

- A new "blocking" mode for LTTng-UST (it has been requested for a while).
  It blocks application tracing when buffers are full (for "discard mode
  tracing") rather than discarding events, until a user-specified timeout
  is reached (or indefinitely). It affects only applications launched with
  the LTTNG_UST_ALLOW_BLOCKING environment variable set, and channels
  configured with the "--blocking-timeout" option. See lttng-ust(3)
  for usage information.

  This feature is useful if you intend to trace huge amounts of data
  from applications (e.g. all memory allocation/free, or detailed
  execution of a simulator) in use-cases where it is acceptable to
  block the traced application.

- Add support for multiple star-globbing patterns in LTTng-UST and LTTng-modules.
  Now events can be enabled with a pattern containing many wildcards, e.g.
  'sche*_sw*t*h'. Those can also be used when comparing strings with filter,
  e.g.:
  lttng enable-event -u myevent --filter 'myfield == "abc*d*e*fg"'

- LTTng modules adds support for kernels 4.10, 4.11, 4.12 (which has been
  backported to 2.8 and 2.9 stable branches).

- LTTng modules adds the task CPU in threads state dump, improving precision
  of the scheduler model.

- LTTng modules now collects extend socketpair system call tracing data.

For more information on new features introduced in this version,
see: http://lttng.org/docs/v2.10/#doc-whats-new

The 2.10.0 release marks the end of life for the old stable-2.8 branches.
There will be one last stable-2.8 release for both lttng-modules and lttng-ust,
after which they will become unsupported.

Project website: http://lttng.org
Documentation: http://lttng.org/docs
Download link: http://lttng.org/download

Changelog:

2017-08-01 (World Wide Web Day) LTTng modules 2.10.0
        * Fix: Sleeping function called from invalid context
        * Fix: sched for v4.11.5-rt1
        * Fix: handle missing ftrace header on v4.12

2017-08-01 (World Wide Web Day) lttng-ust 2.10.0
        * lttng-ust(3): reword and fix style of `LTTNG_UST_ALLOW_BLOCKING` variable
        * lttng-ust(3): specify "If set" instead of "if set to 1" for some variables
        * Fix: doc/man: use a single XSL file and match local names
        * Fix: Expand the shmobj size for the sequence number

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
