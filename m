From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: [Babeltrace PATCH 00/01] Move strerror_r to compat
	directory
Date: Mon, 20 May 2013 08:34:51 +0000
Message-ID: <009B25148989C6458484484699278506E5382C44__21744.167400948$1369039005$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UeLYZ-0000Ne-Rw
	for lttng-dev@lists.lttng.org; Mon, 20 May 2013 04:34:59 -0400
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Mathieu Desnoyers (mathieu.desnoyers@efficios.com)" <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I separated this patch from my MinGW-specific patch set into a separate (one-patch) set.
This particular change is not MinGW-specific, and should be applied separately.
The upcoming MinGW patch set will require this patch as well.

I hope to have implemented all the changes that were commented upon.
These include:

- The new function compat_strerror_r is a static inline function, completely defined in the header file.
- Because there are no new .c files, there are fewer changes to the build files.
- The new code follows the coding conventions of this community.

Cheers,
JP Ikaheimonen | SW Development Engineer http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
