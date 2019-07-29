From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: gcc plugin for instrumenting individual functions
Date: Mon, 29 Jul 2019 15:22:59 -0400
Message-ID: <20190729192259.GA28213__28495.4201591731$1564428201$gmane$org@joraj-alpa>
References: <CAAS9doaz=dF_42vWaKO9mnRgua8hTNrgx+aHQZ0j9XTAhy0vmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 45y8jN3mjZz1G0J
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 15:23:04 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id E05302B1321
 for <lttng-dev@lists.lttng.org>; Mon, 29 Jul 2019 15:23:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAAS9doaz=dF_42vWaKO9mnRgua8hTNrgx+aHQZ0j9XTAhy0vmw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Christophe =?iso-8859-1?Q?B=E9dard?= <bedard.christophe@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

Hi,

For those at home wondering why this would be relevant to lttng,
lttng-ust comes with a utility shared object allowing you to leverage the
-finstrument-function sites to hook lttng tracepoints [1].

[1] https://lttng.org/man/3/lttng-ust-cyg-profile/v2.10/

Thanks Christophe for this contribution.

Do you know why GCC does not support this out of the box? Is this something=
 that
could be presented to the GCC community?

Cheers

On Mon, Jul 29, 2019 at 08:56:15PM +0200, Christophe B=E9dard wrote:
> Hi,
> =

> Sharing this just in case it can help someone!
> =

> gcc only lets you disable instrumentation, using the
> `no_instrument_function` attribute, or by matching file names. It does not
> let you explicitly choose the individual functions you want to instrument.
> =

> I've searched many times for a way to do it, but never found anything for
> some reason, so I wrote this plugin:
> https://github.com/christophebedard/instrument-attribute-gcc-plugin
> =

> It simply enables instrumentation for functions with the
> `instrument_function` attribute, and disables instrumentation for all oth=
er
> functions.
> =

> =

> Christophe

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- =

Jonathan Rajotte-Julien
EfficiOS
