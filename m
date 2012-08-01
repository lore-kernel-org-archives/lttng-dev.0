From: Yannick Brosseau <yannick.brosseau@gmail.com>
Subject: Re: [lttng-tools PATCH] lttng-tools python module
Date: Wed, 01 Aug 2012 12:12:15 -0400
Message-ID: <5019555F.9090108__11903.7062665031$1343837566$gmane$org@gmail.com>
References: <1343326167-11522-1-git-send-email-danny.serres@efficios.com>
	<50182739.3030604@polymtl.ca> <50182FEF.6070504@gmail.com>
	<501936F6.7010800@polymtl.ca>
	<CAGDH53mt0N1BiqL3opx8Mh6rkS78ndzAnak7G742xQVeur-YGw@mail.gmail.com>
	<50195316.6070606@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-yx0-f176.google.com ([209.85.213.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1SwbX6-00016E-KT
	for lttng-dev@lists.lttng.org; Wed, 01 Aug 2012 12:12:24 -0400
Received: by yenl5 with SMTP id l5so8564089yen.35
	for <lttng-dev@lists.lttng.org>; Wed, 01 Aug 2012 09:12:19 -0700 (PDT)
In-Reply-To: <50195316.6070606@polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <david.goulet@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org


-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 2012-08-01 12:02, David Goulet wrote:
> I agree with that.
>
> The main reason for extras/ is the fact that, for now, this lib would
not be
> supported meaning that if liblttng-ctl changes, these bindings will NOT
follow
> it unless someone submit a patch. If we decide at some point to fully
support
If its not supported, maybe we should not put it upstream.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlAZVV8ACgkQFQrZ7GzHX2qbjQCgnpAkLTTBfsA5HVFuzfTnW+Bu
FPgAoMSDLCMdqSE9ZpYgMbjiighqee1B
=f7Xg
-----END PGP SIGNATURE-----
