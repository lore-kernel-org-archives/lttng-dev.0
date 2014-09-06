From: Ilya Mirsky <ilya.mirsky@gmail.com>
Subject: URCU use cases
Date: Sat, 6 Sep 2014 11:34:24 +0300
Message-ID: <CANRvXTM__Z4M2zThuz4+jUUGowd7QFWL79M2gYD9txwcbHZnKA__47172.574295155$1409992550$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1391177165=="
Return-path: <lttng-dev-bounces@lists.lttng.org>
Received: from mail-vc0-f181.google.com ([209.85.220.181])
 by ltt.polymtl.ca with esmtp (Exim 4.80)
 (envelope-from <ilya.mirsky@gmail.com>) id 1XQBSg-0006Zl-3V
 for lttng-dev@lists.lttng.org; Sat, 06 Sep 2014 04:35:10 -0400
Received: by mail-vc0-f181.google.com with SMTP id ij19so44591vcb.12
 for <lttng-dev@lists.lttng.org>; Sat, 06 Sep 2014 01:35:04 -0700 (PDT)
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

--===============1391177165==
Content-Type: multipart/alternative; boundary=089e01634bf05a885b05026176ef

--089e01634bf05a885b05026176ef
Content-Type: text/plain; charset=UTF-8

Hi,

Studying the API of URCU it seems that it's mostly intended for link-based
data structures, such a lists. Suppose I have a large struct that is often
accessed by many readers, and some writers that occasionally update few
fields each time. If I understand correctly, using URCU, the writers would
have to make a copy of the struct on each write, make the changes, and then
publish the updated version. This is wasteful for small updates to a large
struct.

Am I missing something here? Is there a better way of doing this?

Thanks,
Ilya

--089e01634bf05a885b05026176ef
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>Studying the API of URCU it seems t=
hat it&#39;s mostly intended for link-based data structures, such a lists. =
Suppose I have a large struct that is often accessed by many readers, and s=
ome writers that occasionally update few fields each time. If I understand =
correctly, using URCU, the writers would have to make a copy of the struct =
on each write, make the changes, and then publish the updated version. This=
 is wasteful for small updates to a large struct.</div><div><br></div><div>=
Am I missing something here? Is there a better way of doing this?</div><div=
><br></div><div>Thanks,</div><div>Ilya</div></div>

--089e01634bf05a885b05026176ef--


--===============1391177165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lttng-dev mailing list
lttng-dev@lists.lttng.org
http://lists.lttng.org/cgi-bin/mailman/listinfo/lttng-dev

--===============1391177165==--
