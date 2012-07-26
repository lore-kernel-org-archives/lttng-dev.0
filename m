From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: Question about lttng daemons
Date: Thu, 26 Jul 2012 10:59:32 -0400
Message-ID: <50115B54.60909__48983.5219610997$1343314846$gmane$org@gmail.com>
References: <5010FFA8.9000706@emc.com> <5011570E.3060200@voxpopuli.im>
	<50115A3F.5010402@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yw0-f48.google.com ([209.85.213.48])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SuPXQ-00047F-MQ
	for lttng-dev@lists.lttng.org; Thu, 26 Jul 2012 10:59:40 -0400
Received: by yhfq46 with SMTP id q46so2386268yhf.35
	for <lttng-dev@lists.lttng.org>; Thu, 26 Jul 2012 07:59:34 -0700 (PDT)
In-Reply-To: <50115A3F.5010402@efficios.com>
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


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>
> > We don't ship an example in the source tree, since this is usually
> > distro-specific, but for reference you can look at the Upstart
> > script that is available in the Ubuntu package:
> >
http://bazaar.launchpad.net/~ubuntu-branches/ubuntu/quantal/lttng-tools/quantal/view/head:/debian/lttng-tools.lttng-sessiond.upstart
>
>
> We could maybe provide this upstart script in extras/ ?

Yes, probably, with also the systemd script and the old style
initscript. (I've made both)
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlARW0sACgkQFQrZ7GzHX2qV4gCg50X4koCVPUft///BIdFy0wBi
gmEAn1c0JN9Rv4BFecT75Kp1DaXUYLAw
=EH/p
-----END PGP SIGNATURE-----
