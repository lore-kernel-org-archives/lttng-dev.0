From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: LTTV for LTTng 2.x available in git master branch
Date: Thu, 02 May 2013 10:53:34 -0400
Message-ID: <51827DEE.7010101__16139.5706273199$1367506452$gmane$org@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f50.google.com ([209.85.212.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1UXutC-0003l5-He
	for lttng-dev@lists.lttng.org; Thu, 02 May 2013 10:53:43 -0400
Received: by mail-vb0-f50.google.com with SMTP id w16so525412vbb.37
	for <lttng-dev@lists.lttng.org>; Thu, 02 May 2013 07:53:37 -0700 (PDT)
Received: from ?IPv6:2001:0:53aa:64c:3cab:7a61:7b30:8ae?
	([2001:0:53aa:64c:3cab:7a61:7b30:8ae])
	by mx.google.com with ESMTPSA id v19sm3723656vek.3.2013.05.02.07.53.35
	for <lttng-dev@lists.lttng.org>
	(version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
	Thu, 02 May 2013 07:53:36 -0700 (PDT)
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

Hi All,

Earlier this week, I've pushed to git master the port of LTTV for the
CTF traces of LTTng 2.x.
Get it here: https://git.lttng.org/?p=lttv.git;a=summary

The controlflow view and event view are now working correctly.

I'm still working on code cleanup, on the resource view and on some
performance improvement. Once that is done, I'll do a first release of
that work.

Yannick
