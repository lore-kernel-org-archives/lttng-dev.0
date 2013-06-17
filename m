From: =?ISO-8859-1?Q?Rapha=EBl_Beamonte?= <raphael.beamonte@gmail.com>
Subject: Re: [-stable 3.8.1 performance regression] madvise
	POSIX_FADV_DONTNEED
Date: Mon, 17 Jun 2013 17:39:36 -0400
Message-ID: <CAE_Gge34HCroSgNgiXL1j7Le3CNKRXR=7TZQhJSmY+wfWniKug__5864.23828867755$1371505237$gmane$org@mail.gmail.com>
References: <51BE1828.3060206@gmail.com> <20130617141357.GA6034@Krystal>
	<20130617142459.1d563072231ba269cdac8f11@linux-foundation.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2058649376=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-oa0-f50.google.com ([209.85.219.50])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <nashii@gmail.com>) id 1Uoh9e-0004pJ-LZ
	for lttng-dev@lists.lttng.org; Mon, 17 Jun 2013 17:40:02 -0400
Received: by mail-oa0-f50.google.com with SMTP id k7so4093133oag.37
	for <lttng-dev@lists.lttng.org>; Mon, 17 Jun 2013 14:39:56 -0700 (PDT)
In-Reply-To: <20130617142459.1d563072231ba269cdac8f11@linux-foundation.org>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Mel Gorman <mgorman@suse.de>, Rob van der Heij <rvdheij@gmail.com>
List-Id: lttng-dev@lists.lttng.org

--===============2058649376==
Content-Type: multipart/alternative; boundary=089e0112cbc20e7f6004df60704a

--089e0112cbc20e7f6004df60704a
Content-Type: text/plain; charset=ISO-8859-1

2013/6/17 Andrew Morton <akpm@linux-foundation.org>

> That change wasn't terribly efficient - if there are any unpopulated
> pages in the range (which is quite likely), fadvise() will now always
> call invalidate_mapping_pages() a second time.
>
> Perhaps this is fixable.  Say, make lru_add_drain_all() return a
> success code, or even teach lru_add_drain_all() to return a code
> indicating that one of the spilled pages was (or might have been) on a
> particular mapping.
>

Following our tests results, that was the call to lru_add_drain_all() that
causes the problem. The second call to invalidate_mapping_pages() isn't
really important. We tried to compile a kernel with the commit introducing
this change but with the "lru_add_drain_all()" line removed, and the
problem disappeared, even if we called two times invalidate_mapping_pages()
(as the rest of the commit was still here).


> But I don't see why that would cause fadvise(POSIX_FADV_DONTNEED) to
> sometimes take four milliseconds(!).  Is it possible that a context
> switch is now occurring, so the fadvise()-calling task sometimes spends
> a few milliseconds asleep?
>

--089e0112cbc20e7f6004df60704a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div class=3D"gmail_quote">2013/6/17 Andrew Morton <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:akpm@linux-foundation.org" target=3D"_blank">akpm@linux-fou=
ndation.org</a>&gt;</span><br><blockquote class=3D"gmail_quote" style=3D"ma=
rgin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">

That change wasn&#39;t terribly efficient - if there are any unpopulated<br=
>
pages in the range (which is quite likely), fadvise() will now always<br>
call invalidate_mapping_pages() a second time.<br>
<br>
Perhaps this is fixable. =A0Say, make lru_add_drain_all() return a<br>
success code, or even teach lru_add_drain_all() to return a code<br>
indicating that one of the spilled pages was (or might have been) on a<br>
particular mapping.<br></blockquote><div><br>Following our tests results, t=
hat was the call to lru_add_drain_all() that causes the problem. The second=
 call to invalidate_mapping_pages() isn&#39;t really important. We tried to=
 compile a kernel with the commit introducing this change but with the &quo=
t;lru_add_drain_all()&quot; line removed, and the problem disappeared, even=
 if we called two times invalidate_mapping_pages() (as the rest of the comm=
it was still here).<br>

=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex">
But I don&#39;t see why that would cause fadvise(POSIX_FADV_DONTNEED) to<br=
>
sometimes take four milliseconds(!). =A0Is it possible that a context<br>
switch is now occurring, so the fadvise()-calling task sometimes spends<br>
a few milliseconds asleep?<br></blockquote><div><br><br></div></div>

--089e0112cbc20e7f6004df60704a--


--===============2058649376==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2058649376==--
