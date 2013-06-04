From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: [RELEASE] lttv 1.5-beta1
Date: Tue, 04 Jun 2013 16:07:24 -0400
Message-ID: <51AE48FC.3000306__45115.6000294306$1370376487$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UjxVz-0004G1-UY
	for lttng-dev@lists.lttng.org; Tue, 04 Jun 2013 16:07:32 -0400
Received: by mail-ie0-f175.google.com with SMTP id a11so1460400iee.20
	for <lttng-dev@lists.lttng.org>; Tue, 04 Jun 2013 13:07:26 -0700 (PDT)
Received: from [132.207.72.30] (dyn30.dorsal.polymtl.ca. [132.207.72.30])
	by mx.google.com with ESMTPSA id vc15sm3167977igb.7.2013.06.04.13.07.25
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Tue, 04 Jun 2013 13:07:25 -0700 (PDT)
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

I'm glad to announce a first beta version of LTTV working with LTTng 2.x
traces. It's a port of the old version which replace the internal trace
reading library with libbabeltrace to read CTF traces.

The Linux Trace Toolkit Viewer (LTTV) is a trace visualization tool
based on GTK and libbabeltrace. It can read and display traces generated
by the LTTng tracers.

Available features:
- - Command line text dump
- - GUI: Event view, State view (Control Flow view), Resource view and
Histogram

Filters, statistics and trace synchronization are not available at this
time.

Since it's a first beta, you will probably find some bugs. Please report
them in our tracker: http://bugs.lttng.org/projects/lttv

Project website: http://lttng.org/lttv
Download link: http://lttng.org/download

Complete changelog is available in the git repository:
http://git.lttng.org/?p=lttv.git;a=summary

Yannick Brosseau
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGuSM0ACgkQFQrZ7GzHX2qcugCfa0fQmCWUUmod1OLZ2nPBEgP3
7tcAoLVUmE0wVm35T0ndZC2NyMQJ5U/M
=+Sr0
-----END PGP SIGNATURE-----
