From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: =?iso-8859-1?q?=5BRELEASE=5D_LTTng-Tools_2=2E9=2E13_?=
 =?iso-8859-1?q?-_Joann=E8s?=
Date: Tue, 1 Oct 2019 18:11:15 -0400
Message-ID: <20191001221115.GC52120__29492.1534297586$1569967893$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f196.google.com (mail-qt1-f196.google.com
 [209.85.160.196])
 by lists.lttng.org (Postfix) with ESMTPS id 46jYPz6tprzq65
 for <lttng-dev@lists.lttng.org>; Tue,  1 Oct 2019 18:11:19 -0400 (EDT)
Received: by mail-qt1-f196.google.com with SMTP id n7so23726131qtb.6
 for <lttng-dev@lists.lttng.org>; Tue, 01 Oct 2019 15:11:19 -0700 (PDT)
Received: from gmail.com (192-222-181-218.qc.cable.ebox.net. [192.222.181.218])
 by smtp.gmail.com with ESMTPSA id t63sm8342943qkf.48.2019.10.01.15.11.17
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Oct 2019 15:11:17 -0700 (PDT)
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

The tirteenth bug-fix release of LTTng-Tools 2.9 - Joann=E8s has just
been released. This release addresses a number of issues listed below.

2019-10-01 lttng-tools 2.9.13 (International Coffee Day)
	* Fix: lttng: out-of-bound copy of arguments in 'view' command handler
	* sessiond: fix: strncpy called with source length
	* sessiond: fix: possible unaligned access in packed structure
	* inet: fix: possible unaligned access in packed structure (inet/inet6)
	* consumer: fix: unaligned accesses to index fields
	* lttng: fix: potential 0-length allocation in pid list parsing
	* Tests: fix: uninitialized session_id used on list_sessions failure
	* Tests: fix: uninitialized values passed to close() on error
	* lttng-ctl: fix: lttng_data_pending confuses communication status
	* Fix typo in regenerate statedump test util
	* Fix: metadata stream is not marked as quiescent after packet commit
	* Fix: sessiond: fs.protected_regular sysctl breaks app registration
	* Fix: lttng-crash: detect truncated files
	* Fix: use newly created event filter for condition check
	* Fix: check validity of a stream before invoking ust flush command
	* Fix: initialize syscall table when kernel tracer is lazily initialized

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.9.13.tar.bz2

GPG sig:
https://lttng.org/files/lttng-tools/lttng-tools-2.9.13.tar.bz2.asc
