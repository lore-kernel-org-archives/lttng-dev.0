From: Christian Babeux <christian.babeux@efficios.com>
Subject: Re: Request information on "Live" view of traces
Date: Tue, 3 Sep 2013 11:36:23 -0400
Message-ID: <CAGDH53n23sZ30Uh+7DUmfM2oujb3R6yu-CroROztqhDchffJKA__11310.3939839222$1378222649$gmane$org@mail.gmail.com>
References: <CAFw4v59-2FvgVtQ=YCNhYXX3B9+y+hNdFpb0JnpOHxNCvc5vCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f171.google.com ([209.85.220.171])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <christian.babeux@0x80.ca>) id 1VGseb-0006XQ-2U
	for lttng-dev@lists.lttng.org; Tue, 03 Sep 2013 11:36:35 -0400
Received: by mail-vc0-f171.google.com with SMTP id ij15so4038570vcb.16
	for <lttng-dev@lists.lttng.org>; Tue, 03 Sep 2013 08:36:23 -0700 (PDT)
In-Reply-To: <CAFw4v59-2FvgVtQ=YCNhYXX3B9+y+hNdFpb0JnpOHxNCvc5vCA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Dror Granot <dror@reduxio.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi Dror,

> We are using now lttng in our development and want to have it on our product
> for customers.

Awesome!

> I would really appreciate if you can update me on the time frame of "live"
> view of traces. If you know, what will it include and when it is supposed to
> be, it can help us much in our decision.

The live streaming/view of traces has been under development for a
while. We intend to merge it in the master branch this month. As for
the release candidate cycle and final release (2.4), we are aiming for
mid-november.

Maybe Julien can fill you in with more details on what the live
release will contain.

Thanks,

Christian

On Mon, Sep 2, 2013 at 3:30 AM, Dror Granot <dror@reduxio.com> wrote:
> Hi,
> We are using now lttng in our development and want to have it on our product
> for customers.
> The one thing that we are really missing on lttng is the fact that we cannot
> "live" view traces. The fact that we cannot have "tail -f" like option or
> "less" like capabilities might be the decision factor of moving out from
> lttng use.
> I would really appreciate if you can update me on the time frame of "live"
> view of traces. If you know, what will it include and when it is supposed to
> be, it can help us much in our decision. If there is any other option to use
> in the mean time instead, it will be great to know as well..
> Thanks in advance
> Dror Granot
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
