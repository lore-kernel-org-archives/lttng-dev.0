From: Rob van der Heij <rvdheij@gmail.com>
Subject: Re: [-stable 3.8.1 performance regression] madvise
	POSIX_FADV_DONTNEED
Date: Thu, 20 Jun 2013 08:36:59 +0200
Message-ID: <CAJCc=kijujORhPUmPvzHj-MMdyVbf-iHEK0Jx-VHbTO8q4ESFA__37200.9448278279$1371730883$gmane$org@mail.gmail.com>
References: <51BE1828.3060206@gmail.com> <20130617141357.GA6034@Krystal>
	<20130617142459.1d563072231ba269cdac8f11@linux-foundation.org>
	<20130618092925.GI1875@suse.de> <20130618101147.GA7436@suse.de>
	<20130619192508.GA666@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1376732027=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-la0-f43.google.com ([209.85.215.43])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <rvdheij@gmail.com>) id 1UpYUT-0005yI-Pp
	for lttng-dev@lists.lttng.org; Thu, 20 Jun 2013 02:37:06 -0400
Received: by mail-la0-f43.google.com with SMTP id gw10so5271245lab.2
	for <lttng-dev@lists.lttng.org>; Wed, 19 Jun 2013 23:36:59 -0700 (PDT)
In-Reply-To: <20130619192508.GA666@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mel Gorman <mgorman@suse.de>, Andrew Morton <akpm@linux-foundation.org>
List-Id: lttng-dev@lists.lttng.org

--===============1376732027==
Content-Type: multipart/alternative; boundary=047d7b34363a5d4c5504df902c05

--047d7b34363a5d4c5504df902c05
Content-Type: text/plain; charset=ISO-8859-1

Wouldn't you batch the calls to drop the pages from cache rather than drop
one packet at a time? Your effort to help Linux mm seems a bit overkill,
and you don't want every application to do it like that himself. The
fadvise will not even work when the page is still to be flushed out.
Without the patch that started the thread, it would 'at random' not work
due to SMP race condition (not multi-threading).

I believe the right way would be for Linux to implement the fadvise flags
properly to guide cache replacement.

My situation was slightly different. I run in a virtualized environment
where it would be a global improvement for the Linux guest not to cache
data, even though from Linux mm perspective there is plenty of space and no
good reason not to keep the data. My scenario intercepted the close() call
to drop each input file during a tar or file system scan. This avoids
building a huge page cache with stuff that will not be referenced until
next backup and thus gets paged out by the hypervisor. There's some more
here:
http://zvmperf.wordpress.com/2013/01/27/taming-linux-page-cache/

Rob


On 19 June 2013 21:25, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>wrote:

