From: Jan Glauber <jan.glauber@gmail.com>
Subject: Re: [PATCH lttng-tools v3 0/4] Dynamic probe list
	support
Date: Thu, 15 May 2014 08:31:25 +0200
Message-ID: <CAEiAFz1-Lp9dq_TSTy7VekK6pbMiNkLFPm_OG9QR5=nJdRqU6w__18833.765658974$1400135540$gmane$org@mail.gmail.com>
References: <cover.1400077421.git.jan.glauber@gmail.com>
 <20140514204730.GD15072@dalia>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1309077306=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <jan.glauber@gmail.com>) id 1WkpCV-0007hJ-Bd
 for lttng-dev@lists.lttng.org; Thu, 15 May 2014 02:31:35 -0400
Received: by mail-qg0-f47.google.com with SMTP id j107so996246qga.20
 for <lttng-dev@lists.lttng.org>; Wed, 14 May 2014 23:31:25 -0700 (PDT)
In-Reply-To: <20140514204730.GD15072@dalia>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: David Goulet <dgoulet@efficios.com>
Cc: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============1309077306==
Content-Type: multipart/alternative; boundary=089e01537222442b1404f96a72d7

--089e01537222442b1404f96a72d7
Content-Type: text/plain; charset=UTF-8

Thanks David! I've had the impression that LTTng follows kernel coding
style but it diverts on the if/else case.
Personaly I don't buy the {} is better argument, but I'll try to remember
your preference :)

If you could help me a bit with the config file syntax I'll be happy to add
support for it.
What would help me is a working example with all the required values. As I
said
an empty config file did not work for me, so there seems to be some
required options and I was not able to
figure them out.

Cheers,
Jan


2014-05-14 22:47 GMT+02:00 David Goulet <dgoulet@efficios.com>:

> Merged!
>
> I merged it with some minor syntax fixes mostly in modprobe.c. There is
> one thing I don't accept at all is if/else without {}. Remember the goto
> fail; bug :).
>
> Anyhow, I fixed them to fit my OCD if/else issue. ;)
>
> Big thanks for that, this is really great! I would love to improve that
> with support in the "lttng" command line that could take a list and
> spawn the sessiond with it. Also, the configuration file coming in 2.5
> (currently in master).
>
> Cheers!
> David
>
> On 14 May (16:26:28), Jan Glauber wrote:
> > Hi David,
> >
> > here are the rebased patches (onto 88564da). There are no functional
> > changes to the previous version.
> >
> > Jan Glauber (4):
> >   Use common functions for module loading and unloading
> >   Seperate probe modules from control modules
> >   Remove required parameter from module parameters
> >   Configurable kernel module probes support
> >
> >  doc/man/lttng-sessiond.8              |    7 +
> >  src/bin/lttng-sessiond/kern-modules.h |    3 +-
> >  src/bin/lttng-sessiond/main.c         |    5 +
> >  src/bin/lttng-sessiond/modprobe.c     |  307
> ++++++++++++++++++---------------
> >  src/bin/lttng-sessiond/modprobe.h     |    2 +
> >  src/common/defaults.h                 |    3 +
> >  src/common/utils.c                    |   10 ++
> >  src/common/utils.h                    |    1 +
> >  8 files changed, 200 insertions(+), 138 deletions(-)
> >
> > --
> > 1.7.9.5
> >
>

--089e01537222442b1404f96a72d7
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div>Thanks David! I&#39;ve had t=
he impression that LTTng follows kernel coding style but it diverts on the =
if/else case.<br></div>Personaly I don&#39;t buy the {} is better argument,=
 but I&#39;ll try to remember your preference :)<br>
<br></div>If you could help me a bit with the config file syntax I&#39;ll b=
e happy to add support for it.<br></div>What would help me is a working exa=
mple with all the required values. As I said<br></div>an empty config file =
did not work for me, so there seems to be some required options and I was n=
ot able to<br>
</div>figure them out.<br><br></div>Cheers,<br>Jan<br></div><div class=3D"g=
mail_extra"><br><br><div class=3D"gmail_quote">2014-05-14 22:47 GMT+02:00 D=
avid Goulet <span dir=3D"ltr">&lt;<a href=3D"mailto:dgoulet@efficios.com" t=
arget=3D"_blank">dgoulet@efficios.com</a>&gt;</span>:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">Merged!<br>
<br>
I merged it with some minor syntax fixes mostly in modprobe.c. There is<br>
one thing I don&#39;t accept at all is if/else without {}. Remember the got=
o<br>
fail; bug :).<br>
<br>
Anyhow, I fixed them to fit my OCD if/else issue. ;)<br>
<br>
Big thanks for that, this is really great! I would love to improve that<br>
with support in the &quot;lttng&quot; command line that could take a list a=
nd<br>
spawn the sessiond with it. Also, the configuration file coming in 2.5<br>
(currently in master).<br>
<br>
Cheers!<br>
<span class=3D"HOEnZb"><font color=3D"#888888">David<br>
</font></span><div class=3D"HOEnZb"><div class=3D"h5"><br>
On 14 May (16:26:28), Jan Glauber wrote:<br>
&gt; Hi David,<br>
&gt;<br>
&gt; here are the rebased patches (onto 88564da). There are no functional<b=
r>
&gt; changes to the previous version.<br>
&gt;<br>
&gt; Jan Glauber (4):<br>
&gt; =C2=A0 Use common functions for module loading and unloading<br>
&gt; =C2=A0 Seperate probe modules from control modules<br>
&gt; =C2=A0 Remove required parameter from module parameters<br>
&gt; =C2=A0 Configurable kernel module probes support<br>
&gt;<br>
&gt; =C2=A0doc/man/lttng-sessiond.8 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0| =C2=A0 =C2=A07 +<br>
&gt; =C2=A0src/bin/lttng-sessiond/kern-modules.h | =C2=A0 =C2=A03 +-<br>
&gt; =C2=A0src/bin/lttng-sessiond/main.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 | =C2=
=A0 =C2=A05 +<br>
&gt; =C2=A0src/bin/lttng-sessiond/modprobe.c =C2=A0 =C2=A0 | =C2=A0307 ++++=
++++++++++++++---------------<br>
&gt; =C2=A0src/bin/lttng-sessiond/modprobe.h =C2=A0 =C2=A0 | =C2=A0 =C2=A02=
 +<br>
&gt; =C2=A0src/common/defaults.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 | =C2=A0 =C2=A03 +<br>
&gt; =C2=A0src/common/utils.c =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 10 ++<br>
&gt; =C2=A0src/common/utils.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0| =C2=A0 =C2=A01 +<br>
&gt; =C2=A08 files changed, 200 insertions(+), 138 deletions(-)<br>
&gt;<br>
&gt; --<br>
&gt; 1.7.9.5<br>
&gt;<br>
</div></div></blockquote></div><br></div>

--089e01537222442b1404f96a72d7--


--===============1309077306==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1309077306==--
