From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: [RFC] CTF files support
Date: Thu, 22 Aug 2013 17:38:16 -0400
Message-ID: <1377207497-26822-1-git-send-email-eeppeliteloop__6230.2176644609$1377208223$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qe0-f52.google.com ([209.85.128.52])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <eeppeliteloop@gmail.com>) id 1VCcae-00083U-6e
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 17:38:50 -0400
Received: by mail-qe0-f52.google.com with SMTP id a11so1448429qen.25
	for <lttng-dev@lists.lttng.org>; Thu, 22 Aug 2013 14:38:42 -0700 (PDT)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: file@mx.gw.com
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

This patch adds support for CTF trace files. CTF is a trace format
that's gaining popularity amongst trace producers. It's the format used
by the LTTng tracer <http://lttng.org/>.

Details about the format can be found here: <http://www.efficios.com/ctf>.

The CTF metadata can also be found in an alternative text form. In this
case, it starts with exactly "/* CTF " followed by the version number.
Looks like this currently:

    /* CTF 1.8

Of course it's easy to write a magic file for file(1) to detect it.
However, the CTF metadata language looks very much like the C language
(it has lots of shared keywords with C) so file(1) will detect it as
a C file first.

Knowing this, would you accept a patch merging the C and CTF text
metadata magics? This would be similar to Mach-O and Java having common
detection code in "cafebabe".

Thank you,
Phil

Philippe Proulx (1):
  Add support for CTF trace files

 magic/Magdir/ctf  | 18 ++++++++++++++++++
 magic/Makefile.am |  1 +
 2 files changed, 19 insertions(+)
 create mode 100644 magic/Magdir/ctf

-- 
1.8.3.4
