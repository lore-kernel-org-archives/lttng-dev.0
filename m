From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Support for new arch 'ppc64le'
Date: Tue, 11 Mar 2014 19:28:29 +0000 (UTC)
Message-ID: <796190728.353.1394566108995.JavaMail.zimbra__38517.3543160365$1394566173$gmane$org@efficios.com>
References: <5313D494.5040508@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0585677965=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail.efficios.com ([78.47.125.74])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <compudj@efficios.com>) id 1WNSLn-0006nA-IC
	for lttng-dev@lists.lttng.org; Tue, 11 Mar 2014 15:28:39 -0400
In-Reply-To: <5313D494.5040508@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: ravi <ravi@linux.vnet.ibm.com>
Cc: lttng-dev@lists.lttng.org, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
List-Id: lttng-dev@lists.lttng.org

--===============0585677965==
Content-Type: multipart/alternative;
	boundary="----=_Part_352_2122870798.1394566108994"

------=_Part_352_2122870798.1394566108994
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

----- Original Message -----

> From: "ravi" <ravi@linux.vnet.ibm.com>
> To: lttng-dev@lists.lttng.org
> Sent: Sunday, March 2, 2014 8:02:12 PM
> Subject: [lttng-dev] Support for new arch 'ppc64le'

> Hi,

> We are in the process of adding support for new architecture 'ppc64le'
> (PowerPC 64 Little Endian) and as part of that, We have worked with libtool
> maintainer to get alpha release (links below) which has all the needed bits
> to support building on ppc64le arch.
> ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.gz(1.6MB)
> ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.418.tar.xz(920KB)
> (A stable libtool release is expected soon this year)

> ' userspace-rcu-0.8.1' didn't build on 'ppc64le' system because of outdated
> libtoo.m4/config.guess files.
> Latest ' liburcu' source package we picked is from :
> http://lttng.org/files/urcu/userspace-rcu-0.8.1.tar.bz2

> Along with changes to libtool related files, we have found a patch available
> in ubuntu src repo, which is required to build 'liburcu' successfully on
> 'ppc64le' system.
> Im attaching the same patch which is created on top of "liburcu-0.7.7-1"...

> hence we request you to apply attached patch , and spin off a new version of
> 'liburcu' using the latest libtool alpha release . So that we can test
> ppc64le fixes.
> Your response is highly appreciated
Hi, 

I see that the patch you propose adds both "powerpc64le" and "aarch64" entries. Why are there two of them ? 

Moreover, it might be a bit aggressive to package the liburcu tarballs with an alpha version of libtool. When we 
understand more about the need for one or two specific entries into the configure.ac of liburcu, then we can add 
them, but until there is a stable version of libtool supporting those, you will probably have to create your own 
tarballs from the userspace RCU git repository using "make dist" against your alpha libtool. 

Thoughts ? 

Thanks, 

Mathieu 

> --
> Ravindran
> IBM LinuxTechnologyCenter

> _______________________________________________
> lttng-dev mailing list
> lttng-dev@lists.lttng.org
> http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

-- 
Mathieu Desnoyers 
EfficiOS Inc. 
http://www.efficios.com 

------=_Part_352_2122870798.1394566108994
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: times new roman, new york, times, se=
rif; font-size: 12pt; color: #000000"><hr id=3D"zwchr"><blockquote style=3D=
"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;=
font-weight:normal;font-style:normal;text-decoration:none;font-family:Helve=
tica,Arial,sans-serif;font-size:12pt;"><b>From: </b>"ravi" &lt;ravi@linux.v=
net.ibm.com&gt;<br><b>To: </b>lttng-dev@lists.lttng.org<br><b>Sent: </b>Sun=
day, March 2, 2014 8:02:12 PM<br><b>Subject: </b>[lttng-dev] Support for ne=
w arch 'ppc64le'<br><div><br></div>
 =20

   =20
 =20
 =20
    Hi,
    <br><br>
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; We are in the process of adding su=
pport for new architecture
    'ppc64le' (PowerPC 64 Little Endian) and as part of that, We have
    worked with libtool maintainer to get alpha release (links below)
    which has all the needed bits to support building on ppc64le arch.
    <br><a class=3D"moz-txt-link-freetext" href=3D"ftp://alpha.gnu.org/gnu/=
libtool/libtool-2.4.2.418.tar.gz%281.6MB%29" target=3D"_blank">ftp://alpha.=
gnu.org/gnu/libtool/libtool-2.4.2.418.tar.gz(1.6MB)</a><br><a class=3D"moz-=
txt-link-freetext" href=3D"ftp://alpha.gnu.org/gnu/libtool/libtool-2.4.2.41=
8.tar.xz%28920KB%29" target=3D"_blank">ftp://alpha.gnu.org/gnu/libtool/libt=
ool-2.4.2.418.tar.xz(920KB)</a><br>
    (A stable libtool release is expected soon this year)
    <br><br>
    '&nbsp;
   =20
    userspace-rcu-0.8.1' didn't build on 'ppc64le' system because of
    outdated libtoo.m4/config.guess files.
    <br>
    Latest '
   =20
    liburcu' source package we picked is from :
    <a class=3D"moz-txt-link-freetext" href=3D"http://lttng.org/files/urcu/=
userspace-rcu-0.8.1.tar.bz2" target=3D"_blank">http://lttng.org/files/urcu/=
userspace-rcu-0.8.1.tar.bz2</a><br><br>
    Along with changes to libtool related files,&nbsp; we have found a patc=
h
    available in ubuntu src repo, which is required to build 'liburcu'
    successfully on 'ppc64le' system.
    <br>
    Im attaching the same patch which is created on top of
    "liburcu-0.7.7-1"...<br><br>
    hence we request you to apply attached patch , and spin off a new
    version of 'liburcu' using the latest libtool alpha release .&nbsp;
    So that we can test ppc64le fixes.
    <br>
    Your response is highly appreciated
    </blockquote><div>Hi,<br></div><div><br></div><div>I see that the patch=
 you propose adds both "powerpc64le" and "aarch64" entries. Why are there t=
wo of them ?<br></div><div><br></div><div>Moreover, it might be a bit aggre=
ssive to package the liburcu tarballs with an alpha version of libtool. Whe=
n we<br></div><div>understand more about the need for one or two specific e=
ntries into the configure.ac of liburcu, then we can add<br></div><div>them=
, but until there is a stable version of libtool supporting those, you will=
 probably have to create your own<br></div><div>tarballs from the userspace=
 RCU git repository using "make dist" against your alpha libtool.<br></div>=
<div><br></div><div>Thoughts ?<br></div><div><br></div><div>Thanks,<br></di=
v><div><br></div><div>Mathieu<br></div><div><br></div><blockquote style=3D"=
border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;f=
ont-weight:normal;font-style:normal;text-decoration:none;font-family:Helvet=
ica,Arial,sans-serif;font-size:12pt;"><pre class=3D"moz-signature">--=20
Ravindran
IBM LinuxTechnologyCenter</pre><br>________________________________________=
_______<br>lttng-dev mailing list<br>lttng-dev@lists.lttng.org<br>http://li=
sts.lttng.org/cgi-bin/mailman/listinfo/lttng-dev<br></blockquote><div><br><=
br></div><div><br></div><div>-- <br></div><div><span name=3D"x"></span>Math=
ieu Desnoyers<br>EfficiOS Inc.<br>http://www.efficios.com<span name=3D"x"><=
/span><br></div></div></body></html>
------=_Part_352_2122870798.1394566108994--


--===============0585677965==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0585677965==--
