From: Bernd Hufmann <Bernd.Hufmann@ericsson.com>
Subject: Re: Fwd:  [RELEASE] LTTng-tools 2.1.0-rc2
Date: Wed, 22 Aug 2012 14:09:21 -0400
Message-ID: <50352051.20303__12039.9625775919$1345659033$gmane$org@ericsson.com>
References: <502EA58E.2060003@efficios.com> <50350CB8.1040004@polymtl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from imr3.ericy.com ([198.24.6.13])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <bernd.hufmann@ericsson.com>) id 1T4FNK-0001RS-VE
	for lttng-dev@lists.lttng.org; Wed, 22 Aug 2012 14:09:55 -0400
Received: from eusaamw0711.eamcs.ericsson.se ([147.117.20.178])
	by imr3.ericy.com (8.13.8/8.13.8) with ESMTP id q7MI8uDZ031128
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <lttng-dev@lists.lttng.org>; Wed, 22 Aug 2012 13:09:49 -0500
In-Reply-To: <50350CB8.1040004@polymtl.ca>
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

Hi David

I tried RC2 and I was able to create a session and to import traces 
remotely with the current Eclipse Tracer Control. I only had to change 
the supported version in the Eclipse Tracer control. Thanks for the 
updates.
I'll do some more tests. I'll let you know in case I find something else.

Best Regards
Bernd

On 08/22/2012 12:45 PM, David Goulet wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Greetings everyone,
>
> The lttng-tools project provides a session daemon (lttng-sessiond)
> that acts as a tracing registry, the "lttng" command line for tracing
> control, a lttng-ctl library for tracing control and a lttng-relayd
> for network streaming.
>
> This is the release candidate version 2 for lttng-tools.
>
> 2012-08-22 lttng-tools 2.1.0-rc2
>          * Fix: put back 2.0 output text for lttng create cmd
>          * Fix: remove set subdir call that uses bad ptr
>          * Filter: Handle the unary bitwise not operator (~) with an unsupported
>          * Fix: missing mutex unlock on register consumer err
>          * Remove underscore from ifndef of lttng.h
>          * Remove unused define in lttng.h
>          * Standardize lttng command line usage text
>          * Merge duplicate code in consumer for destroy relayd
>          * Merge duplicate code in consumer for add relayd
>          * Fix: Possible buffer overflows in strncat() usage
>          * Move code out of main.c and fix some issues
>
> Project website: http://lttng.org/lttng2.0
> Download link: http://lttng.org/files/lttng-tools/lttng-tools-2.1.0-rc2.tar.bz2
>
> Cheers!
> David
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.12 (GNU/Linux)
>
> iQEcBAEBAgAGBQJQNQy4AAoJEELoaioR9I02RjQH+QGN3zpCpqjQ4s752ZtvFHd7
> dthbrg/DhhSSew5YUBB4Wx7sQbGxG4RM3EATlzr482CmxqLmQpoWEl2PBtxJ762I
> 91PXm4+mwya0SIk8c70U+7/kNGT4ofBhmNwFOKxrNBAPnicxADZMP9n/w8IoJxFL
> dh9GawjqfRmftLltPQlYRAdbfoj5P+4KCwi+dWHMguSSpQK2shMN7f4DmSf8L/fY
> X1Z92NYV2I5Ez1/prAUKMh912yEQnKmH8d7bg7grMt92O2noBXRW5mldPw9p8MVV
> NWpGqV4vSpw8dy7zseWpCJ/YfJETEOv9Zdcu15Asfj/izoiQxOW/5k0WMetGl1s=
> =HZNa
> -----END PGP SIGNATURE-----
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
