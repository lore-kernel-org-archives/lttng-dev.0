From: Rob van der Heij <rvdheij@gmail.com>
Subject: Re: [-stable 3.8.1 performance regression] madvise
	POSIX_FADV_DONTNEED
Date: Thu, 4 Jul 2013 23:11:34 +0200
Message-ID: <CAJCc=kjjAijXNtnDAsoS8tMvL9y+VDwovycJ82WS4gMJnQkFPQ__48939.4310316586$1372972345$gmane$org@mail.gmail.com>
References: <20130618101147.GA7436@suse.de> <20130619192508.GA666@Krystal>
	<CAJCc=kijujORhPUmPvzHj-MMdyVbf-iHEK0Jx-VHbTO8q4ESFA@mail.gmail.com>
	<20130620122016.GA12700@Krystal> <20130625015648.GO29376@dastard>
	<20130702135858.GA30837@Krystal> <20130703005514.GA17149@Krystal>
	<20130703084715.GF1875@suse.de>
	<x49wqp7puej.fsf@segfault.boston.devel.redhat.com>
	<20130704000344.GG4072@dastard> <20130704003103.GA13899@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2117665083=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f45.google.com ([209.85.215.45])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <rvdheij@gmail.com>) id 1UuqoW-0005Vw-TK
	for lttng-dev@lists.lttng.org; Thu, 04 Jul 2013 17:11:41 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so1556871lab.4
	for <lttng-dev@lists.lttng.org>; Thu, 04 Jul 2013 14:11:34 -0700 (PDT)
In-Reply-To: <20130704003103.GA13899@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dave Chinner <david@fromorbit.com>, LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, Jeff Moyer <jmoyer@redhat.com>, Mel Gorman <mgorman@suse.de>, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: lttng-dev@lists.lttng.org

--===============2117665083==
Content-Type: multipart/alternative; boundary=089e0160bc34e715d404e0b60559

--089e0160bc34e715d404e0b60559
Content-Type: text/plain; charset=ISO-8859-1

I would suggest that when O_DIRECT gives you less than optimal throughput,
then your application is not getting the block size or concurrency that
it's getting from buffered I/O. My limited experiments show that with
larger block size with direct I/O an application can get the same
throughput as with at lower CPU cost. Since you seem to be mainly writing,
I'd imaging 64K is pretty small. Obviously you don't want every application
to invent this on his own, which is why we have buffered I/O.

Rob


On 4 July 2013 02:31, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>wrote:

> * Dave Chinner (david@fromorbit.com) wrote:
> > On Wed, Jul 03, 2013 at 10:53:08AM -0400, Jeff Moyer wrote:
> > > Mel Gorman <mgorman@suse.de> writes:
> > >
> > > >> > I just tried replacing my sync_file_range()+fadvise() calls and
> instead
> > > >> > pass the O_DIRECT flag to open(). Unfortunately, I must be doing
> > > >> > something very wrong, because I get only 1/3rd of the throughput,
> and
> > > >> > the page cache fills up. Any idea why ?
> > > >>
> > > >> Since O_DIRECT does not seem to provide acceptable throughput, it
> may be
> > > >> interesting to investigate other ways to lessen the latency impact
> of
> > > >> the fadvise DONTNEED hint.
> > > >>
> > > >
> > > > There are cases where O_DIRECT falls back to buffered IO which is
> why you
> > > > might have found that page cache was still filling up. There are a
> few
> > > > reasons why this can happen but I would guess the common cause is
> that
> > > > the range of pages being written was in the page cache already and
> could
> > > > not be invalidated for some reason. I'm guessing this is the common
> case
> > > > for page cache filling even with O_DIRECT but would not bet money on
> it
> > > > as it's not a problem I investigated before.
> > >
> > > Even when O_DIRECT falls back to buffered I/O for writes, it will
> > > invalidate the page cache range described by the buffered I/O once it
> > > completes.  For reads, the range is written out synchronously before
> the
> > > direct I/O is issued.  Either way, you shouldn't see the page cache
> > > filling up.
> >
> > <sigh>
> >
> > I keep forgetting that filesystems other than XFS have sub-optimal
> > direct IO implementations. I wish that "silent fallback to buffered
> > IO" idea had never seen the light of day, and that filesystems
> > implemented direct IO properly.
> >
> > > Switching to O_DIRECT often incurs a performance hit, especially if the
> > > application does not submit more than one I/O at a time.  Remember,
> > > you're not getting readahead, and you're not getting the benefit of the
> > > writeback code submitting batches of I/O.
> >
> > With the way IO is being done, there won't be any readahead (write
> > only workload) and they are directly controlling writeback one chunk
> > at a time, so there's not writeback caching to do batching, either.
> > There's no obvious reason that direct IO should be any slower
> > assuming that the application is actually doing 1MB sized and
> > aligned IOs like was mentioned, because both methods are directly
> > dispatching and then waiting for IO completion.
>
> As a clarification, I use 256kB "chunks" (sub-buffers) in my tests, not
> 1MB. Also, please note that since I'm using splice(), each individual
> splice call is internally limited to 16 pages worth of data transfer
> (64kB).
>
> > What filesystem is in use here?
>
> My test was performed on ext3 filesystem, that was itself sitting on
> raid-1 software raid.
>
> Thanks,
>
> Mathieu
>
> >
> > Cheers,
> >
> > Dave.
> > --
> > Dave Chinner
> > david@fromorbit.com
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--089e0160bc34e715d404e0b60559
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I would suggest that when O_DIRECT gives you less tha=
n optimal throughput, then your application is not getting the block size o=
r concurrency that it&#39;s getting from buffered I/O. My limited experimen=
ts show that with larger block size with direct I/O an application can get =
the same throughput as with at lower CPU cost. Since you seem to be mainly =
writing, I&#39;d imaging 64K is pretty small. Obviously you don&#39;t want =
every application to invent this on his own, which is why we have buffered =
I/O. <br>
<br></div><div>Rob<br></div></div><div class=3D"gmail_extra"><br><br><div c=
lass=3D"gmail_quote">On 4 July 2013 02:31, Mathieu Desnoyers <span dir=3D"l=
tr">&lt;<a href=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank"=
>mathieu.desnoyers@efficios.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">* Dave Chinner (<a href=3D=
"mailto:david@fromorbit.com">david@fromorbit.com</a>) wrote:<br>
</div><div><div class=3D"h5">&gt; On Wed, Jul 03, 2013 at 10:53:08AM -0400,=
 Jeff Moyer wrote:<br>
