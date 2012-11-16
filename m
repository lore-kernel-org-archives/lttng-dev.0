From: "Woegerer, Paul" <Paul_Woegerer@mentor.com>
Subject: "No space left on device" results in corrupt trace data
	set
Date: Fri, 16 Nov 2012 16:02:57 +0100
Message-ID: <50A655A1.6040804__41489.1651984819$1353078169$gmane$org@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from relay1.mentorg.com ([192.94.38.131])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <Paul_Woegerer@mentor.com>) id 1TZNQd-0006Vw-Ik
	for lttng-dev@lists.lttng.org; Fri, 16 Nov 2012 10:01:59 -0500
Received: from svr-orw-exc-10.mgc.mentorg.com ([147.34.98.58])
	by relay1.mentorg.com with esmtp
	id 1TZNQX-00062V-88 from Paul_Woegerer@mentor.com
	for lttng-dev@lists.lttng.org; Fri, 16 Nov 2012 07:01:53 -0800
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi,

embedded users sometimes have to trace to tmpfs (e.g. streaming in not
an option due to missing network connectivity).

Ramdisks of 16M to 128M size are created and as long as the ram disk
does not get full, tracing works fine. Unfortunately if the disk gets
full things fall apart:

PERROR: Error in file write: No space left on device [in
lttng_consumer_on_read_subbuffer_mmap() at consumer.c:1367]

The consumer daemon will not be able to write the metadata channel and
therefore the trace data set will be unusable (cannot be read with
babeltrace).

-rwxrwxrwx 1 testuser users        0 Nov 16 11:22 metadata
-rwxrwxrwx 1 testuser users 15728640 Nov 16 11:22 myevents_0
-rwxrwxrwx 1 testuser users     4096 Nov 16 11:22 myevents_1

Is it possible to somehow reserve the file size (fallocate) for metadata
so that in case the disk gets full at least the metadata gets written
and the resulting trace set is readable with babeltrace ?

I wonder if that is possible at all. The consumer daemon doesn't know
upfront how much would need to be reserved for metadata, right ?

Any ideas ?

Thanks,
Paul


-- =

Paul Woegerer | SW Development Engineer
http://go.mentor.com/sourceryanalyzer

Mentor Embedded(tm) | Prinz Eugen Stra=DFe 72/2/4, Vienna, 1040 Austria
Nucleus=AE | Linux=AE | Android(tm) | Services | UI | Multi-OS

Android is a trademark of Google Inc. Use of this trademark is subject
to Google Permissions.
Linux is the registered trademark of Linus Torvalds in the U.S. and
other countries.
