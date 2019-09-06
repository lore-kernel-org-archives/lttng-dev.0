From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.11.0-rc3 - Lafontaine
Date: Fri, 6 Sep 2019 15:28:03 -0400
Message-ID: <20190906192803.GA2243__41800.4234948725$1567798143$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by lists.lttng.org (Postfix) with ESMTPS id 46Q6zF0Ktjzsbs
 for <lttng-dev@lists.lttng.org>; Fri,  6 Sep 2019 15:28:07 -0400 (EDT)
Received: by mail-qk1-f195.google.com with SMTP id f10so6778057qkg.7
 for <lttng-dev@lists.lttng.org>; Fri, 06 Sep 2019 12:28:07 -0700 (PDT)
Received: from gmail.com (192-222-251-79.qc.cable.ebox.net. [192.222.251.79])
 by smtp.gmail.com with ESMTPSA id
 y207sm3591057qkb.41.2019.09.06.12.28.05
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 12:28:05 -0700 (PDT)
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

Today marks the release of the third release candidates of the LTTng
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

2019-09-06 lttng-tools 2.11.0-rc3 (Great Egg Toss Day)
	* Fix: time constants already defined on macOS
	* Fix: missing include strings.h for bcopy on Solaris 10/11
	* Fix: strndup does not exist on Solaris 10
	* Fix: strnlen is not defined on Solaris 10
	* Fix: redefinition of USEC_PER_SEC macro on macOS
	* Fix: sessiond does not build without lttng-ust support
	* Fix: sessiond: handle NULL control output in session descriptor base pat=
h getter
	* Tests: metadata env scope values
	* Support LTTNG_KERNEL_SESSION_SET_CREATION_DATETIME of lttng-modules
	* Support LTTNG_KERNEL_SESSION_SET_NAME of lttng-modules
	* Metadata: add env fields to ease lttng path hierarchy creation for viewer
	* Fix: lttng_directory_handle_init fails on opening base relayd output
	* Fix: init_session_output_path is valid for peer >=3D 2.11 only
	* Fix: chunk state is not set when relayd does not support trace chunks
	* Fix: check validity of a stream before invoking ust flush command
	* Fix: namespace our gettid wrapper
	* pprint.m4: add missing copyright header
	* Fix: reintroduce lazy kernel modules load, fix empty syscall list
	* Fix: check for lttng modules presence before testing
	* sessiond: use epoll()/poll() instead of select()
	* lttng-ctl: notifications: use epoll()/poll() instead of select()
	* epoll/poll compat: expose interruptible API
	* tests: invoke full_cleanup from script trap handlers, use modprobe -r
	* Cleanup: test: don't stop relayd twice
	* Fix: test: utils.sh: exit from process on full_cleanup
	* Fix: utils.sh: handle SIGPIPE
	* Fix: tests: error handling in high throughput limits test (v2)
	* Improve handling of test SIGTERM/SIGINT (v2)
	* Fix: incorrect conversion specifier used with size and padding
	* Fix: incorrect conversion specifier used with packet size
	* Fix: mismatch of ust_app_get_size_one_more_packet_per_stream prototype
	* Fix: mismatch of ust_app_snapshot_record prototype
	* Fix: lttcomm_consumer_close_trace_chunk_reply undefined without UST
	* Fix: kernel/ust snapshot backward compat for 2.10 relay
	* relayd protocol: reply path for close chunk and create session 2.11
	* Fix: streaming and snapshot backward compat for relayd < 2.11
	* Fix: relayd: create_index_file error handling
	* Fix: don't use newlines in logging message
	* Fix: relayd outputs traces of legacy sessionds to home dir
	* relayd comm: add base path to create session
	* tests: add base-path tests
	* test utils: support URI in lttng_snapshot_add_output
	* Fix: close consumer sockets before waiting for them
	* Fix: consumer: put each chunk on teardown
	* Fix: validate that session, host and basepath are legal
	* Fix: honor base path for network URIs
	* Fix: bindings import segfaults on missing hash_key_u64
	* Cleanup: typo: overriden -> overridden
	* Fix: relay: relay_rotate_session_streams uninitialized return value
	* Fix: test_kernel rotation: expect 60 rather than 64
	* Save registration time for app
	* Fix: tests: update rotation ust number of tests
	* Clean-up: missing word `lock` in comment
	* Use case-scope error labels handling LTTNG_CONSUMER_ROTATE_CHANNEL
	* Use case-scope error labels handling LTTNG_CONSUMER_PUSH_METADATA
	* Use case-scope error labels when handling LTTNG_CONSUMER_GET_CHANNEL
	* Use case-scope error labels handling LTTNG_CONSUMER_ROTATE_CHANNEL
	* Use case-scope error labels handling LTTNG_CONSUMER_DESTROY_CHANNEL
	* Use case-scope error labels handling LTTNG_CONSUMER_STREAMS_SENT
	* Use case-scope error labels when handling LTTNG_CONSUMER_ADD_STREAM
	* Clean-up: set stream's channel pointer to NULL after releasing ref
	* Fix: mark consumer channels as logically deleted during deletion
	* Cleanup: mark utils_get_home_dir as returning a const string
	* Fix: use utils_get_home_dir for anonymous trace chunk path
	* Fix: tests: typo in rotation util
	* Fix: keep ust/kernel session items around for destroy notifier
	* Tests: add a test for the "skip non-empy" rmdir flag
	* Fix: rmdir recursive: skip non-empty directories with flag
	* Fix: uninitialized variable returned by relay_rotate_session_streams
	* Fix: allow quiet rotation at destroy of live session
	* Fix: relayd: live: read index file header
	* Fix: index: use parenthesis around define
	* Fix: test_crash: don't kill first app twice
	* Fix: perform a rotation to a null trace chunk on session destruction
	* relayd: log destination trace chunk of ROTATE_STREAMS command
	* Clean-up: declare dummy pipe payload as a char instead of a string
	* Fix: consumer: assert that stream chunk !=3D NULL (not channel)
	* relayd fix: trace chunk is reclaimed before close command
	* Fix: rotation of a stopped session hangs indifinitely
	* Fix: initialize kernel stream max subbuffer size on creation
	* Fix: use relay_id from ust_session or kernel_session consumer
	* Fix: lttng-ctl: public session.h control API: restore 0 success return v=
