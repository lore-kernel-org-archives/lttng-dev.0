From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: LTTng-tools 2.10.10 - KeKriek
Date: Thu, 6 Feb 2020 16:07:51 -0500
Message-ID: <20200206210751.GA11112@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by lists.lttng.org (Postfix) with ESMTPS id 48D9xl673Cz10Yb
 for <lttng-dev@lists.lttng.org>; Thu,  6 Feb 2020 16:07:55 -0500 (EST)
Received: by mail-qk1-f178.google.com with SMTP id j20so58661qka.10
 for <lttng-dev@lists.lttng.org>; Thu, 06 Feb 2020 13:07:55 -0800 (PST)
Received: from gmail.com (192-222-181-218.qc.cable.ebox.net. [192.222.181.218])
 by smtp.gmail.com with ESMTPSA id p26sm257999qkp.34.2020.02.06.13.07.53
 for <lttng-dev@lists.lttng.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Feb 2020 13:07:53 -0800 (PST)
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

The tenth bug-fix release of LTTng-tools 2.10 - KeKriek has just been
released. This release addresses a number of issues listed below.

2020-02-05 lttng-tools 2.10.10 (National Chocolate Fondue Day)
	* Fix: include stdlib.h in compat/string.h
	* Fix: lttng: sanity check of `--probe` description
	* Fix: lttng: placing probe on symbol starting with `_`
	* Fix: update context types for Python bindings
	* doc: Fix bind address example for lttng-relayd
	* Require automake >= 1.12
	* Fix: sessiond: ust: deadlock with per-pid buffers
	* Fix: lttng: initialize sessions pointer to NULL
	* Fix: sessiond: use system LTTng-UST headers when available
	* doc/man: use specific revision date for each manual page

As always, please report any issue you may encounter to bugs.lttng.org
or on this mailing list.

Project website: https://lttng.org

Download link:
https://lttng.org/files/lttng-tools/lttng-tools-2.10.10.tar.bz2

GPG signature:
https://lttng.org/files/lttng-tools/lttng-tools-2.10.10.tar.bz2.asc