&gt; &gt; Mel Gorman &lt;<a href=3D"mailto:mgorman@suse.de">mgorman@suse.de=
</a>&gt; writes:<br>
&gt; &gt;<br>
&gt; &gt; &gt;&gt; &gt; I just tried replacing my sync_file_range()+fadvise=
() calls and instead<br>
&gt; &gt; &gt;&gt; &gt; pass the O_DIRECT flag to open(). Unfortunately, I =
must be doing<br>
&gt; &gt; &gt;&gt; &gt; something very wrong, because I get only 1/3rd of t=
he throughput, and<br>
&gt; &gt; &gt;&gt; &gt; the page cache fills up. Any idea why ?<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;&gt; Since O_DIRECT does not seem to provide acceptable throu=
ghput, it may be<br>
&gt; &gt; &gt;&gt; interesting to investigate other ways to lessen the late=
ncy impact of<br>
&gt; &gt; &gt;&gt; the fadvise DONTNEED hint.<br>
&gt; &gt; &gt;&gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; There are cases where O_DIRECT falls back to buffered IO whi=
ch is why you<br>
&gt; &gt; &gt; might have found that page cache was still filling up. There=
 are a few<br>
&gt; &gt; &gt; reasons why this can happen but I would guess the common cau=
se is that<br>
&gt; &gt; &gt; the range of pages being written was in the page cache alrea=
dy and could<br>
&gt; &gt; &gt; not be invalidated for some reason. I&#39;m guessing this is=
 the common case<br>
&gt; &gt; &gt; for page cache filling even with O_DIRECT but would not bet =
money on it<br>
&gt; &gt; &gt; as it&#39;s not a problem I investigated before.<br>
&gt; &gt;<br>
&gt; &gt; Even when O_DIRECT falls back to buffered I/O for writes, it will=
<br>
&gt; &gt; invalidate the page cache range described by the buffered I/O onc=
e it<br>
&gt; &gt; completes. =A0For reads, the range is written out synchronously b=
efore the<br>
&gt; &gt; direct I/O is issued. =A0Either way, you shouldn&#39;t see the pa=
ge cache<br>
&gt; &gt; filling up.<br>
&gt;<br>
&gt; &lt;sigh&gt;<br>
&gt;<br>
&gt; I keep forgetting that filesystems other than XFS have sub-optimal<br>
&gt; direct IO implementations. I wish that &quot;silent fallback to buffer=
ed<br>
&gt; IO&quot; idea had never seen the light of day, and that filesystems<br=
>
&gt; implemented direct IO properly.<br>
&gt;<br>
&gt; &gt; Switching to O_DIRECT often incurs a performance hit, especially =
if the<br>
&gt; &gt; application does not submit more than one I/O at a time. =A0Remem=
ber,<br>
&gt; &gt; you&#39;re not getting readahead, and you&#39;re not getting the =
benefit of the<br>
&gt; &gt; writeback code submitting batches of I/O.<br>
&gt;<br>
&gt; With the way IO is being done, there won&#39;t be any readahead (write=
<br>
&gt; only workload) and they are directly controlling writeback one chunk<b=
r>
&gt; at a time, so there&#39;s not writeback caching to do batching, either=
.<br>
&gt; There&#39;s no obvious reason that direct IO should be any slower<br>
&gt; assuming that the application is actually doing 1MB sized and<br>
&gt; aligned IOs like was mentioned, because both methods are directly<br>
&gt; dispatching and then waiting for IO completion.<br>
<br>
</div></div>As a clarification, I use 256kB &quot;chunks&quot; (sub-buffers=
) in my tests, not<br>
1MB. Also, please note that since I&#39;m using splice(), each individual<b=
r>
splice call is internally limited to 16 pages worth of data transfer<br>
(64kB).<br>
<div class=3D"im"><br>
&gt; What filesystem is in use here?<br>
<br>
</div>My test was performed on ext3 filesystem, that was itself sitting on<=
br>
raid-1 software raid.<br>
<br>
Thanks,<br>
<br>
Mathieu<br>
<div class=3D"im HOEnZb"><br>
&gt;<br>
&gt; Cheers,<br>
&gt;<br>
&gt; Dave.<br>
&gt; --<br>
&gt; Dave Chinner<br>
&gt; <a href=3D"mailto:david@fromorbit.com">david@fromorbit.com</a><br>
<br>
</div><div class=3D"HOEnZb"><div class=3D"h5">--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</div></div></blockquote></div><br></div>

--089e0160bc34e715d404e0b60559--


--===============2117665083==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2117665083==--
