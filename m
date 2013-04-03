From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH lttng-tools] lttng cli: Accept human
 readable sizes for --subbuf-size
Date: Wed, 3 Apr 2013 15:55:15 -0400
Message-ID: <CAFXXi0nKoZA4RNFCBEEqC4sYm2cjY8xfAute+aQvx3-Xaw8SiQ__3392.74768853119$1365019006$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD12D04580@VAL-E-02.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f180.google.com ([209.85.223.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UNTmg-00038x-Kb
	for lttng-dev@lists.lttng.org; Wed, 03 Apr 2013 15:55:50 -0400
Received: by mail-ie0-f180.google.com with SMTP id a11so2137611iee.25
	for <lttng-dev@lists.lttng.org>; Wed, 03 Apr 2013 12:55:45 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD12D04580@VAL-E-02.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, "Couture,
	Mario" <Mario.Couture@drdc-rddc.gc.ca>, "Painchaud,
	Frederic" <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

>    Normally I'd be the first to advocate k, M, G as powers of 10 and Ki, Mi, Gi as powers of two (ISO/IEC 80000-13:2008) but the kernel parameters use exclusively K, M, and G in the powers of two sense, and I believe just about every other part of Linux does also.  We should thus, somewhat unfortunately, stick to powers of two.  Just be sure to explicitly give the multipliers' values in the help.  Oh, and accept just the upper-case letters, like the kernel parameters do.

Yeah.. we need to accept capital K for kilo (kibi) because everyone
else does. Actually I was thinking of mimicking the behaviour of dd.
For kilo (kibi), you can use upper and lower case (probably reeks of
when there was no such things as lower case letters in computing. I
look at you FORTRAN). But for mega (mibi) and giga (gibi), it's upper
case only.

The more I think about it, the more I think it doesn't matter if we
accept upper and lower case for all... I don't know anybody who will
request a buffer of 32 millibytes.
