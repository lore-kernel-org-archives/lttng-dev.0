From: Eduardo Silva <edsiper@gmail.com>
Subject: Re: Centos 6.x packages ?
Date: Wed, 26 Feb 2014 23:04:22 -0600
Message-ID: <CAMAQheN-UNhbyw0r_mMQa=O=aWvka=+oLjHWwxehJvUCitEtoA__7845.21254613555$1393477508$gmane$org@mail.gmail.com>
References: <CAMAQhePXxjfKHVrBz0yipy1JgOt1qV00UFFS6sojaHRsGuou5w@mail.gmail.com>
	<1393477363.530ec6f31af30@www.imp.polymtl.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0555587446=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f180.google.com ([209.85.220.180])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <edsiper@gmail.com>) id 1WIt92-0001yk-Iq
	for lttng-dev@lists.lttng.org; Thu, 27 Feb 2014 00:04:29 -0500
Received: by mail-vc0-f180.google.com with SMTP id ks9so1954268vcb.39
	for <lttng-dev@lists.lttng.org>; Wed, 26 Feb 2014 21:04:23 -0800 (PST)
In-Reply-To: <1393477363.530ec6f31af30@www.imp.polymtl.ca>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Suchakrapani Datt Sharma <suchakrapani.sharma@polymtl.ca>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============0555587446==
Content-Type: multipart/alternative; boundary=bcaec51d2eb82e80df04f35c416f

--bcaec51d2eb82e80df04f35c416f
Content-Type: text/plain; charset=ISO-8859-1

thanks folks!, i will try those...

regards,


On Wed, Feb 26, 2014 at 11:02 PM, Suchakrapani Datt Sharma <
suchakrapani.sharma@polymtl.ca> wrote:

> Hi,
>
> > is there any Centos 6.x packages around ?
>
> I don't think there are 'official' CentOS 6 packages. There are, however,
> packages built for EPEL 6. Have a look at [1] and [2] for lttng-tools and
> lttng-ust. Find other lttng related packages on the package app [3]. So,
> you
> have 2 choices now:
>
> 1. You can maybe try to enable EPEL repos on CentOS 6. Refer [4]. This
> should
> generally work.
> 2. You can also rebuild packages from the source RPMs [5]. This is the
> long way
> though and you are on your own for any future maintenance
>
> [1] https://apps.fedoraproject.org/packages/lttng-tools
> [2] https://apps.fedoraproject.org/packages/lttng-ust
> [3]
>
> http://www.rackspace.com/knowledge_center/article/installing-rhel-epel-repo-on-centos-5x-or-6x
> [4] http://wiki.centos.org/HowTos/RebuildSRPM
>
> Best of luck!
>
> --
> Suchakra
>



-- 
Eduardo Silva
http://edsiper.linuxchile.cl
http://monkey-project.com

--bcaec51d2eb82e80df04f35c416f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">thanks folks!, i will try those...<div><br></div><div>rega=
rds,=A0</div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_q=
uote">On Wed, Feb 26, 2014 at 11:02 PM, Suchakrapani Datt Sharma <span dir=
=3D"ltr">&lt;<a href=3D"mailto:suchakrapani.sharma@polymtl.ca" target=3D"_b=
lank">suchakrapani.sharma@polymtl.ca</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"">Hi,<br>
<br>
&gt; is there any Centos 6.x packages around ?<br>
<br>
</div>I don&#39;t think there are &#39;official&#39; CentOS 6 packages. The=
re are, however,<br>
packages built for EPEL 6. Have a look at [1] and [2] for lttng-tools and<b=
r>
lttng-ust. Find other lttng related packages on the package app [3]. So, yo=
u<br>
have 2 choices now:<br>
<br>
1. You can maybe try to enable EPEL repos on CentOS 6. Refer [4]. This shou=
ld<br>
generally work.<br>
2. You can also rebuild packages from the source RPMs [5]. This is the long=
 way<br>
though and you are on your own for any future maintenance<br>
<br>
[1] <a href=3D"https://apps.fedoraproject.org/packages/lttng-tools" target=
=3D"_blank">https://apps.fedoraproject.org/packages/lttng-tools</a><br>
[2] <a href=3D"https://apps.fedoraproject.org/packages/lttng-ust" target=3D=
"_blank">https://apps.fedoraproject.org/packages/lttng-ust</a><br>
[3]<br>
<a href=3D"http://www.rackspace.com/knowledge_center/article/installing-rhe=
l-epel-repo-on-centos-5x-or-6x" target=3D"_blank">http://www.rackspace.com/=
knowledge_center/article/installing-rhel-epel-repo-on-centos-5x-or-6x</a><b=
r>

[4] <a href=3D"http://wiki.centos.org/HowTos/RebuildSRPM" target=3D"_blank"=
>http://wiki.centos.org/HowTos/RebuildSRPM</a><br>
<br>
Best of luck!<br>
<br>
--<br>
Suchakra<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr">Eduardo Silva<br><a href=3D"http://edsiper.linuxchile.cl" target=3D"_b=
lank">http://edsiper.linuxchile.cl</a><br><a href=3D"http://monkey-project.=
com" target=3D"_blank">http://monkey-project.com</a></div>

</div>

--bcaec51d2eb82e80df04f35c416f--


--===============0555587446==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0555587446==--
