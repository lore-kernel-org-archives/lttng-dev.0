From: Willy Lambert <lambert.willy@gmail.com>
Subject: Building LTTNG as a debian package
Date: Fri, 22 Nov 2013 00:24:09 +0100
Message-ID: <CAKvQZ_3Kus-9FnXmn_qJtVux_U+U5nPUis2es_Ws0NeMXxWqpQ__31351.4832211242$1385076306$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1619809872=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <lambert.willy@gmail.com>) id 1Vjdbb-0007hZ-33
	for lttng-dev@lists.lttng.org; Thu, 21 Nov 2013 18:24:17 -0500
Received: by mail-ie0-f179.google.com with SMTP id x13so855896ief.38
	for <lttng-dev@lists.lttng.org>; Thu, 21 Nov 2013 15:24:09 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
	<mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1619809872==
Content-Type: multipart/alternative; boundary=047d7bd7679ad721fd04ebb831e4

--047d7bd7679ad721fd04ebb831e4
Content-Type: text/plain; charset=ISO-8859-1

Hi all,

I have successfully build an embedded target with the LTTNG toolset and I'm
now trying to package this to be able to repopulate a target from scratch.

I'm starting with the kernel modules and I did not succeed in building them
with make-kpkg modules_images.

As I have seen you produce Debian packages for recent distributions, I
wonder if your packaging architecture is available somewhere (I had q quick
look on git but debian packaging infrastructure isn't present).

Or maybe is there any documentation on this ?

Regards.

--047d7bd7679ad721fd04ebb831e4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Hi all,<br><br></div>I have successful=
ly build an embedded target with the LTTNG toolset and I&#39;m now trying t=
o package this to be able to repopulate a target from scratch.<br><br></div=
>
I&#39;m starting with the kernel modules and I did not succeed in building =
them with make-kpkg modules_images. <br><br></div>As I have seen you produc=
e Debian packages for recent distributions, I wonder if your packaging arch=
itecture is available somewhere (I had q quick look on git but debian packa=
ging infrastructure isn&#39;t present).<br>
<br></div>Or maybe is there any documentation on this ?<br><br>Regards.<br>=
<div><div>=A0</div></div></div>

--047d7bd7679ad721fd04ebb831e4--


--===============1619809872==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1619809872==--
