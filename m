From: Michel Dagenais <michel.dagenais@polymtl.ca>
Subject: Re: URCU use cases
Date: Sat, 6 Sep 2014 09:18:02 -0400 (EDT)
Message-ID: <2038780079.12468624.1410009481977.JavaMail.root__19389.3813681372$1410009548$gmane$org@polymtl.ca>
References: <CANRvXTM__Z4M2zThuz4+jUUGowd7QFWL79M2gYD9txwcbHZnKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1821445456=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from smtp.polymtl.ca ([132.207.4.11])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <michel.dagenais@polymtl.ca>) id 1XQFsd-0008K9-RC
 for lttng-dev@lists.lttng.org; Sat, 06 Sep 2014 09:18:16 -0400
In-Reply-To: <CANRvXTM__Z4M2zThuz4+jUUGowd7QFWL79M2gYD9txwcbHZnKA@mail.gmail.com>
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: Ilya Mirsky <ilya.mirsky@gmail.com>
Cc: lttng-dev@lists.lttng.org
List-Id: lttng-dev@lists.lttng.org

--===============1821445456==
Content-Type: multipart/alternative;
	boundary="----=_Part_12468623_1711131808.1410009481976"

------=_Part_12468623_1711131808.1410009481976
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

> Studying the API of URCU it seems that it's mostly intended for
> link-based data structures, such a lists. Suppose I have a large
> struct that is often accessed by many readers, and some writers that
> occasionally update few fields each time. If I understand correctly,
> using URCU, the writers would have to make a copy of the struct on
> each write, make the changes, and then publish the updated version.
> This is wasteful for small updates to a large struct.
RCU / URCU is efficient for read-mostly structures. In that case, copying a large struct may not be such a problem since it is infrequent. You also have the option of splitting the structure into smaller independently updated ones. 
------=_Part_12468623_1711131808.1410009481976
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D'text/css'>p { margin: 0; }</style></head><body><=
div style=3D'font-family: times new roman,new york,times,serif; font-size: =
12pt; color: #000000'><blockquote style=3D"color: rgb(0, 0, 0); font-family=
: Helvetica, Arial, sans-serif; font-size: 12pt; border-left-width: 2px; bo=
rder-left-style: solid; border-left-color: rgb(16, 16, 255); margin-left: 5=
px; padding-left: 5px; font-weight: normal; font-style: normal; text-decora=
tion: none;"><div dir=3D"ltr"><div></div><div id=3D"DWT153">Studying the AP=
I of URCU it seems that it's mostly intended for link-based data structures=
, such a lists. Suppose I have a large struct that is often accessed by man=
y readers, and some writers that occasionally update few fields each time. =
If I understand correctly, using URCU, the writers would have to make a cop=
y of the struct on each write, make the changes, and then publish the updat=
ed version. This is wasteful for small updates to a large struct.</div></di=
v></blockquote><font face=3D"Helvetica, Arial, sans-serif">RCU / URCU is ef=
ficient for read-mostly structures. In that case, copying a large struct ma=
y not be such a problem since it is infrequent. You also have the option of=
 splitting the structure into smaller independently updated ones.</font><bl=
ockquote style=3D"color: rgb(0, 0, 0); font-family: Helvetica, Arial, sans-=
serif; font-size: 12pt; border-left-width: 2px; border-left-style: solid; b=
order-left-color: rgb(16, 16, 255); margin-left: 5px; padding-left: 5px; fo=
nt-weight: normal; font-style: normal; text-decoration: none;"><div dir=3D"=
ltr"><div></div></div></blockquote></div></body></html>
------=_Part_12468623_1711131808.1410009481976--


--===============1821445456==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1821445456==--
