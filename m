From: Krishanth TJ <krishanthtj@gmail.com>
Subject: Re: Lttng state dump traces not present in 13.04 Ubuntu
 server distribution
Date: Fri, 24 Jan 2014 19:24:26 +0530
Message-ID: <CAAoqFdRZaoLW_r2bdaZvU+wwMtMS1nHuBNkumznqRY-_yOPh6g__27922.2128833228$1390571750$gmane$org@mail.gmail.com>
References: <CAAoqFdREb-auZ90-w20adi8vrBSisFrZcVCREBDZwgjS0OK7dA@mail.gmail.com>
	<52E161A8.4070908@voxpopuli.im>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1389958378=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f195.google.com ([209.85.223.195])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <krishanthtj@gmail.com>) id 1W6hDM-0008UQ-Cb
	for lttng-dev@lists.lttng.org; Fri, 24 Jan 2014 08:54:37 -0500
Received: by mail-ie0-f195.google.com with SMTP id tp5so1095393ieb.10
	for <lttng-dev@lists.lttng.org>; Fri, 24 Jan 2014 05:54:26 -0800 (PST)
In-Reply-To: <52E161A8.4070908@voxpopuli.im>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Alexandre Montplaisir <alexmonthy@voxpopuli.im>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1389958378==
Content-Type: multipart/alternative; boundary=bcaec517aa5a3ba0a604f0b7b2b2

--bcaec517aa5a3ba0a604f0b7b2b2
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have confirmed that the "lttng-modules-dkms" package was successfully
installed.

$ cat /usr/src/lttng-modules-2.3.x+stable/ChangeLog | head -4
2013-09-28 LTTng modules 2.3.2
    * Blacklist kernels 3.10.13 and 3.11.2

I have even confirmed with few debug printk's in lttng_statedump.ko that
the module is indeed loaded and the tracepoints are getting called. But
still babeltrace output fails to show lttng_statedump_events.

Am I missing something here?

Regards,
Krish.

--bcaec517aa5a3ba0a604f0b7b2b2
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi,<br><br></div>I have confirmed that=
 the &quot;lttng-modules-dkms&quot; package was successfully installed. <br=
><br>$ cat /usr/src/lttng-modules-2.3.x+stable/ChangeLog | head -4<br>2013-=
09-28 LTTng modules 2.3.2<br>
=A0=A0=A0 * Blacklist kernels 3.10.13 and 3.11.2<br><br></div>I have even c=
onfirmed with few debug printk&#39;s in lttng_statedump.ko that the module =
is indeed loaded and the tracepoints are getting called. But still babeltra=
ce output fails to show lttng_statedump_events.<br>
<br></div><div>Am I missing something here? <br></div><div><br></div>Regard=
s,<br></div>Krish.<br></div>

--bcaec517aa5a3ba0a604f0b7b2b2--


--===============1389958378==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1389958378==--
