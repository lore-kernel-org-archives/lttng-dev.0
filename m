From: Eugene Ivanov <eiva@tbricks.com>
Subject: Question about URCU implementation: single global RCU
 "lock" VS per object RCU "locks"
Date: Fri, 28 Nov 2014 13:36:47 +0400
Message-ID: <CAF1eGnTuk98YSAmkcT5k=CXW_srv82fwkhst1QGh__dUuZ3riQ__48008.8510354564$1417167457$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2105396194=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-qg0-f50.google.com ([209.85.192.50])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <eiva@tbricks.com>) id 1XuHyv-00069p-72
 for lttng-dev@lists.lttng.org; Fri, 28 Nov 2014 04:36:55 -0500
Received: by mail-qg0-f50.google.com with SMTP id i50so4574578qgf.9
 for <lttng-dev@lists.lttng.org>; Fri, 28 Nov 2014 01:36:47 -0800 (PST)
List-Unsubscribe: <http://lists.lttng.org/cgi-bin/mailman/options/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=unsubscribe>
List-Archive: <http://lists.lttng.org/pipermail/lttng-dev/>
List-Post: <mailto:lttng-dev@lists.lttng.org>
List-Help: <mailto:lttng-dev-request@lists.lttng.org?subject=help>
List-Subscribe: <http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev>,
 <mailto:lttng-dev-request@lists.lttng.org?subject=subscribe>
Errors-To: lttng-dev-bounces@lists.lttng.org
To: "lttng-dev@lists.lttng.org" <lttng-dev@lists.lttng.org>
List-Id: lttng-dev@lists.lttng.org

--===============2105396194==
Content-Type: multipart/alternative; boundary=001a11c2be42edc7b80508e7ff5b

--001a11c2be42edc7b80508e7ff5b
Content-Type: text/plain; charset=UTF-8

Hi,

All RCU flavors seem to use single common global counter, thread list, etc
(to be precisely it seems that rcu_*lock is a single per-process "lock").
So if I use multiple data structures, i.e. rculfhashes, I protect them via
single shared RCU "lock". In case of QSBR it looks problematic: reclamation
of objects from object A depends on QS of threads which use another
objects. What is the reason of such design? Especially in comparison with
per-object RCU primitives. Any performance implications?

-- 
Eugene

--001a11c2be42edc7b80508e7ff5b
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>All RCU flavors seem to use single =
common global counter, thread list, etc (to be precisely it seems that rcu_=
*lock is a single per-process &quot;lock&quot;). So if I use multiple data =
structures, i.e. rculfhashes, I protect them via single shared RCU &quot;lo=
ck&quot;. In case of QSBR it looks problematic: reclamation of objects from=
 object A depends on QS of threads which use another objects. What is the r=
eason of such design? Especially in comparison with per-object RCU primitiv=
es. Any performance implications?<div><br></div>-- <br><div class=3D"gmail_=
signature"><div dir=3D"ltr">Eugene</div></div>
</div></div>

--001a11c2be42edc7b80508e7ff5b--


--===============2105396194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============2105396194==--
