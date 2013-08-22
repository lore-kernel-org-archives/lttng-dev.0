From: Jimmy Durand Wesolowski <jimmy.durand.wesolowski@gmail.com>
Subject: Re: [PATCH 2/2] Add the CFLAGS for an "out of system"
 building of the gen-tp example files.
Date: Thu, 22 Aug 2013 15:28:54 +0200
Message-ID: <CAD7SSK7=ZLdN_MuwO-mpJctN9kzzArg6056T2RUDE4_ZHFmy1A__74.1647826091096$1377178194$gmane$org@mail.gmail.com>
References: <1377160051-12449-1-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<1377160051-12449-3-git-send-email-jimmy.durand.wesolowski@gmail.com>
	<20130822125756.GD26852@Krystal>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1726162358=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f170.google.com ([209.85.216.170])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <jimmy.durand.wesolowski@gmail.com>)
	id 1VCUwe-0000ql-B7
	for lttng-dev@lists.lttng.org; Thu, 22 Aug 2013 09:29:05 -0400
Received: by mail-qc0-f170.google.com with SMTP id i8so981491qcq.29
	for <lttng-dev@lists.lttng.org>; Thu, 22 Aug 2013 06:28:54 -0700 (PDT)
In-Reply-To: <20130822125756.GD26852@Krystal>
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

--===============1726162358==
Content-Type: multipart/alternative; boundary=001a11c2ae6e82a97304e48945e1

--001a11c2ae6e82a97304e48945e1
Content-Type: text/plain; charset=ISO-8859-1

2013/8/22 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

> * Jimmy Durand Wesolowski (jimmy.durand.wesolowski@gmail.com) wrote:
> >  %.o: %.tp %.c %.h
> > -     $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
> > +     CFLAGS="$(AM_CPPFLAGS)" $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $<
>
> The intent behind the examples is that they are installed in
> /usr/share/doc, and should be built both from within the source tree and
> when installed in the system. This dependency on AM_CPPFLAGS does not
> meet this requirement.
>
Actually, the problem was if you add custom CFLAGS (a custom userspace-rcu
location for example), they will not be set here, and thus, the build fails.

Also, you are mixing CPPFLAGS and CFLAGS here.
>
Yes, indeed, it is messy, I will correct this, and send new patches if you
allow
me to.


Thanks,
>
Thank you.
-- 
Jimmy Durand Wesolowski
OpenWide R&D engineer
OneAccess

--001a11c2ae6e82a97304e48945e1
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

&gt; =A0%.o: %.tp %.c %.h<br>
&gt; - =A0 =A0 $(LTTNG_GEN_TP_PATH)lttng-gen-tp -o $@ $&lt;<br>
&gt; + =A0 =A0 CFLAGS=3D&quot;$(AM_CPPFLAGS)&quot; $(LTTNG_GEN_TP_PATH)lttn=
g-gen-tp -o $@ $&lt;<br>
<br>
</div></div>The intent behind the examples is that they are installed in<br=
>
/usr/share/doc, and should be built both from within the source tree and<br=
>
when installed in the system. This dependency on AM_CPPFLAGS does not<br>
meet this requirement.<br></blockquote><div>Actually, the problem was if yo=
u add custom CFLAGS (a custom userspace-rcu</div><div>location for example)=
, they will not be set here, and thus, the build fails.</div><div><br>
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">
Also, you are mixing CPPFLAGS and CFLAGS here.<br></blockquote><div>Yes, in=
deed, it is messy, I will correct this, and send new patches if you allow</=
div><div>me to.=A0</div><div><br></div><div><br></div><blockquote class=3D"=
gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-=
left:1ex">

Thanks,<br></blockquote><div>Thank you.</div></div>-- <br><div dir=3D"ltr">=
Jimmy Durand Wesolowski<br><div>OpenWide R&amp;D engineer<br></div><div>One=
Access</div></div>
</div></div>

--001a11c2ae6e82a97304e48945e1--


--===============1726162358==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1726162358==--
