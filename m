Return-Path: <SRS0=QVU9=JE=lists.lttng.org=lttng-dev-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,MIME_HTML_MOSTLY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686B8C433ED
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Apr 2021 16:05:04 +0000 (UTC)
Received: from lists.lttng.org (lists.lttng.org [167.114.26.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AE8F61279
	for <lttng-dev@archiver.kernel.org>; Wed,  7 Apr 2021 16:05:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AE8F61279
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.lttng.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lttng-dev-bounces@lists.lttng.org
Received: from lists-lttng01.efficios.com (localhost [IPv6:::1])
	by lists.lttng.org (Postfix) with ESMTP id 4FFq3d5h71z14fV;
	Wed,  7 Apr 2021 12:05:01 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.lttng.org;
	s=default; t=1617811502;
	bh=AXBz5fSSDdu6a8MREv260jzNyMAdhygLxtf1T5eYEMI=;
	h=References:In-Reply-To:Date:To:Subject:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:From:Reply-To:
	 From;
	b=nfOfOsOh2qjs17+38fsifw0nNo+3w/uaX7BD0+sTqJo1FYrNpBPyKS061lJuaQlG/
	 U+As1Vlq+5JbsvKAK6IAMeVXevEVExqpKTfjX9qWxLmPj/g4T03TtpoF4HBSglsAih
	 BRHB1YQf7zGzZa1tENSeCXI1T4JFuagyvrsNxF4mHOcAnG2MTGtYFp+rygCi22Oage
	 oQhd8ZWW9HDfdXbajNnkDGSzJzNuwpmjaOSmG3YSB+V0wwzvt+++qdf/qitz+pxEfU
	 VNfVZJzKv3cbUk3dw1OmBNjOBER4YQhLh0ceP858K4uaGiLMAOSIN0Yu+QAw62aJXI
	 /p77w0Z3ZcvdA==
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 by lists.lttng.org (Postfix) with ESMTPS id 4FFq3c3Jg1z14Md
 for <lttng-dev@lists.lttng.org>; Wed,  7 Apr 2021 12:05:00 -0400 (EDT)
Received: by mail-lf1-x12d.google.com with SMTP id o126so29466325lfa.0
 for <lttng-dev@lists.lttng.org>; Wed, 07 Apr 2021 09:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=hH2gQ8nkwr6pgP7LwF81OOI3l/xWBCJb+4Ibdx89GJs=;
 b=bxQ1RdwPsSsRoBvDXImnKL2DrADpfuw8HvZJYYqrNsuKJjTwfzD72XIxc+HClxCETA
 j3t8fp6F6ym15Xt2Yf/JfazJUjHBihkk9RG0v1Ed4LQsiO/Y14Pf5BI3kSU2h2aubAn0
 5Wt6AAxQWpTQgwttFy5A5LZUy/D9+c3POXtnwwKK5r2SsOx6+6aESquw1plXG2cKpOnc
 ky5pT9EkdLyhq6WIjvyuzzygKbV4BJ98tLuooBguDkpi9V29HKazrr/98b/6T6mEiQQu
 5CwtLO5gOT3dHlMPrn39IMLywelaDiam0rv6zV0EmYHHN2XUO+KUB5Da7y6qaQ+inBkf
 55aQ==
X-Gm-Message-State: AOAM530TGxdUNhMZ/1Y/uKeqjEWtF93SaOHUfKmfB5ukJuh0xmwr3DqX
 GgE4eSE4971mgKX9qIlvc5m4IMTxYau2nXa2Wz8k6E3bUVs=
X-Google-Smtp-Source: ABdhPJwjpr63VjDf2EiQ4ITnyXuhaIMnBp706GNpGMVpeqBXV7tU/w28JuJkf1sCOX61DGx9EI9fNBk2m5zP13s3oko=
X-Received: by 2002:a19:b4b:: with SMTP id 72mr3101961lfl.602.1617811497164;
 Wed, 07 Apr 2021 09:04:57 -0700 (PDT)
MIME-Version: 1.0
References: <mailman.1.1617811201.6072.lttng-dev@lists.lttng.org>
In-Reply-To: <mailman.1.1617811201.6072.lttng-dev@lists.lttng.org>
Date: Wed, 7 Apr 2021 11:04:20 -0500
Message-ID: <CAFGSPrzyaDpapFzhjzDvR9NdPc1xC7M5WC_qdm5x_jwnBkSLPQ@mail.gmail.com>
To: lttng-dev@lists.lttng.org
Subject: Re: [lttng-dev] lttng-dev Digest, Vol 156, Issue 8
X-BeenThere: lttng-dev@lists.lttng.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: LTTng development list <lttng-dev.lists.lttng.org>
List-Unsubscribe: <https://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <https://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>, 
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
From: Ramesh Errabolu via lttng-dev <lttng-dev@lists.lttng.org>
Reply-To: Ramesh Errabolu <ramesh.errabolu@gmail.com>
Content-Type: multipart/mixed; boundary="===============6526846104558368044=="
Errors-To: lttng-dev-bounces@lists.lttng.org
Sender: "lttng-dev" <lttng-dev-bounces@lists.lttng.org>

--===============6526846104558368044==
Content-Type: multipart/alternative; boundary="0000000000009a22f305bf641725"

--0000000000009a22f305bf641725
Content-Type: text/plain; charset="UTF-8"

Is there a dummy test application and libraries one can download and build.
I could then validate my setup against it.

Regards,
Ramesh


On Wed, Apr 7, 2021 at 11:00 AM <lttng-dev-request@lists.lttng.org> wrote:

> Send lttng-dev mailing list submissions to
>         lttng-dev@lists.lttng.org
>
> To subscribe or unsubscribe via the World Wide Web, visit
>         https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> or, via email, send a message with subject or body 'help' to
>         lttng-dev-request@lists.lttng.org
>
> You can reach the person managing the list at
>         lttng-dev-owner@lists.lttng.org
>
> When replying, please edit your Subject line so it is more specific
> than "Re: Contents of lttng-dev digest..."
>
>
> Today's Topics:
>
>    1. Re: lttng-dev Digest, Vol 156, Issue 3 (Jonathan Rajotte-Julien)
>    2. Re: lttng-dev Digest, Vol 156, Issue 3 (Ramesh Errabolu)
>    3. Re: [PATCH lttng-tools] testapp: gen-ust-events: added help
>       and sync-before-first-event (Mathieu Desnoyers)
>    4. Re: [PATCH lttng-tools] Fix: test code assumes that child
>       process is schedule to run before parent (Mathieu Desnoyers)
>
>
> ----------------------------------------------------------------------
>
> Message: 1
> Date: Tue, 6 Apr 2021 19:46:21 -0400
> From: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
> To: Ramesh Errabolu <ramesh.errabolu@gmail.com>
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] lttng-dev Digest, Vol 156, Issue 3
> Message-ID: <20210406234621.GA913141@joraj-alpa>
> Content-Type: text/plain; charset=us-ascii
>
> > I followed your command sequence and noticed a bunch of files being
> > created. However when I tried to run babeltrace on these outputs I don't
> > see any of the functions that should have been called.  Including below
> the
> > search for symbols.
>
> At least userspace tracing seems to work.
>
> I would recommended, again, that you first try tracing on a dummy
> application, a
> really simple one. Then move to the usage of cyg_profile on that dummy app
> then
> to your application.
>
> The cyg profile events are the following:
>
>   lttng_ust_cyg_profile_fast:func_entry
>   lttng_ust_cyg_profile_fast:func_exit
>
> and, when using liblttng-ust-cyg-profile.so:
>
>   lttng_ust_cyg_profile:func_entry
>   lttng_ust_cyg_profile:func_exit
>
> I would recommend that you first start grep-ing (lttng_ust_cyg) for this
> in the
> trace to see if any is getting hit and recorded. If it is not the case,
> take a
> step back try with a dummy app and if nothing works with the dummy app we
> can at
> least try to help you from there and remove all other variable since you
> will be
> able to share the dummy app with us.
>
> Cheers
>
>
> ------------------------------
>
> Message: 2
> Date: Tue, 6 Apr 2021 18:56:39 -0500
> From: Ramesh Errabolu <ramesh.errabolu@gmail.com>
> To: Jonathan Rajotte-Julien <jonathan.rajotte-julien@efficios.com>
> Cc: lttng-dev@lists.lttng.org
> Subject: Re: [lttng-dev] lttng-dev Digest, Vol 156, Issue 3
> Message-ID:
>         <
> CAFGSPrwnihLeY_CQm8jYb9B0R2RT52U2SaPeVLVSDsqCyxYKSQ@mail.gmail.com>
> Content-Type: text/plain; charset="utf-8"
>
> Will try the dummy app to check if the basic setup is good. Wondering if
> being able to trace shared libraries is something not supported.
>
> Regards,
> Ramesh
>
>
> On Tue, Apr 6, 2021 at 6:46 PM Jonathan Rajotte-Julien <
> jonathan.rajotte-julien@efficios.com> wrote:
>
> > > I followed your command sequence and noticed a bunch of files being
> > > created. However when I tried to run babeltrace on these outputs I
> don't
> > > see any of the functions that should have been called.  Including below
> > the
> > > search for symbols.
> >
> > At least userspace tracing seems to work.
> >
> > I would recommended, again, that you first try tracing on a dummy
> > application, a
> > really simple one. Then move to the usage of cyg_profile on that dummy
> app
> > then
> > to your application.
> >
> > The cyg profile events are the following:
> >
> >   lttng_ust_cyg_profile_fast:func_entry
> >   lttng_ust_cyg_profile_fast:func_exit
> >
> > and, when using liblttng-ust-cyg-profile.so:
> >
> >   lttng_ust_cyg_profile:func_entry
> >   lttng_ust_cyg_profile:func_exit
> >
> > I would recommend that you first start grep-ing (lttng_ust_cyg) for this
> > in the
> > trace to see if any is getting hit and recorded. If it is not the case,
> > take a
> > step back try with a dummy app and if nothing works with the dummy app we
> > can at
> > least try to help you from there and remove all other variable since you
> > will be
> > able to share the dummy app with us.
> >
> > Cheers
> >
> -------------- next part --------------
> An HTML attachment was scrubbed...
> URL: <
> https://lists.lttng.org/pipermail/lttng-dev/attachments/20210406/f3c5c020/attachment-0001.htm
> >
>
> ------------------------------
>
> Message: 3
> Date: Wed, 7 Apr 2021 11:29:48 -0400 (EDT)
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: Anders Wallin <wallinux@gmail.com>
> Cc: lttng-dev <lttng-dev@lists.lttng.org>
> Subject: Re: [lttng-dev] [PATCH lttng-tools] testapp: gen-ust-events:
>         added help and sync-before-first-event
> Message-ID:
>         <760733085.60423.1617809388155.JavaMail.zimbra@efficios.com>
> Content-Type: text/plain; charset=utf-8
>
> ----- On Apr 1, 2021, at 12:36 PM, lttng-dev lttng-dev@lists.lttng.org
> wrote:
>
> > - added verbose option to print traces
> > - added sync-before-first-event to wait on file before first event
> > - added help option
> > - added missing short option "-e"
> > - don't allow negative wait times
>
> I don't think this is needed. Will explain in the next patch.
>
> Thanks,
>
> Mathieu
>
> >
> > Signed-off-by: Anders Wallin <wallinux@gmail.com>
> > ---
> > .../testapp/gen-ust-events/gen-ust-events.c   | 95 ++++++++++++++++---
> > 1 file changed, 82 insertions(+), 13 deletions(-)
> >
> > diff --git a/tests/utils/testapp/gen-ust-events/gen-ust-events.c
> > b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
> > index df1e58e4..5fefb2d8 100644
> > --- a/tests/utils/testapp/gen-ust-events/gen-ust-events.c
> > +++ b/tests/utils/testapp/gen-ust-events/gen-ust-events.c
> > @@ -28,6 +28,15 @@
> > #define TRACEPOINT_DEFINE
> > #include "tp.h"
> >
> > +/* #define NDEBUG */
> > +
> > +#ifndef NDEBUG
> > +int verbose;
> > +#define TRACE(format, ...) { if (verbose) printf(" ---TRACE: " format,
> > __VA_ARGS__); }
> > +#else
> > +#define TRACE(format, ...)
> > +#endif
> > +
> > static struct option long_options[] =
> > {
> >       /* These options set a flag. */
> > @@ -38,9 +47,33 @@ static struct option long_options[] =
> >       {"sync-before-last-event-touch", required_argument, 0, 'c'},
> >       {"sync-before-exit", required_argument, 0, 'd'},
> >       {"sync-before-exit-touch", required_argument, 0, 'e'},
> > +     {"sync-before-first-event", required_argument, 0, 'f'},
> > +     {"help", no_argument, 0, 'h'},
> > +#ifndef NDEBUG
> > +     {"verbose", no_argument, 0, 'v'},
> > +#endif
> >       {0, 0, 0, 0}
> > };
> >
> > +const char *program_name;
> > +
> > +static void print_usage(void)
> > +{
> > +     printf("Usage:  %s options\n", program_name);
> > +     printf("  -h  --help                                    Display
> this usage
> > information\n"
> > +#ifndef NDEBUG
> > +            "  -v  --verbose                                 Print
> verbose
> > messages\n"
> > +#endif
> > +            "  -i  --iter [iterations]                       Number of
> iterations,
> > default=100, forever=-1\n"
> > +            "  -w  --wait [usec]                             Time in
> usec between
> > events, default=0\n"
> > +            "  -a  --sync-after-first-event [filename]       Create
> file after
> > first event\n"
> > +            "  -b  --sync-before-last-event [filename]       Wait for
> file before
> > writing last event\n"
> > +            "  -c  --sync-before-last-event-touch [filename] Create
> file after last
> > event\n"
> > +            "  -d  --sync-before-exit [filename]             Wait for
> file before
> > exit\n"
> > +            "  -e  --sync-before-exit-touch [filename]       Create
> file before
> > exit\n"
> > +            "  -f  --sync-before-first-event [filename]      Wait for
> file before
> > creating the first event\n");
> > +}
> > +
> > int main(int argc, char **argv)
> > {
> >       unsigned int i, netint;
> > @@ -54,7 +87,7 @@ int main(int argc, char **argv)
> >       uint32_t net_values[] = { 1, 2, 3 };
> >       int nr_iter = 100, ret = 0, first_event_file_created = 0;
> >       useconds_t nr_usec = 0;
> > -     char *after_first_event_file_path = NULL;
> > +     char *after_first_event_file_path_touch = NULL;
> >       char *before_last_event_file_path = NULL;
> >       /*
> >        * Touch a file to indicate that all events except one were
> > @@ -65,16 +98,20 @@ int main(int argc, char **argv)
> >       char *before_exit_file_path_touch = NULL;
> >       /* Wait on file before exiting */
> >       char *before_exit_file_path = NULL;
> > +     /* Wait on file before starting */
> > +     char *before_first_event_file_path = NULL;
> > +
> > +     program_name = argv[0];
> >
> >       for (i = 0; i < 3; i++) {
> >               net_values[i] = htonl(net_values[i]);
> >       }
> >
> > -     while ((option = getopt_long(argc, argv, "i:w:a:b:c:d:",
> > +     while ((option = getopt_long(argc, argv, "i:w:a:b:c:d:e:f:hv",
> >                       long_options, &option_index)) != -1) {
> >               switch (option) {
> >               case 'a':
> > -                     after_first_event_file_path = strdup(optarg);
> > +                     after_first_event_file_path_touch = strdup(optarg);
> >                       break;
> >               case 'b':
> >                       before_last_event_file_path = strdup(optarg);
> > @@ -88,22 +125,30 @@ int main(int argc, char **argv)
> >               case 'e':
> >                       before_exit_file_path_touch = strdup(optarg);
> >                       break;
> > +             case 'f':
> > +                     before_first_event_file_path = strdup(optarg);
> > +                     break;
> >               case 'i':
> >                       nr_iter = atoi(optarg);
> >                       break;
> > +#ifndef NDEBUG
> > +             case 'v':
> > +                     verbose = 1;
> > +                     break;
> > +#endif
> >               case 'w':
> > -                     nr_usec = atoi(optarg);
> > +                     /* only postive values are valid */
> > +                     nr_usec = (atoi(optarg) < 0) ? 0 : atoi(optarg);
> >                       break;
> > -             case '?':
> > -                     /* getopt_long already printed an error message. */
> > +             case 'h':
> >               default:
> > -                     ret = -1;
> > +                     print_usage();
> >                       goto end;
> >               }
> >       }
> >
> >       if (optind != argc) {
> > -             fprintf(stderr, "Error: takes long options only.\n");
> > +             fprintf(stderr, "Error: takes options only.\n");
> >
> >               /*
> >                * Aborting the test program for now because callers
> typically don't check
> > @@ -113,6 +158,7 @@ int main(int argc, char **argv)
> >                * we should eventually ensure that all scripts test and
> report the test
> >                * app return values.
> >                */
> > +             print_usage();
> >               abort();
> >
> >               ret = -1;
> > @@ -125,9 +171,23 @@ int main(int argc, char **argv)
> >               goto end;
> >       }
> >
> > +     TRACE("iter: %i\n", nr_iter);
> > +     TRACE("wait: %i (usec)\n", nr_usec);
> > +
> > +     if (before_first_event_file_path) {
> > +             TRACE("before_first_event_file_path(%i): %s\n",
> > +                   -1, before_first_event_file_path);
> > +             ret = wait_on_file(before_first_event_file_path);
> > +             if (ret != 0) {
> > +                     goto end;
> > +             }
> > +     }
> > +
> >       for (i = 0; nr_iter < 0 || i < nr_iter; i++) {
> >               if (nr_iter >= 0 && i == nr_iter - 1) {
> >                       if (before_last_event_file_path_touch) {
> > +
>  TRACE("before_last_event_file_path_touch(%i): %s\n",
> > +                                   i,
> before_last_event_file_path_touch);
> >                               ret =
> create_file(before_last_event_file_path_touch);
> >                               if (ret != 0) {
> >                                       goto end;
> > @@ -139,6 +199,8 @@ int main(int argc, char **argv)
> >                        * event.
> >                        */
> >                       if (before_last_event_file_path) {
> > +                             TRACE("before_last_event_file_path(%i):
> %s\n",
> > +                                   i, before_last_event_file_path);
> >                               ret =
> wait_on_file(before_last_event_file_path);
> >                               if (ret != 0) {
> >                                       goto end;
> > @@ -153,9 +215,10 @@ int main(int argc, char **argv)
> >                * First loop we create the file if asked to indicate
> >                * that at least one tracepoint has been hit.
> >                */
> > -             if (after_first_event_file_path &&
> first_event_file_created == 0) {
> > -                     ret = create_file(after_first_event_file_path);
> > -
> > +             if (after_first_event_file_path_touch &&
> first_event_file_created == 0) {
> > +                     TRACE("after_first_event_file_path_touch(%i):
> %s\n",
> > +                           i, after_first_event_file_path_touch);
> > +                     ret =
> create_file(after_first_event_file_path_touch);
> >                       if (ret != 0) {
> >                               goto end;
> >                       } else {
> > @@ -164,7 +227,7 @@ int main(int argc, char **argv)
> >               }
> >
> >               if (nr_usec) {
> > -                     if (usleep_safe(nr_usec)) {
> > +                     if (usleep_safe(nr_usec)) {
> >                               ret = -1;
> >                               goto end;
> >                       }
> > @@ -175,22 +238,28 @@ int main(int argc, char **argv)
> >       }
> >
> >       if (before_exit_file_path_touch) {
> > +             TRACE("before_exit_file_path_touch(%i): %s\n",
> > +                   i, before_exit_file_path_touch);
> >               ret = create_file(before_exit_file_path_touch);
> >               if (ret != 0) {
> >                       goto end;
> >               }
> >       }
> >       if (before_exit_file_path) {
> > +             TRACE("before_exit_file_path(%i): %s\n",
> > +                   i, before_exit_file_path);
> >               ret = wait_on_file(before_exit_file_path);
> >               if (ret != 0) {
> >                       goto end;
> >               }
> >       }
> > end:
> > -     free(after_first_event_file_path);
> > +     TRACE("end status: %i\n", ret);
> > +     free(after_first_event_file_path_touch);
> >       free(before_last_event_file_path);
> >       free(before_last_event_file_path_touch);
> >       free(before_exit_file_path);
> >       free(before_exit_file_path_touch);
> > +     free(before_first_event_file_path);
> >       exit(!ret ? EXIT_SUCCESS : EXIT_FAILURE);
> > }
> > --
> > 2.31.1
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
>
> ------------------------------
>
> Message: 4
> Date: Wed, 7 Apr 2021 11:31:46 -0400 (EDT)
> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> To: Anders Wallin <wallinux@gmail.com>
> Cc: lttng-dev <lttng-dev@lists.lttng.org>
> Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: test code assumes
>         that child process is schedule to run before parent
> Message-ID:
>         <667805472.60438.1617809506670.JavaMail.zimbra@efficios.com>
> Content-Type: text/plain; charset=utf-8
>
> ----- On Apr 1, 2021, at 12:37 PM, lttng-dev lttng-dev@lists.lttng.org
> wrote:
>
> > the following tests fails
> > - test_event_vpid_tracker ust 0 "${EVENT_NAME}"
> > - test_event_vpid_track_untrack ust 0 "${EVENT_NAME}"
> > - test_event_pid_tracker ust 0 "${EVENT_NAME}"
> > - test_event_pid_track_untrack ust 0 "${EVENT_NAME}"
>
> There is indeed an issue with these tests: there is a missing "untrack all
> pids"
> which should be done at the very beginning of each test to have the
> expected
> behavior. AFAIU this explains why there is a small window where traced
> applications
> can generate events when none are expected.
>
> Fixing this should solve the issues without requiring any addition to the
> test
> program.
>
> Thanks,
>
> Mathieu
>
> >
> > Signed-off-by: Anders Wallin <wallinux@gmail.com>
> > ---
> > tests/regression/tools/tracker/test_event_tracker | 15 ++++++---------
> > 1 file changed, 6 insertions(+), 9 deletions(-)
> >
> > diff --git a/tests/regression/tools/tracker/test_event_tracker
> > b/tests/regression/tools/tracker/test_event_tracker
> > index 711690af..78e9310b 100755
> > --- a/tests/regression/tools/tracker/test_event_tracker
> > +++ b/tests/regression/tools/tracker/test_event_tracker
> > @@ -5,7 +5,7 @@
> > #
> > # SPDX-License-Identifier: GPL-2.0-only
> >
> > -TEST_DESC="LTTng - Event traker test"
> > +TEST_DESC="LTTng - Event tracker test"
> >
> > CURDIR=$(dirname "$0")/
> > TESTDIR="$CURDIR/../../.."
> > @@ -30,27 +30,24 @@ SCRIPT_GROUPNAME="$(id -gn)"
> >
> > CHILD_PID=-1
> > WAIT_PATH=
> > -AFTER_FIRST_PATH=
> > -BEFORE_LAST_PATH=
> > +BEFORE_FIRST_PATH=
> >
> > source $TESTDIR/utils/utils.sh
> >
> > function prepare_ust_app
> > {
> > -     AFTER_FIRST_PATH=$(mktemp -u)
> > -     BEFORE_LAST_PATH=$(mktemp -u)
> > +     BEFORE_FIRST_PATH=$(mktemp -u)
> >
> > -     $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a "$AFTER_FIRST_PATH" -b
> > "$BEFORE_LAST_PATH" &
> > +     $TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT --sync-before-first-event
> > "$BEFORE_FIRST_PATH" &
> >       CHILD_PID=$!
> > }
> >
> > function trace_ust_app
> > {
> > -     touch "$BEFORE_LAST_PATH"
> > +     touch "$BEFORE_FIRST_PATH"
> >       wait
> >       ok $? "Traced application stopped."
> > -     rm "$BEFORE_LAST_PATH"
> > -     rm "$AFTER_FIRST_PATH"
> > +     rm "$BEFORE_FIRST_PATH"
> > }
> >
> > function prepare_kernel_app
> > --
> > 2.31.1
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
>
> ------------------------------
>
> Subject: Digest Footer
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>
> ------------------------------
>
> End of lttng-dev Digest, Vol 156, Issue 8
> *****************************************
>

--0000000000009a22f305bf641725
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Is there a dummy test application=C2=A0and libraries one can do=
wnload and build. I could then validate my setup against it.</div><div clas=
s=3D"gmail_default" style=3D"font-family:verdana,sans-serif"><br></div><div=
><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_signatu=
re">Regards,<div>Ramesh</div></div></div><br></div><br><div class=3D"gmail_=
quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Apr 7, 2021 at 11:00 A=
M &lt;<a href=3D"mailto:lttng-dev-request@lists.lttng.org">lttng-dev-reques=
t@lists.lttng.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote"=
 style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);p=
adding-left:1ex">Send lttng-dev mailing list submissions to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev@lists.lttng.org" ta=
rget=3D"_blank">lttng-dev@lists.lttng.org</a><br>
<br>
To subscribe or unsubscribe via the World Wide Web, visit<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"https://lists.lttng.org/cgi-bin/mail=
man/listinfo/lttng-dev" rel=3D"noreferrer" target=3D"_blank">https://lists.=
lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><br>
or, via email, send a message with subject or body &#39;help&#39; to<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev-request@lists.lttng=
.org" target=3D"_blank">lttng-dev-request@lists.lttng.org</a><br>
<br>
You can reach the person managing the list at<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:lttng-dev-owner@lists.lttng.o=
rg" target=3D"_blank">lttng-dev-owner@lists.lttng.org</a><br>
<br>
When replying, please edit your Subject line so it is more specific<br>
than &quot;Re: Contents of lttng-dev digest...&quot;<br>
<br>
<br>
Today&#39;s Topics:<br>
<br>
=C2=A0 =C2=A01. Re: lttng-dev Digest, Vol 156, Issue 3 (Jonathan Rajotte-Ju=
lien)<br>
=C2=A0 =C2=A02. Re: lttng-dev Digest, Vol 156, Issue 3 (Ramesh Errabolu)<br=
>
=C2=A0 =C2=A03. Re: [PATCH lttng-tools] testapp: gen-ust-events: added help=
<br>
=C2=A0 =C2=A0 =C2=A0 and sync-before-first-event (Mathieu Desnoyers)<br>
=C2=A0 =C2=A04. Re: [PATCH lttng-tools] Fix: test code assumes that child<b=
r>
=C2=A0 =C2=A0 =C2=A0 process is schedule to run before parent (Mathieu Desn=
oyers)<br>
<br>
<br>
----------------------------------------------------------------------<br>
<br>
Message: 1<br>
Date: Tue, 6 Apr 2021 19:46:21 -0400<br>
From: Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien=
@efficios.com" target=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&g=
t;<br>
To: Ramesh Errabolu &lt;<a href=3D"mailto:ramesh.errabolu@gmail.com" target=
=3D"_blank">ramesh.errabolu@gmail.com</a>&gt;<br>
Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br>
Subject: Re: [lttng-dev] lttng-dev Digest, Vol 156, Issue 3<br>
Message-ID: &lt;20210406234621.GA913141@joraj-alpa&gt;<br>
Content-Type: text/plain; charset=3Dus-ascii<br>
<br>
&gt; I followed your command sequence and noticed a bunch of files being<br=
>
&gt; created. However when I tried to run babeltrace on these outputs I don=
&#39;t<br>
&gt; see any of the functions that should have been called.=C2=A0 Including=
 below the<br>
&gt; search for symbols.<br>
<br>
At least userspace tracing seems to work.<br>
<br>
I would recommended, again, that you first try tracing on a dummy applicati=
on, a<br>
really simple one. Then move to the usage of cyg_profile on that dummy app =
then<br>
to your application.<br>
<br>
The cyg profile events are the following:<br>
<br>
=C2=A0 lttng_ust_cyg_profile_fast:func_entry<br>
=C2=A0 lttng_ust_cyg_profile_fast:func_exit<br>
<br>
and, when using liblttng-ust-cyg-profile.so:<br>
<br>
=C2=A0 lttng_ust_cyg_profile:func_entry<br>
=C2=A0 lttng_ust_cyg_profile:func_exit<br>
<br>
I would recommend that you first start grep-ing (lttng_ust_cyg) for this in=
 the<br>
trace to see if any is getting hit and recorded. If it is not the case, tak=
e a<br>
step back try with a dummy app and if nothing works with the dummy app we c=
an at<br>
least try to help you from there and remove all other variable since you wi=
ll be<br>
able to share the dummy app with us.<br>
<br>
Cheers<br>
<br>
<br>
------------------------------<br>
<br>
Message: 2<br>
Date: Tue, 6 Apr 2021 18:56:39 -0500<br>
From: Ramesh Errabolu &lt;<a href=3D"mailto:ramesh.errabolu@gmail.com" targ=
et=3D"_blank">ramesh.errabolu@gmail.com</a>&gt;<br>
To: Jonathan Rajotte-Julien &lt;<a href=3D"mailto:jonathan.rajotte-julien@e=
fficios.com" target=3D"_blank">jonathan.rajotte-julien@efficios.com</a>&gt;=
<br>
Cc: <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-de=
v@lists.lttng.org</a><br>
Subject: Re: [lttng-dev] lttng-dev Digest, Vol 156, Issue 3<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:CAFGSPrwnihLeY_CQm8jYb9B0=
R2RT52U2SaPeVLVSDsqCyxYKSQ@mail.gmail.com" target=3D"_blank">CAFGSPrwnihLeY=
_CQm8jYb9B0R2RT52U2SaPeVLVSDsqCyxYKSQ@mail.gmail.com</a>&gt;<br>
Content-Type: text/plain; charset=3D&quot;utf-8&quot;<br>
<br>
Will try the dummy app to check if the basic setup is good. Wondering if<br=
>
being able to trace shared libraries is something not supported.<br>
<br>
Regards,<br>
Ramesh<br>
<br>
<br>
On Tue, Apr 6, 2021 at 6:46 PM Jonathan Rajotte-Julien &lt;<br>
<a href=3D"mailto:jonathan.rajotte-julien@efficios.com" target=3D"_blank">j=
onathan.rajotte-julien@efficios.com</a>&gt; wrote:<br>
<br>
&gt; &gt; I followed your command sequence and noticed a bunch of files bei=
ng<br>
&gt; &gt; created. However when I tried to run babeltrace on these outputs =
I don&#39;t<br>
&gt; &gt; see any of the functions that should have been called.=C2=A0 Incl=
uding below<br>
&gt; the<br>
&gt; &gt; search for symbols.<br>
&gt;<br>
&gt; At least userspace tracing seems to work.<br>
&gt;<br>
&gt; I would recommended, again, that you first try tracing on a dummy<br>
&gt; application, a<br>
&gt; really simple one. Then move to the usage of cyg_profile on that dummy=
 app<br>
&gt; then<br>
&gt; to your application.<br>
&gt;<br>
&gt; The cyg profile events are the following:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0lttng_ust_cyg_profile_fast:func_entry<br>
&gt;=C2=A0 =C2=A0lttng_ust_cyg_profile_fast:func_exit<br>
&gt;<br>
&gt; and, when using liblttng-ust-cyg-profile.so:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0lttng_ust_cyg_profile:func_entry<br>
&gt;=C2=A0 =C2=A0lttng_ust_cyg_profile:func_exit<br>
&gt;<br>
&gt; I would recommend that you first start grep-ing (lttng_ust_cyg) for th=
is<br>
&gt; in the<br>
&gt; trace to see if any is getting hit and recorded. If it is not the case=
,<br>
&gt; take a<br>
&gt; step back try with a dummy app and if nothing works with the dummy app=
 we<br>
&gt; can at<br>
&gt; least try to help you from there and remove all other variable since y=
ou<br>
&gt; will be<br>
&gt; able to share the dummy app with us.<br>
&gt;<br>
&gt; Cheers<br>
&gt;<br>
-------------- next part --------------<br>
An HTML attachment was scrubbed...<br>
URL: &lt;<a href=3D"https://lists.lttng.org/pipermail/lttng-dev/attachments=
/20210406/f3c5c020/attachment-0001.htm" rel=3D"noreferrer" target=3D"_blank=
">https://lists.lttng.org/pipermail/lttng-dev/attachments/20210406/f3c5c020=
/attachment-0001.htm</a>&gt;<br>
<br>
------------------------------<br>
<br>
Message: 3<br>
Date: Wed, 7 Apr 2021 11:29:48 -0400 (EDT)<br>
From: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.co=
m" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
To: Anders Wallin &lt;<a href=3D"mailto:wallinux@gmail.com" target=3D"_blan=
k">wallinux@gmail.com</a>&gt;<br>
Cc: lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_b=
lank">lttng-dev@lists.lttng.org</a>&gt;<br>
Subject: Re: [lttng-dev] [PATCH lttng-tools] testapp: gen-ust-events:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 added help and sync-before-first-event<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:760733085.60423.161780938=
8155.JavaMail.zimbra@efficios.com" target=3D"_blank">760733085.60423.161780=
9388155.JavaMail.zimbra@efficios.com</a>&gt;<br>
Content-Type: text/plain; charset=3Dutf-8<br>
<br>
----- On Apr 1, 2021, at 12:36 PM, lttng-dev <a href=3D"mailto:lttng-dev@li=
sts.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a> wrote:<br>
<br>
&gt; - added verbose option to print traces<br>
&gt; - added sync-before-first-event to wait on file before first event<br>
&gt; - added help option<br>
&gt; - added missing short option &quot;-e&quot;<br>
&gt; - don&#39;t allow negative wait times<br>
<br>
I don&#39;t think this is needed. Will explain in the next patch.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Signed-off-by: Anders Wallin &lt;<a href=3D"mailto:wallinux@gmail.com"=
 target=3D"_blank">wallinux@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; .../testapp/gen-ust-events/gen-ust-events.c=C2=A0 =C2=A0| 95 +++++++++=
+++++++---<br>
&gt; 1 file changed, 82 insertions(+), 13 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/utils/testapp/gen-ust-events/gen-ust-events.c<br>
&gt; b/tests/utils/testapp/gen-ust-events/gen-ust-events.c<br>
&gt; index df1e58e4..5fefb2d8 100644<br>
&gt; --- a/tests/utils/testapp/gen-ust-events/gen-ust-events.c<br>
&gt; +++ b/tests/utils/testapp/gen-ust-events/gen-ust-events.c<br>
&gt; @@ -28,6 +28,15 @@<br>
&gt; #define TRACEPOINT_DEFINE<br>
&gt; #include &quot;tp.h&quot;<br>
&gt; <br>
&gt; +/* #define NDEBUG */<br>
&gt; +<br>
&gt; +#ifndef NDEBUG<br>
&gt; +int verbose;<br>
&gt; +#define TRACE(format, ...) { if (verbose) printf(&quot; ---TRACE: &qu=
ot; format,<br>
&gt; __VA_ARGS__); }<br>
&gt; +#else<br>
&gt; +#define TRACE(format, ...)<br>
&gt; +#endif<br>
&gt; +<br>
&gt; static struct option long_options[] =3D<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* These options set a flag. */<br>
&gt; @@ -38,9 +47,33 @@ static struct option long_options[] =3D<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;sync-before-last-event-touch&quot;, r=
equired_argument, 0, &#39;c&#39;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;sync-before-exit&quot;, required_argu=
ment, 0, &#39;d&#39;},<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{&quot;sync-before-exit-touch&quot;, require=
d_argument, 0, &#39;e&#39;},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{&quot;sync-before-first-event&quot;, required_ar=
gument, 0, &#39;f&#39;},<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{&quot;help&quot;, no_argument, 0, &#39;h&#39;},<=
br>
&gt; +#ifndef NDEBUG<br>
&gt; +=C2=A0 =C2=A0 =C2=A0{&quot;verbose&quot;, no_argument, 0, &#39;v&#39;=
},<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0{0, 0, 0, 0}<br>
&gt; };<br>
&gt; <br>
&gt; +const char *program_name;<br>
&gt; +<br>
&gt; +static void print_usage(void)<br>
&gt; +{<br>
&gt; +=C2=A0 =C2=A0 =C2=A0printf(&quot;Usage:=C2=A0 %s options\n&quot;, pro=
gram_name);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0printf(&quot;=C2=A0 -h=C2=A0 --help=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Display this usage<br>
&gt; information\n&quot;<br>
&gt; +#ifndef NDEBUG<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 -v=C2=A0 --ver=
bose=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Print verbose<br>
&gt; messages\n&quot;<br>
&gt; +#endif<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 -i=C2=A0 --ite=
r [iterations]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0Number of iterations,<br>
&gt; default=3D100, forever=3D-1\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 -w=C2=A0 --wai=
t [usec]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Time in usec between<br>
&gt; events, default=3D0\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 -a=C2=A0 --syn=
c-after-first-event [filename]=C2=A0 =C2=A0 =C2=A0 =C2=A0Create file after<=
br>
&gt; first event\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 -b=C2=A0 --syn=
c-before-last-event [filename]=C2=A0 =C2=A0 =C2=A0 =C2=A0Wait for file befo=
re<br>
&gt; writing last event\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 -c=C2=A0 --syn=
c-before-last-event-touch [filename] Create file after last<br>
&gt; event\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 -d=C2=A0 --syn=
c-before-exit [filename]=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Wai=
t for file before<br>
&gt; exit\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 -e=C2=A0 --syn=
c-before-exit-touch [filename]=C2=A0 =C2=A0 =C2=A0 =C2=A0Create file before=
<br>
&gt; exit\n&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;=C2=A0 -f=C2=A0 --syn=
c-before-first-event [filename]=C2=A0 =C2=A0 =C2=A0 Wait for file before<br=
>
&gt; creating the first event\n&quot;);<br>
&gt; +}<br>
&gt; +<br>
&gt; int main(int argc, char **argv)<br>
&gt; {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int i, netint;<br>
&gt; @@ -54,7 +87,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t net_values[] =3D { 1, 2, 3 };<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0int nr_iter =3D 100, ret =3D 0, first_event_=
file_created =3D 0;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0useconds_t nr_usec =3D 0;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0char *after_first_event_file_path =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *after_first_event_file_path_touch =3D NULL;=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *before_last_event_file_path =3D NULL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 * Touch a file to indicate that all events =
except one were<br>
&gt; @@ -65,16 +98,20 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *before_exit_file_path_touch =3D NULL;<=
br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0/* Wait on file before exiting */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0char *before_exit_file_path =3D NULL;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0/* Wait on file before starting */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0char *before_first_event_file_path =3D NULL;<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0program_name =3D argv[0];<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; 3; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0net_values[i] =
=3D htonl(net_values[i]);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 =C2=A0while ((option =3D getopt_long(argc, argv, &quot;=
i:w:a:b:c:d:&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0while ((option =3D getopt_long(argc, argv, &quot;=
i:w:a:b:c:d:e:f:hv&quot;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0long_options, &amp;option_index)) !=3D -1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (option) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;a&#39;=
:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0after_first_event_file_path =3D strdup(optarg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0after_first_event_file_path_touch =3D strdup(optarg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;b&#39;=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0before_last_event_file_path =3D strdup(optarg);<br>
&gt; @@ -88,22 +125,30 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;e&#39;=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0before_exit_file_path_touch =3D strdup(optarg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;f&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0before_first_event_file_path =3D strdup(optarg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;i&#39;=
:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0nr_iter =3D atoi(optarg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; +#ifndef NDEBUG<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;v&#39;:<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0verbose =3D 1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0break;<br>
&gt; +#endif<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;w&#39;=
:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0nr_usec =3D atoi(optarg);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* only postive values are valid */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0nr_usec =3D (atoi(optarg) &lt; 0) ? 0 : atoi(optarg);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0break;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;?&#39;:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0/* getopt_long already printed an error message. */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0case &#39;h&#39;:<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D -1;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0print_usage();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (optind !=3D argc) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot=
;Error: takes long options only.\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot=
;Error: takes options only.\n&quot;);<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Aborting the =
test program for now because callers typically don&#39;t check<br>
&gt; @@ -113,6 +158,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * we should eve=
ntually ensure that all scripts test and report the test<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * app return va=
lues.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_usage();<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0abort();<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -1;<br>
&gt; @@ -125,9 +171,23 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt; +=C2=A0 =C2=A0 =C2=A0TRACE(&quot;iter: %i\n&quot;, nr_iter);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TRACE(&quot;wait: %i (usec)\n&quot;, nr_usec);<br=
>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (before_first_event_file_path) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TRACE(&quot;before_fi=
rst_event_file_path(%i): %s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
-1, before_first_event_file_path);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D wait_on_file(=
before_first_event_file_path);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0goto end;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0for (i =3D 0; nr_iter &lt; 0 || i &lt; nr_it=
er; i++) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nr_iter &gt;=
=3D 0 &amp;&amp; i =3D=3D nr_iter - 1) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (before_last_event_file_path_touch) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TRACE(&quot;before_last_event_file_path_=
touch(%i): %s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, before_last_even=
t_file_path_touch);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D create_file(before_last_ev=
ent_file_path_touch);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto e=
nd;<br>
&gt; @@ -139,6 +199,8 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 * event.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (before_last_event_file_path) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TRACE(&quot;before_last_event_file_path(=
%i): %s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, before_last_even=
t_file_path);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D wait_on_file(before_last_e=
vent_file_path);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto e=
nd;<br>
&gt; @@ -153,9 +215,10 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * First loop we=
 create the file if asked to indicate<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * that at least=
 one tracepoint has been hit.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (after_first_event=
_file_path &amp;&amp; first_event_file_created =3D=3D 0) {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D create_file(after_first_event_file_path);<br>
&gt; -<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (after_first_event=
_file_path_touch &amp;&amp; first_event_file_created =3D=3D 0) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0TRACE(&quot;after_first_event_file_path_touch(%i): %s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0i, after_first_event_file_path_touch);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0ret =3D create_file(after_first_event_file_path_touch);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (ret !=3D 0) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0} else {<br>
&gt; @@ -164,7 +227,7 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (nr_usec) {<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (usleep_safe(nr_usec)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0if (usleep_safe(nr_usec)) {<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D -1;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>
&gt; @@ -175,22 +238,28 @@ int main(int argc, char **argv)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (before_exit_file_path_touch) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TRACE(&quot;before_ex=
it_file_path_touch(%i): %s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
i, before_exit_file_path_touch);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D create_f=
ile(before_exit_file_path_touch);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0if (before_exit_file_path) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0TRACE(&quot;before_ex=
it_file_path(%i): %s\n&quot;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
i, before_exit_file_path);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D wait_on_=
file(before_exit_file_path);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret !=3D 0) =
{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0goto end;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt; end:<br>
&gt; -=C2=A0 =C2=A0 =C2=A0free(after_first_event_file_path);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0TRACE(&quot;end status: %i\n&quot;, ret);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0free(after_first_event_file_path_touch);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0free(before_last_event_file_path);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0free(before_last_event_file_path_touch);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0free(before_exit_file_path);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0free(before_exit_file_path_touch);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0free(before_first_event_file_path);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0exit(!ret ? EXIT_SUCCESS : EXIT_FAILURE);<br=
>
&gt; }<br>
&gt; --<br>
&gt; 2.31.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
<br>
<br>
------------------------------<br>
<br>
Message: 4<br>
Date: Wed, 7 Apr 2021 11:31:46 -0400 (EDT)<br>
From: Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@efficios.co=
m" target=3D"_blank">mathieu.desnoyers@efficios.com</a>&gt;<br>
To: Anders Wallin &lt;<a href=3D"mailto:wallinux@gmail.com" target=3D"_blan=
k">wallinux@gmail.com</a>&gt;<br>
Cc: lttng-dev &lt;<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_b=
lank">lttng-dev@lists.lttng.org</a>&gt;<br>
Subject: Re: [lttng-dev] [PATCH lttng-tools] Fix: test code assumes<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 that child process is schedule to run before pa=
rent<br>
Message-ID:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 &lt;<a href=3D"mailto:667805472.60438.161780950=
6670.JavaMail.zimbra@efficios.com" target=3D"_blank">667805472.60438.161780=
9506670.JavaMail.zimbra@efficios.com</a>&gt;<br>
Content-Type: text/plain; charset=3Dutf-8<br>
<br>
----- On Apr 1, 2021, at 12:37 PM, lttng-dev <a href=3D"mailto:lttng-dev@li=
sts.lttng.org" target=3D"_blank">lttng-dev@lists.lttng.org</a> wrote:<br>
<br>
&gt; the following tests fails<br>
&gt; - test_event_vpid_tracker ust 0 &quot;${EVENT_NAME}&quot;<br>
&gt; - test_event_vpid_track_untrack ust 0 &quot;${EVENT_NAME}&quot;<br>
&gt; - test_event_pid_tracker ust 0 &quot;${EVENT_NAME}&quot;<br>
&gt; - test_event_pid_track_untrack ust 0 &quot;${EVENT_NAME}&quot;<br>
<br>
There is indeed an issue with these tests: there is a missing &quot;untrack=
 all pids&quot;<br>
which should be done at the very beginning of each test to have the expecte=
d<br>
behavior. AFAIU this explains why there is a small window where traced appl=
ications<br>
can generate events when none are expected.<br>
<br>
Fixing this should solve the issues without requiring any addition to the t=
est<br>
program.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<br>
&gt; <br>
&gt; Signed-off-by: Anders Wallin &lt;<a href=3D"mailto:wallinux@gmail.com"=
 target=3D"_blank">wallinux@gmail.com</a>&gt;<br>
&gt; ---<br>
&gt; tests/regression/tools/tracker/test_event_tracker | 15 ++++++---------=
<br>
&gt; 1 file changed, 6 insertions(+), 9 deletions(-)<br>
&gt; <br>
&gt; diff --git a/tests/regression/tools/tracker/test_event_tracker<br>
&gt; b/tests/regression/tools/tracker/test_event_tracker<br>
&gt; index 711690af..78e9310b 100755<br>
&gt; --- a/tests/regression/tools/tracker/test_event_tracker<br>
&gt; +++ b/tests/regression/tools/tracker/test_event_tracker<br>
&gt; @@ -5,7 +5,7 @@<br>
&gt; #<br>
&gt; # SPDX-License-Identifier: GPL-2.0-only<br>
&gt; <br>
&gt; -TEST_DESC=3D&quot;LTTng - Event traker test&quot;<br>
&gt; +TEST_DESC=3D&quot;LTTng - Event tracker test&quot;<br>
&gt; <br>
&gt; CURDIR=3D$(dirname &quot;$0&quot;)/<br>
&gt; TESTDIR=3D&quot;$CURDIR/../../..&quot;<br>
&gt; @@ -30,27 +30,24 @@ SCRIPT_GROUPNAME=3D&quot;$(id -gn)&quot;<br>
&gt; <br>
&gt; CHILD_PID=3D-1<br>
&gt; WAIT_PATH=3D<br>
&gt; -AFTER_FIRST_PATH=3D<br>
&gt; -BEFORE_LAST_PATH=3D<br>
&gt; +BEFORE_FIRST_PATH=3D<br>
&gt; <br>
&gt; source $TESTDIR/utils/utils.sh<br>
&gt; <br>
&gt; function prepare_ust_app<br>
&gt; {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0AFTER_FIRST_PATH=3D$(mktemp -u)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0BEFORE_LAST_PATH=3D$(mktemp -u)<br>
&gt; +=C2=A0 =C2=A0 =C2=A0BEFORE_FIRST_PATH=3D$(mktemp -u)<br>
&gt; <br>
&gt; -=C2=A0 =C2=A0 =C2=A0$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT -a &quo=
t;$AFTER_FIRST_PATH&quot; -b<br>
&gt; &quot;$BEFORE_LAST_PATH&quot; &amp;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0$TESTAPP_BIN -i $NR_ITER -w $NR_USEC_WAIT --sync-=
before-first-event<br>
&gt; &quot;$BEFORE_FIRST_PATH&quot; &amp;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0CHILD_PID=3D$!<br>
&gt; }<br>
&gt; <br>
&gt; function trace_ust_app<br>
&gt; {<br>
&gt; -=C2=A0 =C2=A0 =C2=A0touch &quot;$BEFORE_LAST_PATH&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0touch &quot;$BEFORE_FIRST_PATH&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0wait<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0ok $? &quot;Traced application stopped.&quot=
;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0rm &quot;$BEFORE_LAST_PATH&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0rm &quot;$AFTER_FIRST_PATH&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0rm &quot;$BEFORE_FIRST_PATH&quot;<br>
&gt; }<br>
&gt; <br>
&gt; function prepare_kernel_app<br>
&gt; --<br>
&gt; 2.31.1<br>
&gt; <br>
&gt; _______________________________________________<br>
&gt; lttng-dev mailing list<br>
&gt; <a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-d=
ev@lists.lttng.org</a><br>
&gt; <a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev"=
 rel=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailm=
an/listinfo/lttng-dev</a><br>
<br>
-- <br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" rel=3D"noreferrer" target=3D"_blank">ht=
tp://www.efficios.com</a><br>
<br>
<br>
------------------------------<br>
<br>
Subject: Digest Footer<br>
<br>
_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org" target=3D"_blank">lttng-dev@li=
sts.lttng.org</a><br>
<a href=3D"https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" rel=
=3D"noreferrer" target=3D"_blank">https://lists.lttng.org/cgi-bin/mailman/l=
istinfo/lttng-dev</a><br>
<br>
<br>
------------------------------<br>
<br>
End of lttng-dev Digest, Vol 156, Issue 8<br>
*****************************************<br>
</blockquote></div>

--0000000000009a22f305bf641725--

--===============6526846104558368044==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
https://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============6526846104558368044==--
