From: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Subject: Re: [PATCH 2/2] Add the CFLAGS for an "out of system"
 building of the gen-tp example files.
Date: Thu, 22 Aug 2013 16:04:13 +0200
Message-ID: <CAD7SSK6WShXTqxzt8HGjKsTqkqo1EOytWom85Kvv4D-OUrmKbA__32085.6248298243$1377180307$gmane$org@mail.gmail.com>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<1377160051-12449-3-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125756.GD26852@Krystal>
	<CAD7SSK7=ZLdN_MuwO-mpJctN9kzzArg6056T2RUDE4_ZHFmy1A@mail.gmail.com>
	<20130822134102.GA27342@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1530584721=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jimmy.durand.wesolowski@gmail.com>)
	id 1VCVUp-0003nB-QK
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 10:04:23 -0400
Received: by mail-qa0-f44.google.com with SMTP id hu16so325607qab.17
	for <lttng-dev@lists.lttng.org>; Thu, 22 Aug 2013 07:04:13 -0700 (PDT)
In-Reply-To: <20130822134102.GA27342@Krystal>
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

--===============1530584721==
Content-Type: multipart/alternative; boundary=001a11c2ae6ecf5d9204e489c35d

--001a11c2ae6ecf5d9204e489c35d
Content-Type: text/plain; charset=ISO-8859-1

2013/8/22 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> > 2013/8/22 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> >
> > > * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> > > >  %.o: %.tp %.c %.h
> > > > -     $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
> > > > +     CFLAGS="$(AM_CPPFLAGS)" $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@
> $<
> > >
> > > The intent behind the examples is that they are installed in
> > > /usr/share/doc, and should be built both from within the source tree
> and
> > > when installed in the system. This dependency on AM_CPPFLAGS does not
> > > meet this requirement.
> > >
> > Actually, the problem was if you add custom CFLAGS (a custom
> userspace-rcu
> > location for example), they will not be set here, and thus, the build
> fails.
>
> I understand that we might need to fix something, but I think this is
> not done at the right level in your patches.
>
> We could keep the CFLAGS/LDFLAGS/CPPFLAGS use as we have currently in
> the tree, but also modify doc/examples/Makefile.am so it passes extra
> flags (the AM_CFLAGS/AM_LDFLAGS/AM_CPPFLAGS) to the subdirectories when
> invoking their respective makefile.
>
> Therefore, it would not add automake-specific stuff into a Makefile that
> is meant to be installed in /usr/share/doc.
>
Oh, OK.
Do you want me to add an
export CFLAGS
export CPPFLAGS
export CC
in the doc/examples/Makefile.am ?
Or add it on the make calling loop if you prefer avoiding exports ?

This would allow no AM_* reference in a generic Makefile.


Thanks,
>
Thank you.
-- 
Jimmy Durand Wesolowski
OpenWide R&D engineer
OneAccess

--001a11c2ae6ecf5d9204e489c35d
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">2013/8/22 Mathieu Desnoyers <span dir=3D"ltr">&lt;<a href=
=3D"mailto:mathieu.desnoyers@efficios.com" target=3D"_blank">mathieu.desnoy=
ers@efficios.com</a>&gt;</span><br><div class=3D"gmail_extra"><div class=3D=
"gmail_quote">
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">* Jimmy Durand Wesolowski =
(<a href=3D"mailto:jimmy.durand.wesolowski@gmail.com">jimmy.durand.wesolows=
ki@gmail.com</a>) wrote:<br>

&gt; 2013/8/22 Mathieu Desnoyers &lt;<a href=3D"mailto:mathieu.desnoyers@ef=
ficios.com">mathieu.desnoyers@efficios.com</a>&gt;<br>
&gt;<br>
&gt; &gt; * Jimmy Durand Wesolowski (<a href=3D"mailto:jimmy.durand.wesolow=
ski@gmail.com">jimmy.durand.wesolowski@gmail.com</a>) wrote:<br>
&gt; &gt; &gt; =A0%.o: %.tp %.c %.h<br>
&gt; &gt; &gt; - =A0 =A0 $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $&lt;<br>
&gt; &gt; &gt; + =A0 =A0 CFLAGS=3D&quot;$(AM_CPPFLAGS)&quot; $(LTTNG_GEN_TP=
_PATH)lttng-gen-tp -o $@ $&lt;<br>
&gt; &gt;<br>
&gt; &gt; The intent behind the examples is that they are installed in<br>
&gt; &gt; /usr/share/doc, and should be built both from within the source t=
ree and<br>
&gt; &gt; when installed in the system. This dependency on AM_CPPFLAGS does=
 not<br>
&gt; &gt; meet this requirement.<br>
&gt; &gt;<br>
&gt; Actually, the problem was if you add custom CFLAGS (a custom userspace=
-rcu<br>
&gt; location for example), they will not be set here, and thus, the build =
fails.<br>
<br>
</div>I understand that we might need to fix something, but I think this is=
<br>
not done at the right level in your patches.<br>
<br>
We could keep the CFLAGS/LDFLAGS/CPPFLAGS use as we have currently in<br>
the tree, but also modify doc/examples/Makefile.am so it passes extra<br>
flags (the AM_CFLAGS/AM_LDFLAGS/AM_CPPFLAGS) to the subdirectories when<br>
invoking their respective makefile.<br>
<br>
Therefore, it would not add automake-specific stuff into a Makefile that<br=
>
is meant to be installed in /usr/share/doc.<br></blockquote><div>Oh, OK.</d=
iv><div>Do you want me to add an</div><div>export CFLAGS</div><div>export C=
PPFLAGS</div><div>export CC</div><div>in the doc/examples/Makefile.am ?</di=
v>
<div>Or add it on the make calling loop if you prefer avoiding exports ?<br=
></div><div><br></div><div>This would allow no AM_* reference in a generic =
Makefile.</div><div><br></div><div><br></div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"=
>

Thanks,<br></blockquote><div>Thank you.</div></div>-- <br><div dir=3D"ltr">=
Jimmy Durand Wesolowski<br><div>OpenWide R&amp;D engineer<br></div><div>One=
Access</div></div>
</div></div>

--001a11c2ae6ecf5d9204e489c35d--


--===============1530584721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1530584721==--
