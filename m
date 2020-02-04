From: =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau <jeremie.galarneau@efficios.com>
Subject: [RELEASE] Babeltrace 2.0.1 - Amqui
Date: Tue, 4 Feb 2020 16:48:05 -0500
Message-ID: <20200204214805.GA106763@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qk1-f195.google.com (mail-qk1-f195.google.com
 [209.85.222.195])
 by lists.lttng.org (Postfix) with ESMTPS id 48Byx56d27z2BHh
 for <lttng-dev@lists.lttng.org>; Tue,  4 Feb 2020 16:48:09 -0500 (EST)
Received: by mail-qk1-f195.google.com with SMTP id j20so19604944qka.10
 for <lttng-dev@lists.lttng.org>; Tue, 04 Feb 2020 13:48:09 -0800 (PST)
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
To: lttng-dev@lists.lttng.org, diamon-discuss@lists.linuxfoundation.org
List-Id: lttng-dev@lists.lttng.org

Hi everyone!

Today we're releasing the first patch-level release of Babeltrace 2.0
"Amqui".

What's new since Babeltrace 2.0.0?
==================================
This release contains minor bug fixes which are mainly
related to packaging and documentation issues.

Of note for packagers, we have changed the autoconf package name to
`babeltrace2`. This fixes co-installation problems with Babeltrace
1.x, but also changes the naming scheme of the official tarball.

The official tarballs of Babeltrace 2 are now named
`babeltrace2-$VERSION.tar.bz2`. We have added a symlink to reflect
this naming scheme to the prior Babeltrace 2.0.0 release.

The full change log follows.

2020-02-04 Babeltrace 2.0.1
	* fix: Remove empty python bindings documentation
	* README: Babeltrace 2 was released in 2020
	* fix: set autoconf package name to babeltrace2
	* Typo: occured -> occurred
	* .gitignore: Add missing bt2/native_bt.d
	* fix: build failure on ppc64el with '-Werror=format-overflow='
	* Silence -Wnull-dereference warning in generated CTF parser code
	* plugin-so.c: add comment about why we're not using a GLib linked list
	* doc: graph.h: do not link to `man7.org` for `babeltrace(1)`
	* fix: common/list.h is LGPL-2.1
	* fix: build Python bindings with GCC10
	* fix: use correct function to print 'enum bt_ctf_scope'
	* Update working version to Babeltrace 2.0.1


Important links
===============
Babeltrace 2.0.1 tarball:
    https://www.efficios.com/files/babeltrace/babeltrace2-2.0.1.tar.bz2

Babeltrace website:
    https://babeltrace.org

Mailing list (for support and development):
    `lttng-dev at lists.lttng.org`

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
