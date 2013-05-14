From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH] Fix linker library order
Date: Tue, 14 May 2013 08:37:24 -0400
Message-ID: <20130514123724.GA24238__17722.5219937556$1368535079$gmane$org@Krystal>
References: <1368318333-31522-1-git-send-email-francis.giraldeau@gmail.com>
	<20130512025917.GB405@Krystal> <519161C8.5000305@voxpopuli.im>
	<20130514065244.GA5066@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.openrapids.net ([64.15.138.104]
	helo=blackscsi.openrapids.net)
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@mail.openrapids.net>) id 1UcETt-0001Ga-Ux
	for lttng-dev@lists.lttng.org; Tue, 14 May 2013 08:37:26 -0400
Content-Disposition: inline
In-Reply-To: <20130514065244.GA5066@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

* Mathieu Desnoyers (mathieu.desnoyers@efficios.com) wrote:
> * Alexandre Montplaisir (alexmonthy@voxpopuli.im) wrote:
> > On 13-05-11 10:59 PM, Mathieu Desnoyers wrote:
> > > * Francis Giraldeau (francis.giraldeau@gmail.com) wrote:
> > >> Libraries must be specified after the binary target.
> > > merged, thanks!
> > >
> > > Mathieu
> > 
> > This seems to have broken the daily PPA packages:
> > https://launchpadlibrarian.net/139804087/buildlog_ubuntu-saucy-amd64.lttng-ust_2.2~pre-0%2Bbzr1574%2Bpack37%2B201305131247~saucy1_FAILEDTOBUILD.txt.gz
> > 
> > That package has no particular patches. If I build it locally from
> > source it builds fine, but if I build the package locally (with
> > dpkg-buildpackage), I get the same error. It could be related to the
> > --as-needed problem we've had before...
> 
> Francis, can you explain why your change was needed in the first place ?

Hrm, actually, these patches are wrong.

commit 725e63c5194bfdcde0a2a3507aca156ba36cf49f for instance:

"Libraries must be specified after the binary target."

 demo: demo.o
-       $(CC) -o $@ $(LIBS) $^
+       $(CC) -o $@ $^ $(LIBS)

the binary target here is "$@".

$^ is the source file name (demo.c).

this patch moves the source file name prior to the libraries, which is
incorrect (ref: gcc(1)). The input files should appear last.

So it breaks builds where $(LIBS) is non-empty.

I will revert commits:

commit a51ac6d9a011ba10b0be396dc1e801b2fc829651
Author: Francis Giraldeau <francis.giraldeau@gmail.com>
Date:   Sat May 11 22:59:21 2013 -0400

    Fix (another) linker library order
    
    Libraries must be specified after the binary target.
    
    Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

commit 725e63c5194bfdcde0a2a3507aca156ba36cf49f
Author: Francis Giraldeau <francis.giraldeau@gmail.com>
Date:   Sat May 11 22:58:12 2013 -0400

    Fix linker library order
    
    Libraries must be specified after the binary target.
    
    Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
    Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>


Thanks,

Mathieu

> 
> Thanks,
> 
> Mathieu
> 
> > 
> > Cheers,
> > Alex
> > 
> > >
> > >> Signed-off-by: Francis Giraldeau <francis.giraldeau@gmail.com>
> > >> ---
> > >>  doc/examples/demo/Makefile | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>
> > >> diff --git a/doc/examples/demo/Makefile b/doc/examples/demo/Makefile
> > >> index 7ae6547..bbc8ccb 100644
> > >> --- a/doc/examples/demo/Makefile
> > >> +++ b/doc/examples/demo/Makefile
> > >> @@ -55,7 +55,7 @@ demo.o: demo.c
> > >>  	$(CC) $(CPPFLAGS) $(CFLAGS) -c -o $@ $<
> > >>  
> > >>  demo: demo.o
> > >> -	$(CC) -o $@ $(LIBS) $^
> > >> +	$(CC) -o $@ $^ $(LIBS)
> > >>  
> > >>  .PHONY: clean
> > >>  clean:
> > >> -- 
> > >> 1.8.1.2
> > >>
> > >>
> > >> _______________________________________________
> > >> lttng-dev mailing list
> > >> lttng-dev@lists.lttng.org
> > >> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
> > 
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

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
