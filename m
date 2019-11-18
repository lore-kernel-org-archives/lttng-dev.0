From: Simon Marchi <simon.marchi@efficios.com>
Subject: Re: [PATCH 1/2] doc: pass AR when building examples
Date: Mon, 18 Nov 2019 12:22:17 -0500
Message-ID: <aa86c04c-1fee-faeb-cc65-e08b1320eb1e__7046.33207512728$1574097757$gmane$org@efficios.com>
References: <20191118170751.32002-1-simon.marchi@efficios.com>
 <1946779199.696.1574097311078.JavaMail.zimbra@efficios.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com
 [IPv6:2607:5300:60:7898::beef])
 by lists.lttng.org (Postfix) with ESMTPS id 47GwkL71q6zsdF
 for <lttng-dev@lists.lttng.org>; Mon, 18 Nov 2019 12:22:18 -0500 (EST)
In-Reply-To: <1946779199.696.1574097311078.JavaMail.zimbra@efficios.com>
Content-Language: tl
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>, Rolf Eike Beer <eb@emlix.com>
List-Id: lttng-dev@lists.lttng.org

On 2019-11-18 12:15 p.m., Mathieu Desnoyers wrote:
> Both patches merged into lttng-ust master branch (only).
> 
> If you need those backported, please submit separate patches for stable
> branches, as those do not apply cleanly because the following commit is
> in master but not in stable branches:
> 
> commit dc5af9e3311ab28f2728f540f06e61add9d7b5eb
> Author: Michael Jeanson <mjeanson@efficios.com>
> Date:   Thu Dec 20 15:22:42 2018 -0500
> 
>     Add silent mode to examples Makefiles
> 
> Thanks,
> 
> Mathieu

Thanks.

I don't think this is really needed in the stable branches, as it's a really minor
change in the examples.

Simon
