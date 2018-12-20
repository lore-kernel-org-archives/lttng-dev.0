From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: TP_ARGS for TRACEPOINT_EVENT_CLASS and
 TRACEPOINT_EVENT_INSTANCE
Date: Thu, 20 Dec 2018 11:55:49 -0500
Message-ID: <CAB4xu_0JxAfA9QtU-NHgtoTOh6c_eT+zQPBvXNr_HZgKE6GvWA__43829.9235342585$1545324860$gmane$org@mail.gmail.com>
References: <CACJEY862Ytj85N+sidwaq1JEQ+FCiAFo7x5JGuTb992mUrYkdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com
 [IPv6:2607:f8b0:4864:20::82d])
 by lists.lttng.org (Postfix) with ESMTPS id 43LHw139C7z16JP
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 11:56:17 -0500 (EST)
Received: by mail-qt1-x82d.google.com with SMTP id l12so2537023qtf.8
 for <lttng-dev@lists.lttng.org>; Thu, 20 Dec 2018 08:56:17 -0800 (PST)
In-Reply-To: <CACJEY862Ytj85N+sidwaq1JEQ+FCiAFo7x5JGuTb992mUrYkdg@mail.gmail.com>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>
To: Yonghong Yan <yanyh15@gmail.com>
Cc: lttng-dev <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Thu, Dec 20, 2018 at 11:47 AM Yonghong Yan <yanyh15@gmail.com> wrote:
>
> I am looking at the following example from lttng-ust manual. The same TP_ARGS ( ... ) are repeated in both the TRACEPOINT_EVENT_CLASS and TRACEPOINT_EVENT_INSTANCE definition. My understanding is that it actually allows using different arguments, even in this example it is the same. Am I right?

No it does not: they need to match.

See <https://github.com/lttng/lttng-ust/commit/c75c0422c64f33c0102e1778cecc812c58b700e5>.

Phil

>
> I also like the feature of having one TP_ARGS in the TRACEPOINT_EVENT_CLASS that declares the arguments for several TRACEPOINT_EVENT_INSTANCE so we do not need to have TP_ARGS in TRACEPOINT_EVENT_INSTANCE. Is that possible?
>
> Thank you
> Yonghong
>
> TRACEPOINT_EVENT_CLASS(
>     my_provider,
>     my_tracepoint_class,
>     TP_ARGS(
>         int, my_integer_arg,
>         struct app_struct *, app_struct_arg
>     ),
>     TP_FIELDS(
>         ctf_integer(int, a, my_integer_arg)
>         ctf_integer(unsigned long, b, app_struct_arg->b)
>         ctf_string(c, app_struct_arg->c)
>     )
> )
>
> TRACEPOINT_EVENT_INSTANCE(
>     my_provider,
>     my_tracepoint_class,
>     event_instance1,
>     TP_ARGS(
>         int, my_integer_arg,
>         struct app_struct *, app_struct_arg
>     )
> )
>
> TRACEPOINT_EVENT_INSTANCE(
>     my_provider,
>     my_tracepoint_class,
>     event_instance2,
>     TP_ARGS(
>         int, my_integer_arg,
>         struct app_struct *, app_struct_arg
>     )
> )
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
