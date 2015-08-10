From: Philippe Proulx <eeppeliteloop@gmail.com>
Subject: Re: Using LLTNG within shared library (not dlopen-ed).
Date: Mon, 10 Aug 2015 15:52:08 -0400
Message-ID: <CAB4xu_0p4cHO4Wtnn4DNNM_8iwVk7U_nNfu=PpNtsLDy-Ob03A__22699.5308105417$1439236414$gmane$org@mail.gmail.com>
References: <CAAeL1MGw9i1yHyxpAfJOq++zsNYM7+-_aJDAh2yN1B9k9K3U0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f47.google.com ([209.85.215.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eeppeliteloop@gmail.com>) id 1ZOt7j-0001vE-Bd
 for lttng-dev@lists.lttng.org; Mon, 10 Aug 2015 15:52:46 -0400
Received: by lagz9 with SMTP id z9so59519559lag.3
 for <lttng-dev@lists.lttng.org>; Mon, 10 Aug 2015 12:52:37 -0700 (PDT)
In-Reply-To: <CAAeL1MGw9i1yHyxpAfJOq++zsNYM7+-_aJDAh2yN1B9k9K3U0w@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Sergei Dyshel <qyron.private@gmail.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On Mon, Aug 10, 2015 at 1:27 PM, Sergei Dyshel <qyron.private@gmail.com> wrote:
> Hi all,
>
> I have some code using traces compiled as shared object (together with trace
> provider).
> This ".so" is linked to main code during compile-time.
> When I run main application and try to read traces after that I get errors
> about corrupted trace file.
>
> I've read docs about dynamical linking of trace provider which recommends
> compiling trace provider into separate .so and using LD_PRELOAD to preload
> it. But that is only needed for shared objects loaded with "dlopen". In my
> case "dlclose" isn't called and shared object is unloaded on the exit (i.e.
> after all traces produced).
>
> So this shouldn't be a problem... Am I right?

Hello there,

See if this thread helps:
<http://lists.lttng.org/pipermail/lttng-dev/2014-December/023953.html>.

I'm not the author of LTTng-UST and I do not have a comprehensive understanding
of its inner mechanics, but I believe that it's good practice to always use
LD_PRELOAD with a tracepoint provider that is not statically linked with the
application.

Phil

> --
> Regards,
> Sergei Dyshel
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
