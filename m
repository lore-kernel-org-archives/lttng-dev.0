From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: dlopen, gcc -l and LD_PRELOAD
Date: Wed, 20 Mar 2013 12:38:59 -0400
Message-ID: <CAGDH53moAAai2wDwyUotSqyh-c_jfsOS1LTfCPg=XpqKnFim6Q__33852.9631532312$1363797596$gmane$org@mail.gmail.com>
References: <48CF5AC71E61DB46B70D0F388054EFFD028AB5@VAL-E-01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vb0-f41.google.com ([209.85.212.41])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1UIM2b-0001x8-Be
	for lttng-dev@lists.lttng.org; Wed, 20 Mar 2013 12:39:05 -0400
Received: by mail-vb0-f41.google.com with SMTP id l22so1253479vbn.28
	for <lttng-dev@lists.lttng.org>; Wed, 20 Mar 2013 09:38:59 -0700 (PDT)
In-Reply-To: <48CF5AC71E61DB46B70D0F388054EFFD028AB5@VAL-E-01.valcartier.drdc-rddc.gc.ca>
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

Hi Daniel,

>    Meanwhile I've been playing with some very simple examples of .so use, and found that the behaviour of LD_PRELOAD is incompletely documented.  For instance, if I run:

Take a look at "man 8 ld.so". It should answer most of the questions
you have about the dynamic linker libraries lookup mechanism.

>    The above should explain the trouble I've been having with lttng-ust's doc/examples/easy-ust and tests/demo.

Glad to see that you solved your issue!

Thanks,

Christian
