From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
Subject: Re: querying bt_ctf_integer_base via babeltrace 1.x
Date: Tue, 30 Apr 2019 11:35:26 -0400
Message-ID: <20190430153526.GB4050__23294.3094497145$1556638550$gmane$org@joraj-alpa>
References: <1815586.uKBcaixokJ@milian-kdab2>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.138])
 by lists.lttng.org (Postfix) with ESMTPS id 44tlwQ0vy0z1KF8
 for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2019 11:35:33 -0400 (EDT)
Received: from localhost (ip6-localhost [IPv6:::1])
 by mail.efficios.com (Postfix) with ESMTP id 3235EAF8AC
 for <lttng-dev@lists.lttng.org>; Tue, 30 Apr 2019 11:35:27 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1815586.uKBcaixokJ@milian-kdab2>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Milian Wolff <milian.wolff@kdab.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

Hi Milian,

On Tue, Apr 30, 2019 at 05:16:44PM +0200, Milian Wolff via lttng-dev wrote:
> Hey all,
> 
> apparently it's not possible to query the integer base via babeltrace 1.x. 
> There is only `bt_ctf_integer_base` in `ctf-ir/field-types.h`, and there it's 
> only used for `bt_ctf_field_type_integer_set_base`. Apparently, there is no 
> equivalent getter for it.

Our current bandwidth is focused on Babeltrace 2. I know that we have
been saying that for a long time but sometime things are just more complicated
than planned.

Still, I encourage you to propose a patch for this. It will lower the effort
necessary on our side.

Cheers

> 
> Can one be added please?
> 
> Thanks
> -- 
> Milian Wolff | milian.wolff@kdab.com | Senior Software Engineer
> KDAB (Deutschland) GmbH, a KDAB Group company
> Tel: +49-30-521325470
> KDAB - The Qt, C++ and OpenGL Experts



> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev


-- 
Jonathan Rajotte-Julien
EfficiOS
