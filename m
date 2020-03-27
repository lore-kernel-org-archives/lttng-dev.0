From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau
        <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng 2.12-rc3 - (Ta) Meilleure
Date: Fri, 27 Mar 2020 17:19:36 -0400
Message-ID: <20200327211936.GA278029@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-trace-users-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-trace-users-owner@vger.kernel.org
To: lttng-dev@lists.lttng.org
Cc: diamon-discuss@lists.linuxfoundation.org, linux-trace-users@vger.kernel.org
List-Id: lttng-dev@lists.lttng.org

Hi everyone,

Today marks the release of the third LTTng 2.12 - (Ta) Meilleure
release candidate.

The second release candidate was skipped as the configure script
was garbled by my release script. I unfortunately noticed this
after having pushed the tag... Mea culpa!

Have a look at the first release candidate's release notes for an
overview of the features introduced in LTTng 2.12.

https://github.com/lttng/lttng-tools/releases/tag/v2.12.0-rc1

This release is named after "Ta Meilleure", a Northeast IPA beer
brewed by Lagabière. Translating to "Your best one", this beer gives
out strong aromas of passion fruit, lemon, and peaches. Tastewise,
expect a lot of fruit, a creamy texture, and a smooth lingering hop
bitterness.

Of note, the tracker API was changed and the lttng-track(1) and
lttng-untrack(1) man pages were updated to clarify the usage of the
new uid/gid tracking feature.

We have also integrated a number of bug fixes which made their way to
the master branch as we continue to work on the LTTng 2.13 release.

Be safe!

2020-03-27 lttng-tools 2.12.0-rc3 (International Stay at Home Month)
	* Fix: remove duplicated AC_INIT directive

2020-03-27 lttng-tools 2.12.0-rc2 (International Stay at Home Month)
	* Fix: sessiond: NULL pointer dereference after NULL check
	* Fix: sessiond: missing goto in error handler
	* Fix: sessiond: user/group name can be leaked on malformed command
	* configure: add -Wmissing-declarations, -Wmissing-prototypes, and more
	* Fix: sessiond: make the --without-lttng-ust version of launch_application_notification_thread static
	* Fix: tests: include callsites.h from callsites.c
	* Fix: relayd: cast idigit argument to unsigned char
	* Fix: tests: make some functions static
	* Fix: tests: add `void` parameter to functions that take no parameters
	* Fix: common: make lttng_trace_chunk_remove_subdirectory_recursive static
	* Fix: common: add `void` parameter to log_add_time declaration
	* CONTRIBUTING.md: harmonize list style with the rest of the docs
	* CONTRIBUTING.md: clarify the guidelines for commit messages
	* Fix: lttng-list: don't warn when the kernel domain has no channels
	* Refactor: lttng-ctl: follow terminology of the tracker documentation
	* lttng: list: replace domain headers with the official names
	* lttng: list: print `per-user` and `per-process` buffer types
	* Docs: overhaul of lttng-track(1) and lttng-untrack(1)
	* Fix: MI: bump MI schema version to 4.0 in mi-lttng.c
	* Fix: sessiond: occasional badfd error on repeated SIGTERM
	* Fix: lttng: incorrect domain list printed when no domain is provided
	* Fix all -Wdiscarded-qualifiers warning instances
	* Remove part of last name to fit in a 80 character line
	* Fix: Tests: trace path wildcards not expanded
	* Fix: Tests: `gen-ust-events` doesn't error out on invalid option
	* Fix: Tests: utils.sh: merge `validate_{directory,folder_is}_empty` functions
	* Fix: Tests: undefined `NR_USEC_WAIT` bash variable
	* directory-handle: print `errno` reason on `unlinkat()` error
	* Fix: lttng-ctl: _handle can be NULL
	* Fix: sessiond: domain subdirectory not deleted on empty clear
	* Ignore -Wincomplete-setjmp-declaration warnings
	* tests: put -no-pie in LDFLAGS instead of CFLAGS
	* Silence `POSIX Yacc` warnings
	* Fix -Wmissing-declarations warnings in filter-parser.y
	* Include cmd-2-2.h in cmd-2-1.h
	* Make create_file function static in gen-ust-tracef.c
	* Make remove_file_from_hierarchy function static in test_directory_handle.c
	* Make fd_count function static in test_fd_tracker.c
	* Add declarations for exported functions in health_exit.c
	* Add declarations for exported functions in health_fail.c
	* Make functions in live_test.c static
	* Add declarations for exported functions in consumer_testpoints.c
	* Make parse_arguments static in base_client.c
	* Fix all -Wmissing-declarations warning instances
	* Fix: fd-tracker: mark symbols as hidden
	* Fix: liblttng-ctl: hide new tracker config symbols
	* configure: add --enable-Werror
	* configure: use AX_APPEND_COMPILE_FLAGS to detect supported warning flags
	* Tests: notification.c: remove extra space
	* Tests: remove unused libhealthexit code
	* Fix: remove broken health monitoring test `test_thread_exit`
	* Fix: directory-handle: use of free'd handle on fstat() error
	* Fix: relayd: use of relay_session ref count before initialization
	* Fix: relayd: unchecked return value when opening relay socket
	* tests: append to AM_CFLAGS instead of overriding it
	* Tests: gen-ust-nevents: use options instead of arguments
	* Tests: Cleanup: test_exclusion: more detailed output
	* Fix: Tests: `test_exclusion` passing for the wrong reason
	* Fix: trace-chunk: useless assignment to 'ret'
	* Fix: lttng: track-untrack: error assigned to wrong variable
	* Fix: relayd: live: unchecked poll set creation return value
	* Fix: relayd: live: unchecked return value when opening relay socket
	* Fix: relayd: unchecked poll set creation return value
	* Fix: lttng: uninitialized pointer free'd when no sessiond is present
	* Fix: tracker: inclusion of internal header in public header
	* Tests: Fix: `wait_on_file()` returns too early
	* Fix: Tests: utils.sh: fix unbound variable
	* Tests: Fix typo: registerd -> registered
	* Tests: Cleanup: remove unused bash variable
	* Typo: 'toogle' -> 'toggle'
	* Fix: lttng-sessiond: control reaches end of non-void function warning
	* Fix: possible null dereference
	* Fix: string might be uninitialized
	* Fix: force the use of our _FORTIFY_SOURCE definition

Links
---

Project website: https://lttng.org

Download links:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.0-rc3.tar.bz2
https://lttng.org/files/lttng-ust/lttng-ust-2.12.0-rc3.tar.bz2
https://lttng.org/files/lttng-modules/lttng-modules-2.12.0-rc3.tar.bz2

GPG signatures:
https://lttng.org/files/lttng-tools/lttng-tools-2.12.0-rc3.tar.bz2.asc
https://lttng.org/files/lttng-ust/lttng-ust-2.12.0-rc3.tar.bz2.asc
https://lttng.org/files/lttng-modules/lttng-modules-2.12.0-rc3.tar.bz2.asc
