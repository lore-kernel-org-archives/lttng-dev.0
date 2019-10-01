From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.11.0-rc4 - Lafontaine
Date: Tue, 1 Oct 2019 18:04:38 -0400
Message-ID: <20191001220438.GA52120__34498.6433557764$1569967499$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f193.google.com (mail-qt1-f193.google.com
 [209.85.160.193])
 by lists.lttng.org (Postfix) with ESMTPS id 46jYGM3n8wzq4K
 for <lttng-dev@lists.lttng.org>; Tue,  1 Oct 2019 18:04:43 -0400 (EDT)
Received: by mail-qt1-f193.google.com with SMTP id u40so23697753qth.11
 for <lttng-dev@lists.lttng.org>; Tue, 01 Oct 2019 15:04:43 -0700 (PDT)
Received: from gmail.com (192-222-181-218.qc.cable.ebox.net. [192.222.181.218])
 by smtp.gmail.com with ESMTPSA id r7sm8601174qkf.124.2019.10.01.15.04.39
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 15:04:40 -0700 (PDT)
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

Hi everyone!

Today marks the release of the fourth release candidates of the LTTng
2.11 "Lafontaine" release cycle.

This release is named after a modern Saison beer from Montr=E9al's
Oshlag microbrewery. It is a refreshing, zesty, rice beer with hints
of fruit and spices. Some even say it makes for a great Somaek when
mixed with Chamisul Soju, not that we've tried!

Lafontaine is also a tongue-in-cheek reference to a water leak that
affected EfficiOS's offices during the development of this release.

A summary of the new features introduced in LTTng 2.11 is available
here:
https://github.com/lttng/lttng-tools/releases/tag/v2.11.0-rc1

2019-10-01 lttng-tools 2.11.0-rc4 (International Coffee Day)
	* Fix: Tests: Segfault in `test_utils_expand_path()`
	* Fix: lttng-ctl: missing __cplusplus closing brace
	* Fix: trace chunk reported unknown before close command execution
	* Fix: sessiond: leak of application socket on chmod failure
	* sessiond: clean-up: silence warning that agent event is leaked
	* Fix: tests: leak of prefix on error to register lttng namespace
	* Fix: use newly created event filter for condition check
	* Fix: lttng-crash: detect truncated files
	* Fix: sessiond: fs.protected_regular sysctl breaks app registration
	* relayd: clean-up: mix-up between LTTNG_PATH_MAX and LTTNG_NAME_MAX
	* Fix: destroy command: put consumer output after destroy notifier
	* Refactor: remove logically dead code
	* Fix: Null check before destroying health_sessiond
	* Fix: Move initialization of queue_pipe_fd after null check of handle
	* Fix: release reference to new chunk on copy error
	* Fix: Close socket handle on error
	* Fix: lttng: out-of-bound copy of arguments in 'view' command handler
	* Revert "lttng: fix: out-of-bounds copy of original 'view' command argume=
nts"
	* Fix: relayd: session destruction does not complete in live mode
	* Add a copy method to the trace chunk interface
	* relayd: move viewer stream chunk reference release to destroy
	* relayd: move relay_session locking outside of make_viewer_streams
	* Fix: release reference to trace chunk on index file creation failure
	* trace-chunk: clean-up: mark close command properties as static const
	* trace-chunk: clean-up: misleading label name
	* ust-consumer: fix: metadata stream lock taken before destroy
	* sessiond: fix: memory leak of section name in elf parser
	* kconsumer: clean-up: initialize ctf_index before populating it
	* sessiond: fix: strncpy called with source length
	* sessiond: fix: possible unaligned access in packed structure
	* relayd: clean-up: strncpy uses the length of the source as length
	* lttng: fix: out-of-bounds copy of original 'view' command arguments
	* lttng: clean-up: silence bogus string truncation warning
	* sessiond: clean-up: mixed log levels enums used to look-up event
	* sessiond: fix: possible unaligned access in packed structure
	* sessiond: fix: possible unaligned access in packed structure
	* sessiond: fix: possible unaligned access in packed structure
	* sessiond: fix: possible unaligned access in packed structure
	* lttng-ctl: fix: possible unaligned access in packed structure
	* lttng-ctl rotate: fix: possible unaligned access in packed structure
	* runas: fix: possible unaligned access in packed structure
	* consumer: fix: possible unaligned access in packed structure
	* inet: fix: possible unaligned access in packed structure (inet/inet6)
	* consumer: fix: unaligned accesses to index fields
	* lttng-sessiond: clean-up: set free'd pointer to NULL
	* lttng: fix: potential 0-length allocation in pid list parsing
	* Tests: fix: uninitialized session_id used on list_sessions failure
	* Tests: fix: uninitialized values passed to close() on error
	* Clean-up: assert that get_count_order() returns a positive value
	* Clean-up: suppress bogus scan-build warning
	* Tests: fix: leak caused by misuse of realloc in multi-lib-test
	* sessiond: clean-up: init ret value of _session_set_trace_chunk_no_lock_c=
heck
	* sessiond: fix: print_escaped_ctf_string mishandles empty string
	* lttng-ctl: fix: lttng_data_pending confuses communication status
	* relayd: fix: rotate_truncate_stream() assumes non-null next chunk
	* Fix: dereference of NULL pointer in stream_write()
	* Fix: report bytecode_push failure when pushing symbol
	* Fix: only invoke PERROR() on failure to close sessiond_socket
	* Clean-up: lttng: check status returned when checking rotation state
	* Fix: communication error unreported in relay_rotate_session_streams
	* Fix: unreported error in relay_close_trace_chunk
	* Clean-up: remove dead assignment from ht cleanup thread launcher
	* Clean-up: remove dead assignment from thread_rotation
	* Clean-up: remove dead assignment in setup_channel_trace_path
	* Clean-up: remove dead assignments while setting session trace chunk
	* Fix: report path truncation on addition of local uri to consumer
	* Clean-up: lttng: silence warning in regenerate command handler
	* Clean-up: lttng: silence warning in metadata command handler
	* Clean-up: remove NULL check on sesison_create mandatory arguments
	* Fix: session may be NULL in relay_create_session error path
	* Clean-up: silence erroneous leak warning
	* Fix: leak of lttng_elf_shdr in lttng-elf.c
	* Fix: leaked chunk reference in lttng_consumer_create_trace_chunk
	* Clean-up: remove unused stream file creation and unlink functions
	* Fix: use the trace chunk to truncate streams on late rotation
	* Clean-up: format using remaining buffer len rather than total len
	* Fix sessiond: report flush errors on session stop
	* Fix: leak of trace_path on error in ust_app_snapshot_record
	* Fix: uninitialized directory handle finalized on error path
	* Fix: release reference to created chunk if it can't be published
	* Fix: destroy chunk registry on element creation failure
	* Fix: return NULL on trace chunk registry failure
	* Fix: forward fatal error in evaluate_condition_for_client()
	* Fix relayd: check for NULL in session_put
	* Fix typo in regenerate statedump test util

Links
---

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.0-rc4.tar.bz2
