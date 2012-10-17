From: "Brosseau, Yannick" <yannick.brosseau@gmail.com>
Subject: Re: are LTTng-2.0 packages available on Fedora 16 via
	yum?
Date: Wed, 17 Oct 2012 13:35:55 -0400
Message-ID: <CAEzWAeLTofn2_5BS5vUo7zWp__2HZK3FpOeykw6FKj+=ns5wXw__12680.9997753755$1350495397$gmane$org@mail.gmail.com>
References: <7F632A9222059A42AF70FCB7965774AA2063D880@ALA-MBB.corp.ad.wrs.com>
	<507EDE5B.8090102@redhat.com>
	<7F632A9222059A42AF70FCB7965774AA2063E902@ALA-MBB.corp.ad.wrs.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1904495182=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qc0-f176.google.com ([209.85.216.176])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <yannick.brosseau@gmail.com>) id 1TOXXG-0000VV-Be
	for lttng-dev@lists.lttng.org; Wed, 17 Oct 2012 13:36:02 -0400
Received: by mail-qc0-f176.google.com with SMTP id n41so7318028qco.35
	for <lttng-dev@lists.lttng.org>; Wed, 17 Oct 2012 10:35:55 -0700 (PDT)
In-Reply-To: <7F632A9222059A42AF70FCB7965774AA2063E902@ALA-MBB.corp.ad.wrs.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "McDermott, Andrew" <Andrew.McDermott@windriver.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1904495182==
Content-Type: multipart/alternative; boundary=20cf300512b2f4c25004cc44b3c8

--20cf300512b2f4c25004cc44b3c8
Content-Type: text/plain; charset=ISO-8859-1

Josh is right.  With the release of f18 soon, I not sure I could add f16,
but I can check if necessary...
On Oct 17, 2012 1:28 PM, "McDermott, Andrew" <Andrew.McDermott@windriver.com>
wrote:

>  Hi,
>
> (resending, as I neglected to CC the list...)
>
> On 10/17/2012 04:32 AM, McDermott, Andrew wrote:
>
> I'm happily using LTTng-2.0 on Ubuntu-12.04 but I was wondering if
> Fedora 16 is supported via a yum install.  I see quite a few references
> to 17 but not necessarily 16.  Is this correct or am I simply not
> searching hard enough.
>
>
> You can see which packages are available anywhere in Fedora here:
> https://apps.fedoraproject.org/packages/lttng-tools
> https://apps.fedoraproject.org/packages/lttng-ust
>
> They were just added to Fedora in July, and at that time Yannick only
> requested to add f17, so that's why f16 doesn't have them.
> https://bugzilla.redhat.com/show_bug.cgi?id=717748#c20
> https://bugzilla.redhat.com/show_bug.cgi?id=834481#c4
>
>
>  Thanks; that helps clear things up.
>
>  --
> andy
>
>
>
> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev
>
>

--20cf300512b2f4c25004cc44b3c8
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">Josh is right.=A0 With the release of f18 soon, I not sure I=
 could add f16, but I can check if necessary... </p>
<div class=3D"gmail_quote">On Oct 17, 2012 1:28 PM, &quot;McDermott, Andrew=
&quot; &lt;<a href=3D"mailto:Andrew.McDermott@windriver.com">Andrew.McDermo=
tt@windriver.com</a>&gt; wrote:<br type=3D"attribution"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">




<div style=3D"word-wrap:break-word">
Hi,
<div>
<div><br>
<blockquote type=3D"cite">(resending, as I neglected to CC the list...)<br>
<br>
On 10/17/2012 04:32 AM, McDermott, Andrew wrote:<br>
<blockquote type=3D"cite">I&#39;m happily using LTTng-2.0 on Ubuntu-12.04 b=
ut I was wondering if<br>
Fedora 16 is supported via a yum install. =A0I see quite a few references<b=
r>
to 17 but not necessarily 16. =A0Is this correct or am I simply not<br>
searching hard enough.<br>
</blockquote>
<br>
You can see which packages are available anywhere in Fedora here:<br>
<a href=3D"https://apps.fedoraproject.org/packages/lttng-tools" target=3D"_=
blank">https://apps.fedoraproject.org/packages/lttng-tools</a><br>
<a href=3D"https://apps.fedoraproject.org/packages/lttng-ust" target=3D"_bl=
ank">https://apps.fedoraproject.org/packages/lttng-ust</a><br>
<br>
They were just added to Fedora in July, and at that time Yannick only<br>
requested to add f17, so that&#39;s why f16 doesn&#39;t have them.<br>
<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D717748#c20" target=
=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D717748#c20</a><br=
>
<a href=3D"https://bugzilla.redhat.com/show_bug.cgi?id=3D834481#c4" target=
=3D"_blank">https://bugzilla.redhat.com/show_bug.cgi?id=3D834481#c4</a><br>
</blockquote>
<div><br>
</div>
Thanks; that helps clear things up.</div>
<div><br>
</div>
<div>--=A0</div>
<div>andy</div>
<div><br>
</div>
<br>
</div>
</div>

<br>_______________________________________________<br>
lttng-dev mailing list<br>
<a href=3D"mailto:lttng-dev@lists.lttng.org">lttng-dev@lists.lttng.org</a><=
br>
<a href=3D"http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev" targe=
t=3D"_blank">http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev</a><=
br>
<br></blockquote></div>

--20cf300512b2f4c25004cc44b3c8--


--===============1904495182==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1904495182==--
