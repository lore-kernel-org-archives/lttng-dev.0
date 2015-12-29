From: John Smith <whalajam@gmail.com>
Subject: lttng -q option doesn't work for "stop" and "destroy"
	commands
Date: Mon, 28 Dec 2015 16:46:13 -0800
Message-ID: <CANgVouU3QAHUF6X1TSnAgc6ppXr3+uVntjiZNFk+PgpHBHCzMw__11987.324714619$1451927842$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1869772418=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <whalajam@gmail.com>) id 1aDiQd-0001wW-CO
 for lttng-dev@lists.lttng.org; Mon, 28 Dec 2015 19:46:20 -0500
Received: by mail-ig0-f182.google.com with SMTP id to4so153731587igc.0
 for <lttng-dev@lists.lttng.org>; Mon, 28 Dec 2015 16:46:19 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1869772418==
Content-Type: multipart/alternative; boundary=089e0112cfb0a268ce0527febfa9

--089e0112cfb0a268ce0527febfa9
Content-Type: text/plain; charset=UTF-8

-q (quiet) option doesn't work for stop and destroy commands:

$ lttng stop x
Error: Session name not found
$ lttng -q stop x
Error: Session name not found
$ lttng destroy x
Error: Session name x not found
$ lttng -q destroy x
Error: Session name x not found

thanks, John

--089e0112cfb0a268ce0527febfa9
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>-q (quiet) option doesn&#39;t work for stop and destr=
oy commands:</div><div><br></div><div>$ lttng stop x<br>Error: Session name=
 not found<br>$ lttng -q stop x<br>Error: Session name not found<br>$ lttng=
 destroy x<br>Error: Session name x not found<br>$ lttng -q destroy x<br>Er=
ror: Session name x not found</div><div><br></div><div>thanks, John<br></di=
v></div>

--089e0112cfb0a268ce0527febfa9--


--===============1869772418==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1869772418==--
