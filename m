From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: lttng trace" Read trace under windows
Date: Mon, 27 May 2019 10:19:07 -0400
Message-ID: <20190527141907.GB17476__9977.75912271521$1558966771$gmane$org@joraj-alpa>
References: <CABRndgx7zGtAR_7eM8Vb7AorGkS4-2b8z8P5n9rv45-SMhuL0Q@mail.gmail.com>
 <20190521144811.GA1071@joraj-alpa>
 <CABRndgyEo1g+x1=DmTFqWwvZzXVmJUrVCg6kD+=QQfciksLwEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 45CJxw1ZFrz1063
 for <lttng-dev@lists.lttng.org>; Mon, 27 May 2019 10:19:16 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 3F0EA1DAC8D
 for <lttng-dev@lists.lttng.org>; Mon, 27 May 2019 10:19:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABRndgyEo1g+x1=DmTFqWwvZzXVmJUrVCg6kD+=QQfciksLwEw@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Zvi Vered <veredz72@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

On Sun, May 26, 2019 at 05:40:51AM +0300, Zvi Vered wrote:
> Hi Jonathan,
> 
> Thank you very much for your repy.
> 
> Each trace contains also idx files (channel0_0.idx ... channel0_7.idx).
> Are those also CTF files ?

The index files are not part of the 1.8 spec. They are utility files for the
reader. These files are optionals.

Please see src/common/index/ [1] in the lttng-tools tree if you want do
dig further.

[1] https://github.com/lttng/lttng-tools/blob/master/src/common/index

> 
> Is "metadata" a CTF file also ?

https://diamon.org/ctf/#spec7.1

It represent a metadata stream.

Cheers

-- 
Jonathan Rajotte-Julien
EfficiOS
