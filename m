From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: =?iso-8859-1?q?=5BRELEASE=5D_LTTng-Tools_2=2E9=2E12_?=
 =?iso-8859-1?q?-_Joann=E8s?=
Date: Fri, 24 May 2019 17:33:53 -0400
Message-ID: <20190524213352.GC9974__24749.7281221271$1558733650$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com
 [209.85.217.47])
 by lists.lttng.org (Postfix) with ESMTPS id 459fks3cTWz12VR
 for <lttng-dev@lists.lttng.org>; Fri, 24 May 2019 17:33:57 -0400 (EDT)
Received: by mail-vs1-f47.google.com with SMTP id c24so6826407vsp.7
 for <lttng-dev@lists.lttng.org>; Fri, 24 May 2019 14:33:57 -0700 (PDT)
Received: from gmail.com (192-222-181-218.qc.cable.ebox.net. [192.222.181.218])
 by smtp.gmail.com with ESMTPSA id e19sm2980760vsc.24.2019.05.24.14.33.55
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Fri, 24 May 2019 14:33:55 -0700 (PDT)
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

The twelfth bug-fix release of LTTng-Tools 2.9 - Joann=E8s has just been
released. This release addresses a number of issues listed below.

2019-05-24 lttng-tools 2.9.12 (Asparagus Day)
	* Update base test for binding
	* Fix: python binding: expose domain buffer type
	* Fix: logging: log_add_time() save/restore errno
	* Fix relayd: initialize beacon to -1ULL
	* Fix: relayd: handling of lttng_read errors >=3D 0
	* Fix tests: NULL pointer dereference in ust channel unit tests
	* Fix tests: NULL pointer dereference in ltt_ust_context unit tests
	* Log the wait-shm's path on shm_open failure
	* Fix: skip test when ust doesn't have perf support
	* Fix: Properly sanitize input parameter
	* tap-driver.sh: flush stdout after each test result
	* Fix tests: snapshot size validation failure runs too many test cases
	* Fix tests: the tree origin can be a symlink itself
	* Fix tests: skip test_getcpu_override on single core systems
	* Fix: consumer snapshot: handle unsigned long overflow
	* Fix: wrong error code returned by kernel_snapshot_record()
	* Docs: document the format of the lttng_session path member
	* Fix: check illegal combinations of ctrl-url/data-url/ouput/set-url
	* Tests: take multiple snapshots in streaming mode
	* Fix: don't destroy the sockets if the snapshot was successful

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.9.12.tar.bz2

GPG sig:
https://lttng.org/files/lttng-tools/lttng-tools-2.9.12.tar.bz2.asc
