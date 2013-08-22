From: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Subject: Re: [PATCH 2/2] Add the CFLAGS for an "out of system"
 building of the gen-tp example files.
Date: Thu, 22 Aug 2013 16:42:50 +0200
Message-ID: <CAD7SSK6_JiQYKB0jXiNDOwf2785mWjwwy8gLD96ZZEud4qk0pA__8280.49347405813$1377182627$gmane$org@mail.gmail.com>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<1377160051-12449-3-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125756.GD26852@Krystal>
	<CAD7SSK7=ZLdN_MuwO-mpJctN9kzzArg6056T2RUDE4_ZHFmy1A@mail.gmail.com>
	<20130822134102.GA27342@Krystal>
	<CAD7SSK6WShXTqxzt8HGjKsTqkqo1EOytWom85Kvv4D-OUrmKbA@mail.gmail.com>
	<20130822143925.GA30055@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0058003848=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f54.google.com ([209.85.216.54])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jimmy.durand.wesolowski@gmail.com>)
	id 1VCW6C-0006xQ-BI
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 10:43:00 -0400
Received: by mail-qa0-f54.google.com with SMTP id bv4so359451qab.13
	for <lttng-dev@lists.lttng.org>; Thu, 22 Aug 2013 07:42:50 -0700 (PDT)
In-Reply-To: <20130822143925.GA30055@Krystal>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jimmy Durand Wesolowski <jimmy.durand-wesolowski-ext@oneaccess-net.com>, lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0058003848==
Content-Type: multipart/alternative; boundary=90e6ba1ef6bced40dc04e48a4d1a

--90e6ba1ef6bced40dc04e48a4d1a
Content-Type: text/plain; charset=ISO-8859-1

2013/8/22 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> > 2013/8/22 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >
> > > * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> > > We could keep the CFLAGS/LDFLAGS/CPPFLAGS use as we have currently in
> > > the tree, but also modify doc/examples/Makefile.am so it passes extra
> > > flags (the AM_CFLAGS/AM_LDFLAGS/AM_CPPFLAGS) to the subdirectories when
> > > invoking their respective makefile.
> > >
> > > Therefore, it would not add automake-specific stuff into a Makefile
> that
> > > is meant to be installed in /usr/share/doc.
> > >
> > Oh, OK.
> > Do you want me to add an
> > export CFLAGS
> > export CPPFLAGS
> > export CC
> > in the doc/examples/Makefile.am ?
> > Or add it on the make calling loop if you prefer avoiding exports ?
>
> Ideally in the make calling loop. I think I vaguely remember that export
> were not always supported in automake.
>
OK, I will try to do that this way.


Thanks,
>
Thank you for your advice.
-- 
Jimmy Durand Wesolowski
OpenWide R&D engineer
OneAccess

--90e6ba1ef6bced40dc04e48a4d1a
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">2013/8/22 Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=
=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoy=
ers@efficios.com</a>&gt;</span><br><div class=3D"gmail_extra"><div class=3D=
"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"HOEnZb"><div class=3D"h5">* Ji=
mmy Durand Wesolowski (<a href=3D"mailto:jimmy.durand.wesolowski@gmail.com"=
>jimmy.durand.wesolowski@gmail.com</a>) wrote:<br>

&gt; 2013/8/22 Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
&gt;<br>
&gt; &gt; * Jimmy Durand Wesolowski (<a href=3D"mailto:jimmy.durand.wesolow=
ski@gmail.com">jimmy.durand.wesolowski@gmail.com</a>) wrote:<br>&gt; &gt; W=
e could keep the CFLAGS/LDFLAGS/CPPFLAGS use as we have currently in<br>

&gt; &gt; the tree, but also modify doc/examples/Makefile.am so it passes e=
xtra<br>
&gt; &gt; flags (the AM_CFLAGS/AM_LDFLAGS/AM_CPPFLAGS) to the subdirectorie=
s when<br>
&gt; &gt; invoking their respective makefile.<br>
&gt; &gt;<br>
&gt; &gt; Therefore, it would not add automake-specific stuff into a Makefi=
le that<br>
&gt; &gt; is meant to be installed in /usr/share/doc.<br>
&gt; &gt;<br>
&gt; Oh, OK.<br>
&gt; Do you want me to add an<br>
&gt; export CFLAGS<br>
&gt; export CPPFLAGS<br>
&gt; export CC<br>
&gt; in the doc/examples/Makefile.am ?<br>
&gt; Or add it on the make calling loop if you prefer avoiding exports ?<br=
>
<br>
</div></div>Ideally in the make calling loop. I think I vaguely remember th=
at export<br>
were not always supported in automake.<br></blockquote><div>OK, I will try =
to do that this way.</div><div><br></div><div><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">

Thanks,<br></blockquote><div>Thank you for your advice.</div></div>-- <br><=
div dir=3D"ltr">Jimmy Durand Wesolowski<br><div>OpenWide R&amp;D engineer<b=
r></div><div>OneAccess</div></div>
</div></div>

--90e6ba1ef6bced40dc04e48a4d1a--


--===============0058003848==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0058003848==--
