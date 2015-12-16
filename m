From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Minor doc comment
Date: Wed, 16 Dec 2015 18:51:32 -0500
Message-ID: <CAB4xu_3JjY8ZgOr8DUwf6O+LNfdurVoRACmfTh7SFy8YF8eTtg__15169.3275933669$1450309998$gmane$org@mail.gmail.com>
References: <86064E213FDE854885686AF0C4584029A956A00C67@ONWVEXCHMB02.ciena.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-lf0-f54.google.com ([209.85.215.54])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1a9Lrb-0006Da-NY
 for lttng-dev@lists.lttng.org; Wed, 16 Dec 2015 18:52:13 -0500
Received: by mail-lf0-f54.google.com with SMTP id p203so41180948lfa.0
 for <lttng-dev@lists.lttng.org>; Wed, 16 Dec 2015 15:52:07 -0800 (PST)
In-Reply-To: <86064E213FDE854885686AF0C4584029A956A00C67@ONWVEXCHMB02.ciena.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "Tetreault, Francois" <ftetreau@ciena.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Wed, Dec 16, 2015 at 5:50 PM, Tetreault, Francois <ftetreau@ciena.com> wrote:
> A few people commented that it is annoying to have the coding examples all
> on one line in the documentation.
>
>
>
> For example, under https://lttng.org/docs/#doc-tracepoint-provider, tp.h is
> all one line.
>
>
>
> Although minor, it would be great if it could get fixed.

This was definitely a bug which was introduced recently when upgrading our
internal site generator tool.

Fixed now, thanks for reporting.

Phil

>
>
>
> Thanks,
>
> Francois
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
