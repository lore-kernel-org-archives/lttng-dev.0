From: "Ikaheimonen, JP" <jp_ikaheimonen@mentor.com>
Subject: Babeltrace for MINGW32
Date: Thu, 28 Feb 2013 07:46:08 +0000
Message-ID: <009B25148989C6458484484699278506985C19C1__41683.3000178032$1362037623$gmane$org@EU-MBX-01.mgc.mentorg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jp_ikaheimonen@mentor.com>) id 1UAyBz-0003wM-J3
	for lttng-dev@lists.lttng.org; Thu, 28 Feb 2013 02:46:15 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1UAyBt-0003E8-Fu from jp_ikaheimonen@mentor.com
	for lttng-dev@lists.lttng.org; Wed, 27 Feb 2013 23:46:09 -0800
Content-Language: en-US
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

I am interested in building a statically linked 32-bit Windows executable of babeltrace.
For that purpose, I have taken a shot at building babeltrace 1.0.3 with MinGW.
As for now, I've managed to build the main executable, which is all I'm interested about. Babeltrace-log and the test suite will not build right now.

MinGW is missing many library functions that babeltrace uses. I have written replacements for many of these. The replacement functions are not fully compliant with the original specifications, but they work well enough under babeltrace. This required some changed in the configure.ac file as well, so that my versions of uuid, fmemopen and open_memstream are correctly detected.

Occasionally, I have had to make changes to the babeltrace source code. As an example, MinGW cannot use directory file handles in any meaningful way, so functions such as openat() and dirfd() are out of the question. I have circumvented these problems by using open() instead of openat(). Also, MinGW seems to have a problem using pthread mutexes in a statically linked executable, so I'm just not using the float_mutex at all. I do not think that's a problem for me, as I'm using babeltrace as a single-threaded executable instead of a library.

I have flagged all source code changes with #ifdef __MINGW32__ .

Would these changes be of interest to the babeltrace community? How likely would they be accepted into the main sources?

Thank you,

JP Ikaheimonen
Mentor Graphics Embedded Systems Division
Nucleus(r) | Linux(r) | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and other countries.
