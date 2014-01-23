From: Krishanth TJ <krishanthtj@gmail.com>
Subject: Lttng state dump traces not present in 13.04 Ubuntu
	server distribution
Date: Thu, 23 Jan 2014 16:00:58 +0530
Message-ID: <CAAoqFdREb-auZ90-w20adi8vrBSisFrZcVCREBDZwgjS0OK7dA__19566.3442755633$1390500973$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0407848259=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f193.google.com ([209.85.213.193])
	by ltt.polymtl.ca with esmtp (Exim 4.72)
	(envelope-from <krishanthtj@gmail.com>) id 1W6Heb-0003pC-I5
	for lttng-dev@lists.lttng.org; Thu, 23 Jan 2014 05:36:58 -0500
Received: by mail-ig0-f193.google.com with SMTP id c10so704851igq.0
	for <lttng-dev@lists.lttng.org>; Thu, 23 Jan 2014 02:36:52 -0800 (PST)
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

--===============0407848259==
Content-Type: multipart/alternative; boundary=001a1134b50eb71d6d04f0a0bcb0

--001a1134b50eb71d6d04f0a0bcb0
Content-Type: text/plain; charset=ISO-8859-1

Dear All,

Recently when I tried to use lttng on Ubuntu 13.04 server distribution, I
noticed that statedump traces were not present.

Installed lttng-tools, lttng-modules-dkms, babeltrace from

deb http://ppa.launchpad.net/lttng/ppa/ubuntu raring main
deb-src http://ppa.launchpad.net/lttng/ppa/ubuntu raring main

Version:

lttng version 2.3.0
babeltrace 1.0.3

The procedure followed was

# lttng create newsession

# lttng enable-event -a -k

# lttng start

# Do something

# lttng stop

# lttng destroy

# babeltrace <session>

Any help would be appreciated.

Noticed that 3.2.0-39-generic has statedump traces.

Regards,
Krish.

--001a1134b50eb71d6d04f0a0bcb0
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Dear All,<br><br></div>Recently when I=
 tried to use lttng on Ubuntu 13.04 server distribution, I noticed that sta=
tedump traces were not present. <br><br></div>Installed lttng-tools, lttng-=
modules-dkms, babeltrace from <br>
<br><pre id=3D"sources-list-entries" class=3D"">deb <a href=3D"http://ppa.l=
aunchpad.net/lttng/ppa/ubuntu">http://ppa.launchpad.net/lttng/ppa/ubuntu</a=
> <span id=3D"series-deb">raring</span> main=20
deb-src <a href=3D"http://ppa.launchpad.net/lttng/ppa/ubuntu">http://ppa.la=
unchpad.net/lttng/ppa/ubuntu</a> <span id=3D"series-deb-src">raring</span> =
main <br><br></pre><pre id=3D"sources-list-entries" class=3D"">Version:<br>=
<br>
lttng version 2.3.0<br>babeltrace 1.0.3<br></pre><pre id=3D"sources-list-en=
tries" class=3D"">The procedure followed was<br><br></pre><pre id=3D"source=
s-list-entries" class=3D""># lttng create newsession<br></pre><pre id=3D"so=
urces-list-entries" class=3D"">
# lttng enable-event -a -k<br></pre><pre id=3D"sources-list-entries" class=
=3D""># lttng start<br></pre><pre id=3D"sources-list-entries" class=3D""># =
Do something<br></pre><pre id=3D"sources-list-entries" class=3D""></pre><pr=
e id=3D"sources-list-entries" class=3D"">
# lttng stop<br></pre><pre id=3D"sources-list-entries" class=3D""># lttng d=
estroy<br></pre><pre id=3D"sources-list-entries" class=3D""># babeltrace &l=
t;session&gt;<br></pre>Any help would be appreciated.<br><br></div><div>Not=
iced that 3.2.0-39-generic has statedump traces.<br>
</div><div><br></div>Regards,<br></div>Krish.<br></div>

--001a1134b50eb71d6d04f0a0bcb0--


--===============0407848259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============0407848259==--
