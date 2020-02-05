From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 1.5.8
Date: Wed, 5 Feb 2020 14:55:35 -0500
Message-ID: <20200205195535.GA20619@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by lists.lttng.org (Postfix) with ESMTPS id 48CXNq5VmZz2BN9
 for <lttng-dev@lists.lttng.org>; Wed,  5 Feb 2020 14:55:39 -0500 (EST)
Received: by mail-qt1-f176.google.com with SMTP id c5so2568271qtj.6
 for <lttng-dev@lists.lttng.org>; Wed, 05 Feb 2020 11:55:39 -0800 (PST)
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
Cc: diamon-discuss@lists.linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

Hi all,

Today we are releasing the eigth bug-fix release of Babeltrace
1.5. This release addresses a number of issues mainly related to the
use of the lttng-live protocol in conjunction with the new
`lttng-clear` command introduced by LTTng 2.12.

2020-02-05 babeltrace 1.5.8 (National Chocolate Fondue Day)
	* Fix: lttng-live format: do not error out on empty streams hang up
	* Fix: lttng-live: ctf_live_packet_seek stream hang up handling
	* Fix: lib/iterator.c: unbalanced ctx put (leak)
	* Fix: lttng-live: lttng_live_open_trace_read memory leak
	* Fix: trace-collection: trace clock use after free
	* Fix: lttng-live: use-after-free in get_next_index()
	* Do not use diagnostic pragma when GCC version is lower than 4.6.0
	* Missing define when not building with gcc

Project website: http://diamon.org/babeltrace/
Download link: http://www.efficios.com/files/babeltrace/babeltrace-1.5.8.tar.bz2
CTF specification: http://diamon.org/ctf/
