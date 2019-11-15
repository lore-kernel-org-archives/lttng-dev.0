From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 2.0.0-rc4
Date: Fri, 15 Nov 2019 18:03:00 -0500
Message-ID: <20191115230300.GA44302__36299.0083800227$1573859009$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com
 [209.85.222.173])
 by lists.lttng.org (Postfix) with ESMTPS id 47FDQx17sSz1Rkr
 for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2019 18:03:04 -0500 (EST)
Received: by mail-qk1-f173.google.com with SMTP id 205so9487873qkk.1
 for <lttng-dev@lists.lttng.org>; Fri, 15 Nov 2019 15:03:04 -0800 (PST)
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
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

Hi everyone!

Two weeks after having released [1] Babeltrace 2's second release
candidate, today we're releasing Babeltrace 2.0.0-rc4.

NOTE: Due to human error, Babeltrace 2.0.0-rc3 is a malformed release.
Babeltrace 2.0.0-rc3 and Babeltrace 2.0.0-rc4 have the same changes
since Babeltrace 2.0.0-rc2.

What's new since Babeltrace 2.0.0-rc2?
======================================
Improvements
~~~~~~~~~~~~
General:
    * Introduce the `BABELTRACE_EXEC_ON_ABORT` environment variable.

      `BABELTRACE_EXEC_ON_ABORT` can contain a shell command line to
      execute when any part of the Babeltrace project aborts (for
      example, when an internal assertion fails) before the process
      exits.

      See `8403432f`.

    * Add precondition assertions to verify that the current thread has
      no error when you call a libbabeltrace2 function (except reference
      count functions).

      See `7c7324d3`.

    * Add postcondition assertions to verify that the user functions
      which libbabeltrace2 calls return an error status code when the
      current thread has an error.

      See `d6f6a5aa`.

    * Emit dedicated bright terminal color codes if supported by the
      terminal emulator.

      This makes the `babeltrace2` [2] CLI tool and some project plugins
      emit correct bright color codes for the kitty terminal
      emulator [3], for example.

      You can override this behaviour with the new
      `BABELTRACE_TERM_COLOR_BRIGHT_MEANS_BOLD` environment variable.

      See `4253e1eb`.

    * In libbabeltrace2's API: make the
      `bt_value_map_foreach_entry_func` and
      `bt_value_map_foreach_entry_const_func` function types return a
      status code instead of `bt_bool`.

      This makes it possible for the user function to append a cause to
      the current thread's error and return an error status code. When
      the user function returns a general error status code,
      `bt_value_map_foreach_entry()` returns
      `BT_VALUE_MAP_FOREACH_ENTRY_STATUS_USER_ERROR` (and an equivalent
      code for `bt_value_map_foreach_entry_const()`).

      The new way to interrupt the outer loop from the user function is
      to return `BT_VALUE_MAP_FOREACH_ENTRY_FUNC_STATUS_INTERRUPT`.

      See `0589c646`.

Command-line interface:
    Exit with status 2 when the process receives the `SIGINT` signal.

    This makes it possible to distinguish a successful execution
    (status 0) from an execution that ends because of an error
    (status 1).

    See `851802b1`.

`source.ctf.fs` component class:
    * Check the version of LTTng [4] index files to avoid reading files
      of future backwards-incompatible versions.

      See `2068d50b`.

    * If the same packets exist in different data stream files of a
      given CTF trace, read each of them only once.

      This feature makes it possible to open overlapping LTTng
      snapshots [5] without emitting the event and packet messages twice
      or more like Babeltrace 1 does.

      For example:

          $ babeltrace2 snapshot1 snapshot2 snapshot3

          $ babeltrace2 snapshot-directory

      See `148f02cb`.

`source.ctf.lttng-live` component class:
    Return
    `BT_COMPONENT_CLASS_MESSAGE_ITERATOR_NEXT_METHOD_STATUS_AGAIN` when
    a signal interrupts an I/O system call _and_ the graph's interrupter
    is set; restart the system call otherwise.

    Because the `babeltrace2` CLI tool sets the graph's interrupter when
    it receives the `SIGINT` signal, this change makes it possible to
    exit with status 2 (instead of status 1, an error) when it receives
    the `SIGINT` signal and a `source.ctf.lttng-live` message iterator
    is currently being executed.

    See `8dd99d00`.

`filter.utils.muxer` component class:
    Append causes to the current thread's error when encountering some
    error conditions.

    See `f331468c`.

Notable bug fixes
~~~~~~~~~~~~~~~~~
Simple sink component class:
    Append error causes only when returning an error status code.

    See `eb657c7b`.

Upcoming
========
We are still hard at work putting the finishing touches on our way to
the final 2.0.0 release.

We invite you to try this release candidate and report any problems you
may encounter to the `lttng-dev@lists.lttng.org` [6] mailing list or
through the Babeltrace bug tracker [7].

Documentation
-------------
We are currently documenting the entire Babeltrace 2 C API to make the
development of new component classes as easy as possible.

We'll also work on the Python bindings documentation.

The documentation of the API will be made available on the official
Babeltrace website [8].

Other tasks
-----------
* Improve test coverage.
* Improve resilience to corrupted/malformed CTF traces.
* Minor internal cleanups and bug fixes.

Important links
===============
Babeltrace 2.0.0-rc4 tarball:
    https://www.efficios.com/files/babeltrace/babeltrace-2.0.0-rc4.tar.bz2

Babeltrace website:
    https://diamon.org/babeltrace

Mailing list (for support and development):
    `lttng-dev@lists.lttng.org`

IRC channel:
    `#lttng` on `irc.oftc.net`

Git repository:
    https://bugs.lttng.org/projects/babeltrace

GitHub project:
    https://github.com/efficios/babeltrace

Continuous integration:
    https://ci.lttng.org/view/Babeltrace/

Code review:
    https://review.lttng.org/q/project:babeltrace

References
==========
[1]: https://diamon.org/babeltrace/docs/release-notes/babeltrace-2.0.0-rc2-release-notes.html
[2]: https://diamon.org/babeltrace/docs/v2.0/man1/babeltrace2.1/
[3]: https://sw.kovidgoyal.net/kitty/
[4]: https://lttng.org/
[5]: https://lttng.org/docs/#doc-taking-a-snapshot
[6]: https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
[7]: https://bugs.lttng.org/projects/babeltrace
[8]: https://diamon.org/babeltrace/
