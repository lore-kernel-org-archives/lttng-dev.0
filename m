From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [RELEASE] lttv 1.5
Date: Sun, 20 Oct 2013 00:57:51 -0400
Message-ID: <526362CF.7010909__4523.74908277324$1382245108$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1VXl5L-0001Y4-AS
	for lttng-dev@lists.lttng.org; Sun, 20 Oct 2013 00:57:52 -0400
Received: by mail-ie0-f173.google.com with SMTP id u16so9222230iet.18
	for <lttng-dev@lists.lttng.org>; Sat, 19 Oct 2013 21:57:45 -0700 (PDT)
Received: from [192.168.10.27] (c66.110.155-117.clta.globetrotter.net.
	[66.110.155.117])
	by mx.google.com with ESMTPSA id p5sm10816299igj.10.2013.10.19.21.57.44
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Sat, 19 Oct 2013 21:57:45 -0700 (PDT)
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


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi all,

I'm releasing today lttv version 1.5. This version replace the internal
trace
reading library with libbabeltrace to read CTF/lttng 2.x traces.

Direct download:
http://lttng.org/files/packages/lttv-1.5-beta1.tar.bz2

The changes since the last beta release are mostly some small bug fixes
and code cleanup.
Complete changelog is available in the git repository:
http://git.lttng.org/?p=lttv.git;a=summary

The Linux Trace Toolkit Viewer (LTTV) is a trace visualization tool
based on GTK and libbabeltrace. It can read and display traces generated
by the LTTng tracers.

Available features:
- - Command line text dump
- - GUI: Event view, State view (Control Flow view), Resource view and
Histogram

Filters, statistics and trace synchronization are not available at this
time.

If you find bugs, please report them in our tracker:
http://bugs.lttng.org/projects/lttv

Project website: http://lttng.org/lttv
Download link: http://lttng.org/download

Yannick Brosseau
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iEYEARECAAYFAlJjYsMACgkQFQrZ7GzHX2q15QCdF7hpdJ4Bu0sL8a3QBUSf93ah
ff0AoJAZDpnof5QJacmrLseP2vj63e4q
=XGwq
-----END PGP SIGNATURE-----
