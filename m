From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: lttng-ust quick start?
Date: Fri, 11 Jan 2013 17:45:26 -0500
Message-ID: <CAGDH53nz9-O_RU+QNg64r8HeoJq7xTf_=-PpqoFNsFftrSZ6eg__31139.747441239$1357944381$gmane$org@mail.gmail.com>
References: <3CA1A65C03C1A34C81BBC6272782E696987596@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1TtnLw-0003SH-Qp
	for lttng-dev@lists.lttng.org; Fri, 11 Jan 2013 17:45:32 -0500
Received: by mail-ie0-f180.google.com with SMTP id c10so3053744ieb.11
	for <lttng-dev@lists.lttng.org>; Fri, 11 Jan 2013 14:45:26 -0800 (PST)
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E696987596@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

> Turning to the Internet, I find https://github.com/giraldeau/lttng-ust/tree/master/doc/examples/easy-ust and grab the handful of files found there.
> I then open a console within that directory and invoke make:

Please use an official git repository such as: git://git.lttng.org/lttng-ust.git
Or you can use a source distribution:
http://lttng.org/files/lttng-ust/lttng-ust-2.1.0.tar.bz2

Normally this example should be installed in
/usr/share/doc/lttng-ust/examples/easy-ust or
/usr/local/share/doc/lttng-ust/examples/easy-ust in your case.

Christian