> * Mel Gorman (mgorman@suse.de) wrote:
> > On Tue, Jun 18, 2013 at 10:29:26AM +0100, Mel Gorman wrote:
> > > On Mon, Jun 17, 2013 at 02:24:59PM -0700, Andrew Morton wrote:
> > > > On Mon, 17 Jun 2013 10:13:57 -0400 Mathieu Desnoyers <
> mathieu.desnoyers@efficios.com> wrote:
> > > >
> > > > > Hi,
> > > > >
> > > > > CCing lkml on this,
> > > > >
> > > > > * Yannick Brosseau (yannick.brosseau@gmail.com) wrote:
> > > > > > Hi all,
> > > > > >
> > > > > > We discovered a performance regression in recent kernels with
> LTTng
> > > > > > related to the use of fadvise DONTNEED.
> > > > > > A call to this syscall is present in the LTTng consumer.
> > > > > >
> > > > > > The following kernel commit cause the call to fadvise to be
> sometime
> > > > > > really slower.
> > > > > >
> > > > > > Kernel commit info:
> > > > > > mm/fadvise.c: drain all pagevecs if POSIX_FADV_DONTNEED fails to
> discard
> > > > > > all pages
> > > > > > main tree: (since 3.9-rc1)
> > > > > > commit 67d46b296a1ba1477c0df8ff3bc5e0167a0b0732
> > > > > > stable tree: (since 3.8.1)
> > > > > >
> https://git.kernel.org/cgit/linux/kernel/git/stable/linux-stable.git/commit?id=bb01afe62feca1e7cdca60696f8b074416b0910d
> > > > > >
> > > > > > On the workload test, we observe that the call to fadvise takes
> about
> > > > > > 4-5 us before this patch is applied. After applying the patch,
> The
> > > > > > syscall now takes values from 5 us up to 4 ms (4000 us)
> sometime. The
> > > > > > effect on lttng is that the consumer is frozen for this long
> period
> > > > > > which leads to dropped event in the trace.
> > > >
> > > > That change wasn't terribly efficient - if there are any unpopulated
> > > > pages in the range (which is quite likely), fadvise() will now always
> > > > call invalidate_mapping_pages() a second time.
> > > >
> > >
> > > I did not view the path as being performance critical and did not
> anticipate
> > > a delay that severe.
> >
> > Which I should have, schedule_on_each_cpu is documented to be slow.
> >
> > > The original test case as well was based on
> > > sequential IO as part of a backup so I was also generally expecting the
> > > range to be populated. I looked at the other users of
> lru_add_drain_all()
> > > but there are fairly few. compaction uses them but only when used via
> sysfs
> > > or proc. ksm uses it but it's not likely to be that noticable. mlock
> uses
> > > it but it's unlikely it is being called frequently so I'm not going to
> > > worry performance of lru_add_drain_all() in general. I'll look closer
> at
> > > properly detecting when it's necessarily to call in the fadvise case.
> > >
> >
> > This compile-only tested prototype should detect remaining pages in the
> rage
> > that were not invalidated. This will at least detect unpopulated pages
> but
> > whether it has any impact depends on what lttng is invalidating. If it's
> > invalidating a range of per-cpu traces then I doubt this will work
> because
> > there will always be remaining pages. Similarly I wonder if passing down
> > the mapping will really help if a large number of cpus are tracing as we
> > end up scheduling work on every CPU regardless.
>
> Here is how LTTng consumerd is using POSIX_FADV_DONTNEED. Please let me
> know if we are doing something stupid. ;-)
>
> The LTTng consumerd deals with trace packets, which consists of a set of
> pages. I'll just discuss how the pages are moved around, leaving out
> discussion about synchronization between producer/consumer.
>
> Whenever the Nth trace packet is ready to be written to disk:
>
> 1) splice the entire set of pages of trace packet N to disk through a
>    pipe,
> 2) sync_file_range on trace packet N-1 with the following flags:
>    SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE |
> SYNC_FILE_RANGE_WAIT_AFTER
>    so we wait (blocking) on the _previous_ trace packet to be completely
>    written to disk.
> 3) posix_fadvise POSIX_FADV_DONTNEED on trace packet N-1.
>
> There are a couple of comments in my consumerd code explaining why we do
> this sequence of steps:
>
>         /*
>          * Give hints to the kernel about how we access the file:
>          * POSIX_FADV_DONTNEED : we won't re-access data in a near future
> after
>          * we write it.
>          *
>          * We need to call fadvise again after the file grows because the
>          * kernel does not seem to apply fadvise to non-existing parts of
> the
>          * file.
>          *
>          * Call fadvise _after_ having waited for the page writeback to
>          * complete because the dirty page writeback semantic is not well
>          * defined. So it can be expected to lead to lower throughput in
>          * streaming.
>          */
>
> Currently, the lttng-consumerd is single-threaded, but we plan to
> re-introduce multi-threading, and per-cpu affinity, in a near future.
>
> Yannick will try your patch tomorrow and report whether it improves
> performance or not,
>
> Thanks!
>
> Mathieu
>
> >
> > diff --git a/include/linux/fs.h b/include/linux/fs.h
> > index 2c28271..e2bb47e 100644
> > --- a/include/linux/fs.h
> > +++ b/include/linux/fs.h
> > @@ -2176,6 +2176,8 @@ extern int invalidate_partition(struct gendisk *,
> int);
> >  #endif
> >  unsigned long invalidate_mapping_pages(struct address_space *mapping,
> >                                       pgoff_t start, pgoff_t end);
> > +unsigned long invalidate_mapping_pages_check(struct address_space
> *mapping,
> > +                                     pgoff_t start, pgoff_t end);
> >
> >  static inline void invalidate_remote_inode(struct inode *inode)
> >  {
> > diff --git a/mm/fadvise.c b/mm/fadvise.c
> > index 7e09268..0579e60 100644
> > --- a/mm/fadvise.c
> > +++ b/mm/fadvise.c
> > @@ -122,7 +122,9 @@ SYSCALL_DEFINE(fadvise64_64)(int fd, loff_t offset,
> loff_t len, int advice)
> >               end_index = (endbyte >> PAGE_CACHE_SHIFT);
> >
> >               if (end_index >= start_index) {
> > -                     unsigned long count =
> invalidate_mapping_pages(mapping,
> > +                     unsigned long nr_remaining;
> > +
> > +                     nr_remaining =
> invalidate_mapping_pages_check(mapping,
> >                                               start_index, end_index);
> >
> >                       /*
> > @@ -131,7 +133,7 @@ SYSCALL_DEFINE(fadvise64_64)(int fd, loff_t offset,
> loff_t len, int advice)
> >                        * a per-cpu pagevec for a remote CPU. Drain all
> >                        * pagevecs and try again.
> >                        */
> > -                     if (count < (end_index - start_index + 1)) {
> > +                     if (nr_remaining) {
> >                               lru_add_drain_all();
> >                               invalidate_mapping_pages(mapping,
> start_index,
> >                                               end_index);
> > diff --git a/mm/truncate.c b/mm/truncate.c
> > index c75b736..86cfc2e 100644
> > --- a/mm/truncate.c
> > +++ b/mm/truncate.c
> > @@ -312,26 +312,16 @@ void truncate_inode_pages(struct address_space
> *mapping, loff_t lstart)
> >  }
> >  EXPORT_SYMBOL(truncate_inode_pages);
> >
> > -/**
> > - * invalidate_mapping_pages - Invalidate all the unlocked pages of one
> inode
> > - * @mapping: the address_space which holds the pages to invalidate
> > - * @start: the offset 'from' which to invalidate
> > - * @end: the offset 'to' which to invalidate (inclusive)
> > - *
> > - * This function only removes the unlocked pages, if you want to
> > - * remove all the pages of one inode, you must call
> truncate_inode_pages.
> > - *
> > - * invalidate_mapping_pages() will not block on IO activity. It will not
> > - * invalidate pages which are dirty, locked, under writeback or mapped
> into
> > - * pagetables.
> > - */
> > -unsigned long invalidate_mapping_pages(struct address_space *mapping,
> > -             pgoff_t start, pgoff_t end)
> > +static void __invalidate_mapping_pages(struct address_space *mapping,
> > +             pgoff_t start, pgoff_t end,
> > +             unsigned long *ret_nr_invalidated,
> > +             unsigned long *ret_nr_remaining)
> >  {
> >       struct pagevec pvec;
> >       pgoff_t index = start;
> >       unsigned long ret;
> > -     unsigned long count = 0;
> > +     unsigned long nr_invalidated = 0;
> > +     unsigned long nr_remaining = 0;
> >       int i;
> >
> >       /*
> > @@ -354,8 +344,10 @@ unsigned long invalidate_mapping_pages(struct
> address_space *mapping,
> >                       if (index > end)
> >                               break;
> >
> > -                     if (!trylock_page(page))
> > +                     if (!trylock_page(page)) {
> > +                             nr_remaining++;
> >                               continue;
> > +                     }
> >                       WARN_ON(page->index != index);
> >                       ret = invalidate_inode_page(page);
> >                       unlock_page(page);
> > @@ -365,17 +357,73 @@ unsigned long invalidate_mapping_pages(struct
> address_space *mapping,
> >                        */
> >                       if (!ret)
> >                               deactivate_page(page);
> > -                     count += ret;
> > +                     else
> > +                             nr_remaining++;
> > +                     nr_invalidated += ret;
> >               }
> >               pagevec_release(&pvec);
> >               mem_cgroup_uncharge_end();
> >               cond_resched();
> >               index++;
> >       }
> > -     return count;
> > +
> > +     *ret_nr_invalidated = nr_invalidated;
> > +     *ret_nr_remaining = nr_remaining;
> >  }
> >  EXPORT_SYMBOL(invalidate_mapping_pages);
> >
> > +/**
> > + * invalidate_mapping_pages - Invalidate all the unlocked pages of one
> inode
> > + * @mapping: the address_space which holds the pages to invalidate
> > + * @start: the offset 'from' which to invalidate
> > + * @end: the offset 'to' which to invalidate (inclusive)
> > + *
> > + * This function only removes the unlocked pages, if you want to
> > + * remove all the pages of one inode, you must call
> truncate_inode_pages.
> > + *
> > + * invalidate_mapping_pages() will not block on IO activity. It will not
> > + * invalidate pages which are dirty, locked, under writeback or mapped
> into
> > + * pagetables.
> > + *
> > + * Returns the number of pages invalidated
> > + */
> > +unsigned long invalidate_mapping_pages(struct address_space *mapping,
> > +             pgoff_t start, pgoff_t end)
> > +{
> > +     unsigned long nr_invalidated, nr_remaining;
> > +
> > +     __invalidate_mapping_pages(mapping, start, end,
> > +                                &nr_invalidated, &nr_remaining);
> > +
> > +     return nr_invalidated;
> > +}
> > +
> > +/**
> > + * invalidate_mapping_pages_check - Invalidate all the unlocked pages
> of one inode and check for remaining pages.
> > + * @mapping: the address_space which holds the pages to invalidate
> > + * @start: the offset 'from' which to invalidate
> > + * @end: the offset 'to' which to invalidate (inclusive)
> > + *
> > + * This function only removes the unlocked pages, if you want to
> > + * remove all the pages of one inode, you must call
> truncate_inode_pages.
> > + *
> > + * invalidate_mapping_pages() will not block on IO activity. It will not
> > + * invalidate pages which are dirty, locked, under writeback or mapped
> into
> > + * pagetables.
> > + *
> > + * Returns the number of pages remaining in the invalidated range
> > + */
> > +unsigned long invalidate_mapping_pages_check(struct address_space
> *mapping,
> > +             pgoff_t start, pgoff_t end)
> > +{
> > +     unsigned long nr_invalidated, nr_remaining;
> > +
> > +     __invalidate_mapping_pages(mapping, start, end,
> > +                                &nr_invalidated, &nr_remaining);
> > +
> > +     return nr_remaining;
> > +}
> > +
> >  /*
> >   * This is like invalidate_complete_page(), except it ignores the page's
> >   * refcount.  We do this because invalidate_inode_pages2() needs
> stronger
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
>

--047d7b34363a5d4c5504df902c05
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>Wouldn&#39;t you batch the calls to drop the pag=
es from cache rather than drop one packet at a time? Your effort to help Li=
nux mm seems a bit overkill, and you don&#39;t want every application to do=
 it like that himself. The fadvise will not even work when the page is stil=
l to be flushed out. Without the patch that started the thread, it would &#=
39;at random&#39; not work due to SMP race condition (not multi-threading).=
<br>
<br>I believe the right way would be for Linux to implement the fadvise fla=
gs properly to guide cache replacement.<br><br></div>My situation was sligh=
tly different. I run in a virtualized environment where it would be a globa=
l improvement for the Linux guest not to cache data, even though from Linux=
 mm perspective there is plenty of space and no good reason not to keep the=
 data. My scenario intercepted the close() call to drop each input file dur=
ing a tar or file system scan. This avoids building a huge page cache with =
stuff that will not be referenced until next backup and thus gets paged out=
 by the hypervisor. There&#39;s some more here:<br>
<a href=3D"http://zvmperf.wordpress.com/2013/01/27/taming-linux-page-cache/=
">http://zvmperf.wordpress.com/2013/01/27/taming-linux-page-cache/</a><br><=
br></div>Rob<br></div><div class=3D"gmail_extra"><br><br><div class=3D"gmai=
l_quote">
On 19 June 2013 21:25, Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=3D"m=
ailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoyers@e=
fficios.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<div class=3D"HOEnZb"><div class=3D"h5">* Mel Gorman (<a href=3D"mailto:mgo=
rman@suse.de">mgorman@suse.de</a>) wrote:<br>
&gt; On Tue, Jun 18, 2013 at 10:29:26AM +0100, Mel Gorman wrote:<br>
&gt; &gt; On Mon, Jun 17, 2013 at 02:24:59PM -0700, Andrew Morton wrote:<br=
>
&gt; &gt; &gt; On Mon, 17 Jun 2013 10:13:57 -0400 Mathieu Desnoyers &lt;<a =
href=3D"mailto:mathieu.desnoyers@efficios.com">mathieu.desnoyers@efficios.c=
om</a>&gt; wrote:<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Hi,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; CCing lkml on this,<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; * Yannick Brosseau (<a href=3D"mailto:yannick.brosseau@=
gmail.com">yannick.brosseau@gmail.com</a>) wrote:<br>
&gt; &gt; &gt; &gt; &gt; Hi all,<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; We discovered a performance regression in recent k=
ernels with LTTng<br>
&gt; &gt; &gt; &gt; &gt; related to the use of fadvise DONTNEED.<br>
&gt; &gt; &gt; &gt; &gt; A call to this syscall is present in the LTTng con=
sumer.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; The following kernel commit cause the call to fadv=
ise to be sometime<br>
&gt; &gt; &gt; &gt; &gt; really slower.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; Kernel commit info:<br>
&gt; &gt; &gt; &gt; &gt; mm/fadvise.c: drain all pagevecs if POSIX_FADV_DON=
TNEED fails to discard<br>
&gt; &gt; &gt; &gt; &gt; all pages<br>
&gt; &gt; &gt; &gt; &gt; main tree: (since 3.9-rc1)<br>
&gt; &gt; &gt; &gt; &gt; commit 67d46b296a1ba1477c0df8ff3bc5e0167a0b0732<br=
>
&gt; &gt; &gt; &gt; &gt; stable tree: (since 3.8.1)<br>
&gt; &gt; &gt; &gt; &gt; <a href=3D"https://git.kernel.org/cgit/linux/kerne=
l/git/stable/linux-stable.git/commit?id=3Dbb01afe62feca1e7cdca60696f8b07441=
6b0910d" target=3D"_blank">https://git.kernel.org/cgit/linux/kernel/git/sta=
ble/linux-stable.git/commit?id=3Dbb01afe62feca1e7cdca60696f8b074416b0910d</=
a><br>

&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; On the workload test, we observe that the call to =
fadvise takes about<br>
&gt; &gt; &gt; &gt; &gt; 4-5 us before this patch is applied. After applyin=
g the patch, The<br>
&gt; &gt; &gt; &gt; &gt; syscall now takes values from 5 us up to 4 ms (400=
0 us) sometime. The<br>
&gt; &gt; &gt; &gt; &gt; effect on lttng is that the consumer is frozen for=
 this long period<br>
&gt; &gt; &gt; &gt; &gt; which leads to dropped event in the trace.<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; That change wasn&#39;t terribly efficient - if there are any=
 unpopulated<br>
&gt; &gt; &gt; pages in the range (which is quite likely), fadvise() will n=
ow always<br>
&gt; &gt; &gt; call invalidate_mapping_pages() a second time.<br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; I did not view the path as being performance critical and did not=
 anticipate<br>
&gt; &gt; a delay that severe.<br>
&gt;<br>
&gt; Which I should have, schedule_on_each_cpu is documented to be slow.<br=
>
&gt;<br>
&gt; &gt; The original test case as well was based on<br>
&gt; &gt; sequential IO as part of a backup so I was also generally expecti=
ng the<br>
&gt; &gt; range to be populated. I looked at the other users of lru_add_dra=
in_all()<br>
&gt; &gt; but there are fairly few. compaction uses them but only when used=
 via sysfs<br>
&gt; &gt; or proc. ksm uses it but it&#39;s not likely to be that noticable=
. mlock uses<br>
&gt; &gt; it but it&#39;s unlikely it is being called frequently so I&#39;m=
 not going to<br>
&gt; &gt; worry performance of lru_add_drain_all() in general. I&#39;ll loo=
k closer at<br>
&gt; &gt; properly detecting when it&#39;s necessarily to call in the fadvi=
se case.<br>
&gt; &gt;<br>
&gt;<br>
&gt; This compile-only tested prototype should detect remaining pages in th=
e rage<br>
&gt; that were not invalidated. This will at least detect unpopulated pages=
 but<br>
&gt; whether it has any impact depends on what lttng is invalidating. If it=
&#39;s<br>
&gt; invalidating a range of per-cpu traces then I doubt this will work bec=
ause<br>
&gt; there will always be remaining pages. Similarly I wonder if passing do=
wn<br>
&gt; the mapping will really help if a large number of cpus are tracing as =
we<br>
&gt; end up scheduling work on every CPU regardless.<br>
<br>
</div></div>Here is how LTTng consumerd is using POSIX_FADV_DONTNEED. Pleas=
e let me<br>
know if we are doing something stupid. ;-)<br>
<br>
The LTTng consumerd deals with trace packets, which consists of a set of<br=
>
pages. I&#39;ll just discuss how the pages are moved around, leaving out<br=
>
discussion about synchronization between producer/consumer.<br>
<br>
Whenever the Nth trace packet is ready to be written to disk:<br>
<br>
1) splice the entire set of pages of trace packet N to disk through a<br>
=A0 =A0pipe,<br>
2) sync_file_range on trace packet N-1 with the following flags:<br>
=A0 =A0SYNC_FILE_RANGE_WAIT_BEFORE | SYNC_FILE_RANGE_WRITE | SYNC_FILE_RANG=
E_WAIT_AFTER<br>
=A0 =A0so we wait (blocking) on the _previous_ trace packet to be completel=
y<br>
=A0 =A0written to disk.<br>
3) posix_fadvise POSIX_FADV_DONTNEED on trace packet N-1.<br>
<br>
There are a couple of comments in my consumerd code explaining why we do<br=
>
this sequence of steps:<br>
<br>
=A0 =A0 =A0 =A0 /*<br>
=A0 =A0 =A0 =A0 =A0* Give hints to the kernel about how we access the file:=
<br>
=A0 =A0 =A0 =A0 =A0* POSIX_FADV_DONTNEED : we won&#39;t re-access data in a=
 near future after<br>
=A0 =A0 =A0 =A0 =A0* we write it.<br>
=A0 =A0 =A0 =A0 =A0*<br>
=A0 =A0 =A0 =A0 =A0* We need to call fadvise again after the file grows bec=
ause the<br>
=A0 =A0 =A0 =A0 =A0* kernel does not seem to apply fadvise to non-existing =
parts of the<br>
=A0 =A0 =A0 =A0 =A0* file.<br>
=A0 =A0 =A0 =A0 =A0*<br>
=A0 =A0 =A0 =A0 =A0* Call fadvise _after_ having waited for the page writeb=
ack to<br>
=A0 =A0 =A0 =A0 =A0* complete because the dirty page writeback semantic is =
not well<br>
=A0 =A0 =A0 =A0 =A0* defined. So it can be expected to lead to lower throug=
hput in<br>
=A0 =A0 =A0 =A0 =A0* streaming.<br>
=A0 =A0 =A0 =A0 =A0*/<br>
<br>
Currently, the lttng-consumerd is single-threaded, but we plan to<br>
re-introduce multi-threading, and per-cpu affinity, in a near future.<br>
<br>
Yannick will try your patch tomorrow and report whether it improves<br>
performance or not,<br>
<br>
Thanks!<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Mathieu<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
&gt;<br>
&gt; diff --git a/include/linux/fs.h b/include/linux/fs.h<br>
&gt; index 2c28271..e2bb47e 100644<br>
&gt; --- a/include/linux/fs.h<br>
&gt; +++ b/include/linux/fs.h<br>
&gt; @@ -2176,6 +2176,8 @@ extern int invalidate_partition(struct gendisk *=
, int);<br>
&gt; =A0#endif<br>
&gt; =A0unsigned long invalidate_mapping_pages(struct address_space *mappin=
g,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 pgoff_t start, pgoff_t end);<br>
&gt; +unsigned long invalidate_mapping_pages_check(struct address_space *ma=
pping,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 pgoff_t start, pgoff_t end);<br>
&gt;<br>
&gt; =A0static inline void invalidate_remote_inode(struct inode *inode)<br>
&gt; =A0{<br>
&gt; diff --git a/mm/fadvise.c b/mm/fadvise.c<br>
&gt; index 7e09268..0579e60 100644<br>
&gt; --- a/mm/fadvise.c<br>
&gt; +++ b/mm/fadvise.c<br>
&gt; @@ -122,7 +122,9 @@ SYSCALL_DEFINE(fadvise64_64)(int fd, loff_t offset=
, loff_t len, int advice)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 end_index =3D (endbyte &gt;&gt; PAGE_CACHE=
_SHIFT);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (end_index &gt;=3D start_index) {<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long count =3D inva=
lidate_mapping_pages(mapping,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long nr_remaining;<=
br>
&gt; +<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_remaining =3D invalidate_=
mapping_pages_check(mapping,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 start_index, end_index);<br>
&gt;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*<br>
&gt; @@ -131,7 +133,7 @@ SYSCALL_DEFINE(fadvise64_64)(int fd, loff_t offset=
, loff_t len, int advice)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* a per-cpu pagevec for=
 a remote CPU. Drain all<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* pagevecs and try agai=
n.<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (count &lt; (end_index - =
start_index + 1)) {<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (nr_remaining) {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 lru_add_dr=
ain_all();<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 invalidate=
_mapping_pages(mapping, start_index,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 end_index);<br>
&gt; diff --git a/mm/truncate.c b/mm/truncate.c<br>
&gt; index c75b736..86cfc2e 100644<br>
&gt; --- a/mm/truncate.c<br>
&gt; +++ b/mm/truncate.c<br>
&gt; @@ -312,26 +312,16 @@ void truncate_inode_pages(struct address_space *=
mapping, loff_t lstart)<br>
&gt; =A0}<br>
&gt; =A0EXPORT_SYMBOL(truncate_inode_pages);<br>
&gt;<br>
&gt; -/**<br>
&gt; - * invalidate_mapping_pages - Invalidate all the unlocked pages of on=
e inode<br>
&gt; - * @mapping: the address_space which holds the pages to invalidate<br=
>
&gt; - * @start: the offset &#39;from&#39; which to invalidate<br>
&gt; - * @end: the offset &#39;to&#39; which to invalidate (inclusive)<br>
&gt; - *<br>
&gt; - * This function only removes the unlocked pages, if you want to<br>
&gt; - * remove all the pages of one inode, you must call truncate_inode_pa=
ges.<br>
&gt; - *<br>
&gt; - * invalidate_mapping_pages() will not block on IO activity. It will =
not<br>
&gt; - * invalidate pages which are dirty, locked, under writeback or mappe=
d into<br>
&gt; - * pagetables.<br>
&gt; - */<br>
&gt; -unsigned long invalidate_mapping_pages(struct address_space *mapping,=
<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 pgoff_t start, pgoff_t end)<br>
&gt; +static void __invalidate_mapping_pages(struct address_space *mapping,=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pgoff_t start, pgoff_t end,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 unsigned long *ret_nr_invalidated,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 unsigned long *ret_nr_remaining)<br>
&gt; =A0{<br>
&gt; =A0 =A0 =A0 struct pagevec pvec;<br>
&gt; =A0 =A0 =A0 pgoff_t index =3D start;<br>
&gt; =A0 =A0 =A0 unsigned long ret;<br>
&gt; - =A0 =A0 unsigned long count =3D 0;<br>
&gt; + =A0 =A0 unsigned long nr_invalidated =3D 0;<br>
&gt; + =A0 =A0 unsigned long nr_remaining =3D 0;<br>
&gt; =A0 =A0 =A0 int i;<br>
&gt;<br>
&gt; =A0 =A0 =A0 /*<br>
&gt; @@ -354,8 +344,10 @@ unsigned long invalidate_mapping_pages(struct add=
ress_space *mapping,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (index &gt; end)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;<br>
&gt;<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!trylock_page(page))<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!trylock_page(page)) {<b=
r>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_remaining=
++;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;<=
br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(page-&gt;index !=
=3D index);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D invalidate_inode_p=
age(page);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unlock_page(page);<br>
&gt; @@ -365,17 +357,73 @@ unsigned long invalidate_mapping_pages(struct ad=
dress_space *mapping,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ret)<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 deactivate=
_page(page);<br>
&gt; - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 count +=3D ret;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_remaining=
++;<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 nr_invalidated +=3D ret;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 }<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 pagevec_release(&amp;pvec);<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 mem_cgroup_uncharge_end();<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 cond_resched();<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 index++;<br>
&gt; =A0 =A0 =A0 }<br>
&gt; - =A0 =A0 return count;<br>
&gt; +<br>
&gt; + =A0 =A0 *ret_nr_invalidated =3D nr_invalidated;<br>
&gt; + =A0 =A0 *ret_nr_remaining =3D nr_remaining;<br>
&gt; =A0}<br>
&gt; =A0EXPORT_SYMBOL(invalidate_mapping_pages);<br>
&gt;<br>
&gt; +/**<br>
&gt; + * invalidate_mapping_pages - Invalidate all the unlocked pages of on=
e inode<br>
&gt; + * @mapping: the address_space which holds the pages to invalidate<br=
>
&gt; + * @start: the offset &#39;from&#39; which to invalidate<br>
&gt; + * @end: the offset &#39;to&#39; which to invalidate (inclusive)<br>
&gt; + *<br>
&gt; + * This function only removes the unlocked pages, if you want to<br>
&gt; + * remove all the pages of one inode, you must call truncate_inode_pa=
ges.<br>
&gt; + *<br>
&gt; + * invalidate_mapping_pages() will not block on IO activity. It will =
not<br>
&gt; + * invalidate pages which are dirty, locked, under writeback or mappe=
d into<br>
&gt; + * pagetables.<br>
&gt; + *<br>
&gt; + * Returns the number of pages invalidated<br>
&gt; + */<br>
&gt; +unsigned long invalidate_mapping_pages(struct address_space *mapping,=
<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pgoff_t start, pgoff_t end)<br>
&gt; +{<br>
&gt; + =A0 =A0 unsigned long nr_invalidated, nr_remaining;<br>
&gt; +<br>
&gt; + =A0 =A0 __invalidate_mapping_pages(mapping, start, end,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&amp;=
nr_invalidated, &amp;nr_remaining);<br>
&gt; +<br>
&gt; + =A0 =A0 return nr_invalidated;<br>
&gt; +}<br>
&gt; +<br>
&gt; +/**<br>
&gt; + * invalidate_mapping_pages_check - Invalidate all the unlocked pages=
 of one inode and check for remaining pages.<br>
&gt; + * @mapping: the address_space which holds the pages to invalidate<br=
>
&gt; + * @start: the offset &#39;from&#39; which to invalidate<br>
&gt; + * @end: the offset &#39;to&#39; which to invalidate (inclusive)<br>
&gt; + *<br>
&gt; + * This function only removes the unlocked pages, if you want to<br>
&gt; + * remove all the pages of one inode, you must call truncate_inode_pa=
ges.<br>
&gt; + *<br>
&gt; + * invalidate_mapping_pages() will not block on IO activity. It will =
not<br>
&gt; + * invalidate pages which are dirty, locked, under writeback or mappe=
d into<br>
&gt; + * pagetables.<br>
&gt; + *<br>
&gt; + * Returns the number of pages remaining in the invalidated range<br>
&gt; + */<br>
&gt; +unsigned long invalidate_mapping_pages_check(struct address_space *ma=
pping,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 pgoff_t start, pgoff_t end)<br>
&gt; +{<br>
&gt; + =A0 =A0 unsigned long nr_invalidated, nr_remaining;<br>
&gt; +<br>
&gt; + =A0 =A0 __invalidate_mapping_pages(mapping, start, end,<br>
&gt; + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&amp;=
nr_invalidated, &amp;nr_remaining);<br>
&gt; +<br>
&gt; + =A0 =A0 return nr_remaining;<br>
&gt; +}<br>
&gt; +<br>
&gt; =A0/*<br>
&gt; =A0 * This is like invalidate_complete_page(), except it ignores the p=
age&#39;s<br>
&gt; =A0 * refcount. =A0We do this because invalidate_inode_pages2() needs =
stronger<br>
<br>
</div></div><div class=3D"HOEnZb"><div class=3D"h5">--<br>
Mathieu Desnoyers<br>
EfficiOS Inc.<br>
<a href=3D"http://www.efficios.com" target=3D"_blank">http://www.efficios.c=
om</a><br>
</div></div></blockquote></div><br></div>

--047d7b34363a5d4c5504df902c05--


--===============1376732027==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1376732027==--
