From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [lttng-tools PATCH] Move metset in channel_set_attr
 after the null check
Date: Thu, 07 Jun 2012 13:43:07 -0400
Message-ID: <4FD0E82B.9050705__45281.4323049553$1339091025$gmane$org@gmail.com>
References: <1339008870-4891-1-git-send-email-serres@live.ca>
	<4FD0DF60.2080709@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ob0-f176.google.com ([209.85.214.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1Scgjt-0008JF-Vx
	for lttng-dev@lists.lttng.org; Thu, 07 Jun 2012 13:43:18 -0400
Received: by obbef5 with SMTP id ef5so1576151obb.35
	for <lttng-dev@lists.lttng.org>; Thu, 07 Jun 2012 10:43:12 -0700 (PDT)
In-Reply-To: <4FD0DF60.2080709@efficios.com>
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

On 2012-06-07 13:05, David Goulet wrote:
> Hi Danny,
>
> I've merged your patch. Thanks! It's now upstream and in stable-2.0 :).
>
> Just a note for the next time. This is a "Fix" patch so in the commit
message,
> start with "Fix:". I've changed it for you for this commit. Only commit
with
> Fix: are picked for the stable-2.0 branch.

That's something that need to be documented somewhere, even I was not
aware of it.

Yannick
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk/Q6CEACgkQFQrZ7GzHX2qMdACgp+BK+/BnN5huiBwPn53TYDlS
Ab8An0yG5OnKwl+Ugp/eKK2Ir3WnJoFu
=7F2t
-----END PGP SIGNATURE-----
