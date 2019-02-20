From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: Tracepoints firing without being enabled in LTTng
Date: Wed, 20 Feb 2019 13:53:10 -0500
Message-ID: <20190220185310.GC4583__24328.9074207254$1550688810$gmane$org@joraj-alpa>
References: <CAJyWpKEMbN8RHuGbODZYFiOff_pN08Zn4A=6dMEEe7C7h3nn1g@mail.gmail.com>
 <CAJyWpKH2TWmCXhvtSaE-h+jKfmt8aKQ0MaYOr_TqQ0q+M1f_gw@mail.gmail.com>
 <CADcCL0hnLNyzOvfpBRW=TzDR9Ekckei5NGOqpAQ=rMUpGnRLEQ@mail.gmail.com>
 <CAJyWpKEgHDa2gPte2eTVg9UCo6RBOBKfPLg9XFUyVcVxMoj8tA@mail.gmail.com>
 <CADcCL0gt=kQop0miSLD3edcKLNERgg+XEjmgkvzdX=A4t_MzuQ@mail.gmail.com>
 <CAJyWpKGEC5dXZXWTupdJA6BVUQhzp5dT-jDX6iX_EE=JrvU4KA@mail.gmail.com>
 <CADcCL0ieGaTA4_=rxaLT2=LAuhQdJGfjM7HYg34eTo-Oo_JDYg@mail.gmail.com>
 <CAJyWpKG2mJJ-DnHLr1gRhrPw5Qsj=TT0j_5FCaQKv7t0qkqcdA@mail.gmail.com>
 <1429830431.1895.1550674017298.JavaMail.zimbra@efficios.com>
 <CAJyWpKHVzmnJp5Mjc9ddQncHM54=b5Ecr2GcpdLLx_8hXojdEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 444RZH5Zs8zgZ6
 for <lttng-dev@lists.lttng.org>; Wed, 20 Feb 2019 13:53:11 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <CAJyWpKHVzmnJp5Mjc9ddQncHM54=b5Ecr2GcpdLLx_8hXojdEw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mosleh Uddin <mosleh1235@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Feb 20, 2019 at 01:43:00PM -0500, Mosleh Uddin wrote:
> Hello,
> 
> I see, I was loading the liblttng-ust-fd but not fork. Once loading both of
> these with LD_PRELOAD everything seems to be working great. Thank you for
> all your assistance.
> 
> I was also wondering, it may be impractical to always load these shared
> objects because the systems starts the app service on boot. Is there an

How is it not practical? I fail to see the problem with launching the
application with LD_PRELOAD set inside the service.

> lttng alternative to integrate this into the build?  I am not too familiar
> with dynamic linking so sorry if this sounds trivial.
> 
> Thanks
-- 
Jonathan Rajotte-Julien
EfficiOS
