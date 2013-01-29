From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: The disable-libtool-linkdep-fixup configure option
Date: Tue, 29 Jan 2013 11:54:03 -0500
Message-ID: <CAGDH53kFx+OrqS=T=k5-OxJRmORmL9PHqF2=9wDhCgaWRs-ZVg__16532.2805093185$1359478490$gmane$org@mail.gmail.com>
References: <3CA1A65C03C1A34C81BBC6272782E6969BDD05@valcartierex01.valcartier.drdc-rddc.gc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f180.google.com ([209.85.210.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1U0ERl-00049X-9s
	for lttng-dev@lists.lttng.org; Tue, 29 Jan 2013 11:54:09 -0500
Received: by mail-ia0-f180.google.com with SMTP id f27so845283iae.39
	for <lttng-dev@lists.lttng.org>; Tue, 29 Jan 2013 08:54:03 -0800 (PST)
In-Reply-To: <3CA1A65C03C1A34C81BBC6272782E6969BDD05@valcartierex01.valcartier.drdc-rddc.gc.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Thibault, Daniel" <Daniel.Thibault@drdc-rddc.gc.ca>
Cc: lttng-dev@lists.lttng.org, "Couture, Mario" <Mario.Couture@drdc-rddc.gc.ca>, =?UTF-8?B?UGFpbmNoYXVkLCBGcsOpZMOpcmlj?= <Frederic.Painchaud@drdc-rddc.gc.ca>
List-Id: lttng-dev@lists.lttng.org

Hi Daniel,

> Why then is the option named *disable*-libtool-linkdep-fixup?  Shouldn't it be named *enable*-libtool-linkdep-fixup instead?

Because the option is enabled by default on all systems. This is to
facilitate cross-compilation on Debian/Ubuntu systems.

Thanks,

Christian