alue
	* Fix: remote kernel stream paths contain too much information
	* Fix: destroy command: send credentials with command
	* relayd: open live viewer files from the current stream's trace chunk
	* Fix: don't perform an automatic session rotation in snapshot mode
	* Fix: incorrect time unit used when waiting on destruction handle
	* relayd: implement file and session rotation on top of trace chunks
	* Fix: remove assertions of the existence of a trace chunk
	* Fix: only create trace chunk if the output of a session supports it
	* Fix: use stream's current tracefile count rather than the max
	* relayd: use bool for is_metadata relay_stream attribute
	* relayd: create stream files relative to a session's trace chunk
	* Fix: leak of consumer_output when using an explicit snapshot output
	* Fix: reception buffer of control connection is leaked
	* Fix: ensure a newline is printed before exit on client destroy
	* Send session creation time to relay daemon when supported
	* relayd: remove unnecessary allocation in session path formatting
	* relayd: add remote trace chunk close command
	* Create userspace buffers using ua_sess effective credentials
	* Use lttng_credentials instead of bespoke uid/gid members in ua_sess
	* relayd: add remote trace chunk creation command
	* Add .clang-format
	* Don't allow slashes and dots in overriden trace chunk names
	* relayd: Retrieve a relay_session's trace chunk on creation
	* relayd: Transmit current trace chunk id in create_sesssion command
	* Use a "comm" variant of the LTTNG_OPTIONAL helper in sessiond-comm
	* Remove unused relay daemon commands
	* relayd: create an implicit trace chunk on session creation
	* relayd: create sessiond trace chunk registry on session creation
	* Use directory handle to rename trace chunk directory
	* Docs: add directory handle header documentation
	* Add rmdirat and renameat to run-as commands
	* Print the location of trace chunk produced at session destruction
	* Docs: misleading documentation of compat_epoll_create
	* Remove unused ust_sock member of command_ctx
	* Tests: clarify the tap output of the kernel session rotation test
	* Fix: wait for the completion of implicit session rotations
	* Fix: don't hide EBADF error subbuffer write
	* Tests: don't expect a UST directory after inactive per-PID rotation
	* Tests: remove check for an empty chunk produced on destruction
	* Fix: metadata stream is not marked as quiescent after packet commit
	* Create stream files relative to a stream's current trace chunk
	* Cleanup: remove duplicated code in snapshot record command
	* Fix: run_as_mkdirat returns value of errno
	* Fix: double close of directory fd in runas worker
	* relayd: add the sessiond_trace_chunk_registry interface
	* Move index initialization to ctf-index.h
	* Export utils_stream_file_path outside of common/utils.c
	* Add file creation/unlinking utils to directory handle
	* relayd: send sessiond uuid and session id as part of create session
	* Transmit sessiond uuid to consumerd on launch
	* Add lttng_uuid_copy() util
	* Add lttng_uuid_is_nil() util
	* Add lttng_uuid_is_equal util to lttng_uuid
	* Add a consumer daemon INIT command
	* Generate a UUID on lttng-sessiond launch
	* Remove unneeded creation of the UST domain sub-directory
	* .gitignore: ignore ccls and clangd files
	* Create an initial trace chunk on first start of an ltt_session
	* Allow direct access to the dirfd of a directory handle
	* Create a consumer daemon trace chunk registry on launch
	* Add the trace chunk and trace chunk registry interfaces
	* Add a time_to_iso8601_str() utility
	* Add a method to create a directory handle relative to another one
	* Maintain a channel-per-session_id hash table in the consumers
	* Document lttng_directory_handle_init_from_dirfd
	* Allow lttng_directory_handle to be moved
	* Add a copy method to lttng_directory_handle
	* Remove unused bitfield.h header
	* Use uuid_to_str() when formatting metadata
	* Add an internal uuid formatting utility
	* Tests build fix: undefined MAGIC_VALUE macro
	* Build fix: undeclared variable in poll compat
	* Fix: error when listing sessions with no session

Links
---

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.11.0-rc3.tar.bz2
