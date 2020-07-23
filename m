From: "Kim, Seongab via lttng-dev" <lttng-dev@lists.lttng.org>
Subject: Re: [EXTERNAL] Re: difference of timestamp between
 babeltrace and python binding
Date: Thu, 23 Jul 2020 05:43:27 +0000
Message-ID: <ecb0253a30f54c1aa11b59588e89bc00@HIMDWSMB06.ad.harman.com>
References: <15ed8d31ec16483db50928860aa4a4e5@HIMDWSMB06.ad.harman.com>
 <CAB4xu_3=6yYndO-C49FQ=hXF4eC+f6WGgMQCJ9-GhbA4zQ8mCQ@mail.gmail.com>
Reply-To: "Kim, Seongab" <Seongab.Kim@harman.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail1.bemta24.messagelabs.com (mail1.bemta24.messagelabs.com
 [67.219.250.5])
 by lists.lttng.org (Postfix) with ESMTPS id 4BC1Tg0Wf6z1fS2
 for <lttng-dev@lists.lttng.org>; Thu, 23 Jul 2020 01:43:34 -0400 (EDT)
In-Reply-To: <CAB4xu_3=6yYndO-C49FQ=hXF4eC+f6WGgMQCJ9-GhbA4zQ8mCQ@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Philippe Proulx <eeppeliteloop@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

> -----Original Message-----
> From: Philippe Proulx <eeppeliteloop@gmail.com>
> Sent: Wednesday, July 22, 2020 4:57 PM
> To: Kim, Seongab <Seongab.Kim@harman.com>
> Cc: lttng-dev@lists.lttng.org
> Subject: [EXTERNAL] Re: [lttng-dev] difference of timestamp between
> babeltrace and python binding
> 
> `type(1e3)` is `float`.
> 
> You get an inaccurate floating point division operation here instead of an
> integral one.
> 
> Do:
> 
>     ns_from_origin % 1000
> 
> or
> 
>     ns_from_origin % int(1e3)
> 
> instead.
> 
> Hope this helps,
> 
> Phil
> 

Hi Phil,

Thanks. With the change, it works as expected.

Best regards,
Seongab
