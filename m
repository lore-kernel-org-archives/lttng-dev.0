From: Simon Marchi <simon.marchi@polymtl.ca>
Subject: Re: [PATCH] Fix linker library order
Date: Tue, 14 May 2013 13:38:29 -0400
Message-ID: <CAFXXi0nvJhHiiMK_FE=_OMkT4yK+0_WLv8h=Nanvh3g0E1re3g__24657.92744556$1368553186$gmane$org@mail.gmail.com>
References: <1368318333-31522-1-git-send-email-francis.giraldeau@gmail.com>
	<20130512025917.GB405@Krystal> <519161C8.5000305@voxpopuli.im>
	<20130514065244.GA5066@Krystal> <20130514123724.GA24238@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ia0-f170.google.com ([209.85.210.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <thundersim@gmail.com>) id 1UcJBp-0003nt-7f
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 13:39:05 -0400
Received: by mail-ia0-f170.google.com with SMTP id l29so990513iag.29
	for <lttng-dev@lists.lttng.org>; Tue, 14 May 2013 10:38:59 -0700 (PDT)
In-Reply-To: <20130514123724.GA24238@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

On 14 May 2013 08:37, Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>
> * Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> > * Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
> > > On 13-05-11 10:59 PM, Mathieu Desnoyers wrote:
> > > > * Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> > > >> Libraries must be specified after the binary target.
> > > > merged, thanks!
> > > >
> > > > Mathieu
> > >
> > > This seems to have broken the daily PPA packages:
> > > https://launchpadlibrarian.net/139804087/buildlog_ubuntu-saucy-amd64.lttng-ust_2.2~pre-0%2Bbzr1574%2Bpack37%2B201305131247~saucy1_FAILEDTOBUILD.txt.gz
> > >
> > > That package has no particular patches. If I build it locally from
> > > source it builds fine, but if I build the package locally (with
> > > dpkg-buildpackage), I get the same error. It could be related to the
> > > --as-needed problem we've had before...
> >
> > Francis, can you explain why your change was needed in the first place ?
>
> Hrm, actually, these patches are wrong.


I believe these patches are correct.

>
> commit 725e63c5194bfdcde0a2a3507aca156ba36cf49f for instance:
>
> "Libraries must be specified after the binary target."
>
>  demo: demo.o
> -       $(CC) -o $@ $(LIBS) $^
> +       $(CC) -o $@ $^ $(LIBS)
>
> the binary target here is "$@".
>
> $^ is the source file name (demo.c).
>
> this patch moves the source file name prior to the libraries, which is
> incorrect (ref: gcc(1)). The input files should appear last.
>
> So it breaks builds where $(LIBS) is non-empty.

Actually, $^ here is "demo.o", not "demo. Also, the libs should appear
after the objects on the command line. See the "-l" section in
http://gcc.gnu.org/onlinedocs/gcc/Link-Options.html. On most setup
this doesn't matter, since -Wl,--no-as-needed was the default pretty
much everywhere. Ubuntu decided to use -Wl,--as-needed to avoid
unnecessary dependencies, so the order becomes important. If you try
to manual build on a recent Ubuntu you will get undefined references
to dlopen and such. So this patch is good.

If you read carefully the log sent by Alexandre, you see that it is
when building the shared libs in this directory
(lttng-ust-provider-ust-tests-demo.so) that the build fails. I don't
know why it fails, but Alexandre hinted that passing "-fPIE -pie" to
build a shared library is weird (it is usually -fPIC -pic). I am not
sure where that comes from. This behaviour only happens when building
the package, not when building manually.

>
> I will revert commits:
>
> commit a51ac6d9a011ba10b0be396dc1e801b2fc829651
> Author: Francis Giraldeau <francis.giraldeau@gmail.com>
> Date:   Sat May 11 22:59:21 2013 -0400
>
>     Fix (another) linker library order
>
>     Libraries must be specified after the binary target.
>
>     Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
> commit 725e63c5194bfdcde0a2a3507aca156ba36cf49f
> Author: Francis Giraldeau <francis.giraldeau@gmail.com>
> Date:   Sat May 11 22:58:12 2013 -0400
>
>     Fix linker library order
>
>     Libraries must be specified after the binary target.
>
>     Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
>     Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>
>
> Thanks,
>
> Mathieu
>
> >
> > Thanks,
> >
> > Mathieu
> >
> > >
> > > Cheers,
> > > Alex
> > >
> > > >
> > > >> Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> > > >> ---
> > > >>  doc/examples/demo/Makefile | 2 +-
> > > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >>
> > > >> diff --git a/doc/examples/demo/Makefile b/doc/examples/demo/Makefile
> > > >> index 7ae6547..bbc8ccb 100644
> > > >> --- a/doc/examples/demo/Makefile
> > > >> +++ b/doc/examples/demo/Makefile
> > > >> @@ -55,7 +55,7 @@ demo.o: demo.c
> > > >>          $(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> > > >>
> > > >>  demo: demo.o
> > > >> -        $(CC) -o $@ $(LIBS) $^
> > > >> +        $(CC) -o $@ $^ $(LIBS)
> > > >>
> > > >>  .PHONY: clean
> > > >>  clean:
> > > >> --
> > > >> 1.8.1.2
> > > >>
> > > >>
> > > >> _______________________________________________
> > > >> lttng-dev mailing list
> > > >> lttng-dev@lists.lttng.org
> > > >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > >
> >
> > --
> > Mathieu Desnoyers
> > EfficiOS Inc.
> > http://www.efficios.com
> >
> > _______________________________________________
> > lttng-dev mailing list
> > lttng-dev@lists.lttng.org
> > http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
