From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: default sub-buf size and count
Date: Wed, 8 May 2019 13:12:50 -0400
Message-ID: <20190508171250.GA14627__28730.8237094962$1557335591$gmane$org@joraj-alpa>
References: <CAJyWpKEO5i2MHZpvQQmtctzbFfuTCP9AvjmPAhQsa3yf9tKPhg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44zjj266G6z1K03
 for <lttng-dev@lists.lttng.org>; Wed,  8 May 2019 13:12:54 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 13DC31E1F79
 for <lttng-dev@lists.lttng.org>; Wed,  8 May 2019 13:12:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAJyWpKEO5i2MHZpvQQmtctzbFfuTCP9AvjmPAhQsa3yf9tKPhg@mail.gmail.com>
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

Hi,

On Tue, May 07, 2019 at 05:08:33PM -0400, Mosleh Uddin wrote:
> Hello,
> 
> I was just wondering what the default values for the sub-buffer size and
> the number of sub-buffers are. I attempted to print them out after setting
> the channel with default attr, however both values appear 0.

This information is normally found in the man pages.

man lttng enable-channel, search for --subbuf-size=SIZE

Could you outline the session configuration used so we can see if the fact that
both value are zero is a bug?

Cheers

> 
> Thanks for any insight,
> Mosleh

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Jonathan Rajotte-Julien
EfficiOS
