From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] LTTng-Tools 2.10.8 - KeKriek
Date: Tue, 1 Oct 2019 18:09:55 -0400
Message-ID: <20191001220955.GB52120__35869.4455631607$1569967816$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f193.google.com (mail-qk1-f193.google.com
 [209.85.222.193])
 by lists.lttng.org (Postfix) with ESMTPS id 46jYNS2gZFzq5K
 for <lttng-dev@lists.lttng.org>; Tue,  1 Oct 2019 18:10:00 -0400 (EDT)
Received: by mail-qk1-f193.google.com with SMTP id z67so12863726qkb.12
 for <lttng-dev@lists.lttng.org>; Tue, 01 Oct 2019 15:10:00 -0700 (PDT)
Received: from gmail.com (192-222-181-218.qc.cable.ebox.net. [192.222.181.218])
 by smtp.gmail.com with ESMTPSA id c25sm8723886qtv.71.2019.10.01.15.09.57
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 15:09:57 -0700 (PDT)
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

The eighth bug-fix release of LTTng-Tools 2.10 - KeKriek has just been
released. This release addresses a number of issues listed below.

2019-10-01 lttng-tools 2.10.8 (International Coffee Day)
	* Fix: lttng: out-of-bound copy of arguments in 'view' command handler
	* sessiond: fix: strncpy called with source length
	* sessiond: fix: possible unaligned access in packed structure
	* lttng-ctl: fix: possible unaligned access in packed structure
	* consumer: fix: possible unaligned access in packed structure
	* inet: fix: possible unaligned access in packed structure (inet/inet6)
	* consumer: fix: unaligned accesses to index fields
	* lttng: fix: potential 0-length allocation in pid list parsing
	* Tests: fix: uninitialized session_id used on list_sessions failure
	* Tests: fix: uninitialized values passed to close() on error
	* lttng-ctl: fix: lttng_data_pending confuses communication status
	* Fix typo in regenerate statedump test util
	* Fix: metadata stream is not marked as quiescent after packet commit
	* Remove unused bitfield.h header
	* Fix: sessiond: fs.protected_regular sysctl breaks app registration
	* Fix: lttng-crash: detect truncated files
	* Fix: use newly created event filter for condition check
	* Fix: namespace our gettid wrapper
	* Fix: check for lttng modules presence before testing
	* Fix: test_crash: don't kill first app twice
	* Cleanup: test: don't stop relayd twice
	* Fix: test: utils.sh: exit from process on full_cleanup
	* Fix: utils.sh: handle SIGPIPE
	* Fix: tests: error handling in high throughput limits test (v2)
	* Improve handling of test SIGTERM/SIGINT (v2)
	* Fix: check validity of a stream before invoking ust flush command
	* Fix: initialize syscall table when kernel tracer is lazily initialized

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.10.8.tar.bz2

GPG sig:
https://lttng.org/files/lttng-tools/lttng-tools-2.10.8.tar.bz2.asc
